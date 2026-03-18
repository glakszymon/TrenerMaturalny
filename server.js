/**
 * ============================================================
 *  Matura Informatyka – Backend API
 *  Node.js / Express / MariaDB v2 (CommonJS)
 * ============================================================
 */
'use strict';

const express        = require('express');
const cors           = require('cors');
const mariadb        = require('mariadb');
const { execFile, spawn } = require('child_process');
const fs             = require('fs');
const path           = require('path');
const os             = require('os');

/* better-sqlite3 – ładowane raz, nie przy każdym żądaniu */
let Database = null;
try { Database = require('better-sqlite3'); }
catch(_) { console.warn('OSTRZEŻENIE: brak modułu better-sqlite3 – endpoint /api/sql/submit nie będzie działał. Uruchom: npm install better-sqlite3'); }

const app  = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json({ limit: '1mb' }));
app.use(express.static(__dirname));

/* ── MariaDB pool (v2 – CommonJS compatible) ── */
const pool = mariadb.createPool({
  host:            process.env.DB_HOST     || '127.0.0.1',
  port:            parseInt(process.env.DB_PORT || '3306'),
  user:            process.env.DB_USER     || 'root',
  password:        process.env.DB_PASSWORD || '0000',
  database:        process.env.DB_NAME     || 'matura_db',
  connectionLimit: 10,
  acquireTimeout:  10000,
  bigIntAsNumber:  true
});

async function db(sql, params) {
  let conn;
  try {
    conn = await pool.getConnection();
    return await conn.query(sql, params || []);
  } finally {
    if (conn) conn.end();
  }
}

/* ── Auto-migracja: dodaj nowe kolumny jeśli ich brakuje ── */
async function runMigrations() {
  const migrations = [
    // duration_ms w algo_attempts — czas pracy nad zadaniem ze stopera
    `ALTER TABLE algo_attempts ADD COLUMN IF NOT EXISTS duration_ms INT DEFAULT 0`,
    // solution w algo_tasks — wzorcowe rozwiązanie C++
    `ALTER TABLE algo_tasks ADD COLUMN IF NOT EXISTS solution MEDIUMTEXT DEFAULT NULL`,
    // tabela pytań quizowych
    `CREATE TABLE IF NOT EXISTS quiz_questions (
      id           INT AUTO_INCREMENT PRIMARY KEY,
      category     VARCHAR(100) NOT NULL,
      question     TEXT NOT NULL,
      answer_full  TEXT,
      opt_a        TEXT NOT NULL,
      opt_b        TEXT NOT NULL,
      opt_c        TEXT NOT NULL,
      opt_d        TEXT NOT NULL,
      correct      TINYINT(1) NOT NULL DEFAULT 0,
      is_active    TINYINT(1) DEFAULT 1,
      created_at   DATETIME DEFAULT CURRENT_TIMESTAMP
    )`,
  ];
  for (const sql of migrations) {
    try { await db(sql); }
    catch (e) { console.warn('Migration skip:', e.message.slice(0, 80)); }
  }
}

async function ensureSession(sid) {
  if (!sid || typeof sid !== 'string' || sid.length > 64) return;
  await db('INSERT IGNORE INTO sessions (session_id) VALUES (?)', [sid]);
}

/* ── C++ runner ── */
const COMPILE_MS = 10000;
const RUN_MS     = 3000;
const MAX_CODE   = 64000;

function norm(s) { return (s || '').replace(/\r/g, '').trim(); }

function compileCpp(code) {
  return new Promise(resolve => {
    const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'matura-'));
    const src = path.join(dir, 'sol.cpp');
    const bin = path.join(dir, 'sol');
    fs.writeFileSync(src, code, 'utf8');
    execFile('g++', ['-O2', '-std=c++17', '-o', bin, src, '-lm', '-DONLINE_JUDGE'],
      { timeout: COMPILE_MS },
      (err, _out, stderr) => {
        if (err) resolve({ ok: false, error: stderr || err.message, dir });
        else     resolve({ ok: true, bin, dir });
      });
  });
}

function runBin(bin, input) {
  return new Promise(resolve => {
    const t0 = Date.now();
    const child = spawn(bin, [], { timeout: RUN_MS, killSignal: 'SIGKILL' });
    let out = '', err = '';
    child.stdout.on('data', d => { out += d.toString(); });
    child.stderr.on('data', d => { err += d.toString(); });
    child.on('close', (_c, sig) => resolve({
      stdout: out, stderr: err,
      time_ms: Date.now() - t0,
      timedOut: sig === 'SIGKILL'
    }));
    child.stdin.write(input || '');
    child.stdin.end();
  });
}

function cleanup(dir) {
  try { fs.rmSync(dir, { recursive: true, force: true }); } catch (_) {}
}

/* ── Routes ── */

app.get('/api/health', async (_req, res) => {
  try { await db('SELECT 1'); res.json({ ok: true, db: 'connected', node: process.version }); }
  catch (e) { res.status(500).json({ ok: false, error: e.message }); }
});

app.get('/api/tasks', async (_req, res) => {
  try {
    const tasks = await db(
      'SELECT id, title, difficulty, description, hint, ex_input, ex_output, solution FROM algo_tasks WHERE is_active=1 ORDER BY id'
    );
    const tests = await db(
      'SELECT task_id, test_name, input_data, expected FROM algo_task_tests WHERE is_hidden=0 ORDER BY task_id, id'
    );
    const map = {};
    for (const t of tests) {
      if (!map[t.task_id]) map[t.task_id] = [];
      map[t.task_id].push({ name: t.test_name, input: t.input_data, expected: t.expected });
    }
    res.json(tasks.map(t => ({ ...t, visible_tests: map[t.id] || [] })));
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.post('/api/algo/submit', async (req, res) => {
  const { session_id, task_id, code, run_only, duration_ms } = req.body;
  if (!code || code.length > MAX_CODE) return res.status(400).json({ error: 'Brak kodu lub za długi.' });
  if (!task_id) return res.status(400).json({ error: 'Brak task_id.' });

  let taskRow, tests;
  try {
    const rows = await db('SELECT * FROM algo_tasks WHERE id=? AND is_active=1', [task_id]);
    if (!rows.length) return res.status(404).json({ error: 'Zadanie nie istnieje.' });
    taskRow = rows[0];
    tests   = await db('SELECT * FROM algo_task_tests WHERE task_id=? ORDER BY id', [task_id]);
  } catch (e) { return res.status(500).json({ error: e.message }); }

  const comp = await compileCpp(code);

  if (!comp.ok) {
    cleanup(comp.dir);
    if (session_id && !run_only) {
      await ensureSession(session_id).catch(() => {});
      await db(
        'INSERT INTO algo_attempts (session_id, task_id, task_title, code, tests_total, tests_passed, duration_ms) VALUES (?,?,?,?,?,0,?)',
        [session_id, task_id, taskRow.title, code, tests.length, duration_ms || 0]
      ).catch(() => {});
    }
    return res.json({ compiled: false, compile_error: comp.error, tests_total: tests.length, tests_passed: 0, results: [] });
  }

  const results = [];
  try {
    for (const t of tests) {
      const run    = await runBin(comp.bin, t.input_data);
      const got    = norm(run.stdout);
      const exp    = norm(t.expected);
      const passed = !run.timedOut && got === exp;
      results.push({
        name:     t.test_name,
        hidden:   !!t.is_hidden,
        passed,
        time_ms:  run.time_ms,
        timedOut: run.timedOut,
        stderr:   run.stderr ? run.stderr.slice(0, 400) : null,  // przekaż stderr dla błędów runtime
        input:    t.is_hidden ? null : t.input_data,
        expected: t.is_hidden ? (passed ? '(ukryty – OK)' : '(ukryty – BŁĄD)') : exp,
        got:      t.is_hidden ? (passed ? '(ukryty – OK)' : '(ukryty – BŁĄD)') : got
      });
    }
  } finally {
    cleanup(comp.dir);
  }

  const passed_count = results.filter(r => r.passed).length;

  if (session_id && !run_only) {
    try {
      await ensureSession(session_id);
      const ins = await db(
        'INSERT INTO algo_attempts (session_id, task_id, task_title, code, tests_total, tests_passed, duration_ms) VALUES (?,?,?,?,?,?,?)',
        [session_id, task_id, taskRow.title, code, tests.length, passed_count, duration_ms || 0]
      );
      const attempt_id = ins.insertId;
      for (const r of results) {
        await db(
          'INSERT INTO algo_test_results (attempt_id, test_name, input_data, expected, got, passed, time_ms) VALUES (?,?,?,?,?,?,?)',
          [attempt_id, r.name, r.input, r.expected, r.got, r.passed ? 1 : 0, r.time_ms]
        );
      }
    } catch (e) { console.error('DB write algo:', e.message); }
  }

  res.json({ compiled: true, tests_total: tests.length, tests_passed: passed_count, results });
});

app.post('/api/sql/attempt', async (req, res) => {
  const { session_id, task_id, task_title, query, is_correct } = req.body;
  if (!session_id) return res.status(400).json({ error: 'Brak session_id.' });
  try {
    await ensureSession(session_id);
    await db('INSERT INTO sql_attempts (session_id,task_id,task_title,query,is_correct) VALUES (?,?,?,?,?)',
      [session_id, task_id||0, task_title||'', query||'', is_correct?1:0]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* ════════════════════════════════════════════════════════════
   QUIZ QUESTIONS – pytania quizowe z bazy danych
   ════════════════════════════════════════════════════════════ */

/* GET /api/quiz/questions – lista wszystkich aktywnych pytań */
app.get('/api/quiz/questions', async (_req, res) => {
  try {
    const rows = await db(
      'SELECT id, category, question, answer_full, opt_a, opt_b, opt_c, opt_d, correct FROM quiz_questions WHERE is_active=1 ORDER BY category, id'
    );
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* GET /api/quiz/questions/categories – lista kategorii */
app.get('/api/quiz/questions/categories', async (_req, res) => {
  try {
    const rows = await db(
      'SELECT DISTINCT category, COUNT(*) as count FROM quiz_questions WHERE is_active=1 GROUP BY category ORDER BY category'
    );
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* POST /api/quiz/questions – dodaj pytanie */
app.post('/api/quiz/questions', async (req, res) => {
  const { category, question, answer_full, opt_a, opt_b, opt_c, opt_d, correct } = req.body;
  if (!category || !question || !opt_a || !opt_b || !opt_c || !opt_d)
    return res.status(400).json({ error: 'Brak wymaganych pól pytania.' });
  const corr = parseInt(correct);
  if (isNaN(corr) || corr < 0 || corr > 3)
    return res.status(400).json({ error: 'correct musi być 0–3.' });
  try {
    const r = await db(
      'INSERT INTO quiz_questions (category, question, answer_full, opt_a, opt_b, opt_c, opt_d, correct, is_active) VALUES (?,?,?,?,?,?,?,?,1)',
      [category, question, answer_full || '', opt_a, opt_b, opt_c, opt_d, corr]
    );
    res.json({ ok: true, id: r.insertId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* PUT /api/quiz/questions/:id – edytuj pytanie */
app.put('/api/quiz/questions/:id', async (req, res) => {
  const { category, question, answer_full, opt_a, opt_b, opt_c, opt_d, correct, is_active } = req.body;
  if (!category || !question || !opt_a || !opt_b || !opt_c || !opt_d)
    return res.status(400).json({ error: 'Brak wymaganych pól pytania.' });
  const id = parseInt(req.params.id);
  if (!id || isNaN(id)) return res.status(400).json({ error: 'Nieprawidłowe id.' });
  const corr = parseInt(correct);
  if (isNaN(corr) || corr < 0 || corr > 3)
    return res.status(400).json({ error: 'correct musi być 0–3.' });
  try {
    const result = await db(
      'UPDATE quiz_questions SET category=?, question=?, answer_full=?, opt_a=?, opt_b=?, opt_c=?, opt_d=?, correct=?, is_active=? WHERE id=?',
      [category, question, answer_full || '', opt_a, opt_b, opt_c, opt_d, corr, is_active ?? 1, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Pytanie nie istnieje.' });
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* DELETE /api/quiz/questions/:id – usuń pytanie */
app.delete('/api/quiz/questions/:id', async (req, res) => {
  try {
    await db('DELETE FROM quiz_questions WHERE id=?', [req.params.id]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.post('/api/quiz/result', async (req, res) => {
  const { session_id, question_id, category, question_text, is_correct, time_ms } = req.body;
  if (!session_id) return res.status(400).json({ error: 'Brak session_id.' });
  try {
    await ensureSession(session_id);
    await db('INSERT INTO quiz_results (session_id,question_id,category,question_text,is_correct,time_ms) VALUES (?,?,?,?,?,?)',
      [session_id, question_id||0, category||'', question_text||'', is_correct?1:0, time_ms||0]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.post('/api/flashcard/seen', async (req, res) => {
  const { session_id, question_id, correct } = req.body;
  if (!session_id) return res.status(400).json({ error: 'Brak session_id.' });
  try {
    await ensureSession(session_id);
    await db(`INSERT INTO flashcard_progress (session_id,question_id,seen_count,correct_count) VALUES (?,?,1,?)
      ON DUPLICATE KEY UPDATE seen_count=seen_count+1, correct_count=correct_count+IF(?,1,0), last_seen=CURRENT_TIMESTAMP`,
      [session_id, question_id||0, correct?1:0, correct?1:0]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* GET /api/stats/detailed/:sid — per-task breakdown — MUST be before /api/stats/:sid */
app.get('/api/stats/detailed/:sid', async (req, res) => {
  const sid = req.params.sid;
  try {
    const algoPerTask = await db(`
      SELECT
        task_id, task_title,
        COUNT(*)                                                         AS attempts,
        SUM(IF(tests_passed >= tests_total AND tests_total > 0, 1, 0))  AS fully_passed,
        MAX(tests_passed)                                                AS best_passed,
        MAX(tests_total)                                                 AS tests_total,
        MAX(duration_ms)                                                 AS best_time_ms,
        MAX(attempted_at)                                                AS last_attempt
      FROM algo_attempts
      WHERE session_id = ?
      GROUP BY task_id, task_title
      ORDER BY last_attempt DESC
    `, [sid]);

    const sqlPerTask = await db(`
      SELECT
        task_id, task_title,
        COUNT(*)           AS attempts,
        SUM(is_correct)    AS correct,
        MAX(attempted_at)  AS last_attempt
      FROM sql_attempts
      WHERE session_id = ?
      GROUP BY task_id, task_title
      ORDER BY last_attempt DESC
    `, [sid]);

    const quizPerCat = await db(`
      SELECT
        category,
        COUNT(*)            AS total,
        SUM(is_correct)     AS correct,
        ROUND(AVG(time_ms)) AS avg_ms
      FROM quiz_results
      WHERE session_id = ?
      GROUP BY category
      ORDER BY total DESC
    `, [sid]);

    res.json({ algoPerTask, sqlPerTask, quizPerCat });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/stats/:sid', async (req, res) => {
  const sid = req.params.sid;
  try {
    const [quiz] = await db(
      'SELECT COUNT(*) as total, SUM(is_correct) as correct, ROUND(AVG(time_ms)) as avg_time_ms FROM quiz_results WHERE session_id=?',
      [sid]
    );
    const [algo] = await db(
      'SELECT COUNT(*) as attempts, SUM(IF(tests_passed>=tests_total AND tests_total>0,1,0)) as fully_passed FROM algo_attempts WHERE session_id=?',
      [sid]
    );
    const [sql] = await db(
      'SELECT COUNT(*) as attempts, SUM(is_correct) as correct FROM sql_attempts WHERE session_id=?',
      [sid]
    );
    const flashcards = await db(
      'SELECT question_id, seen_count, correct_count FROM flashcard_progress WHERE session_id=?',
      [sid]
    );
    res.json({ quiz, algo, sql, flashcards });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/history/algo/:sid', async (req, res) => {
  try {
    const rows = await db(
      'SELECT id, task_id, task_title, tests_total, tests_passed, attempted_at FROM algo_attempts WHERE session_id=? ORDER BY attempted_at DESC LIMIT 30',
      [req.params.sid]
    );
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/history/quiz/:sid', async (req, res) => {
  try {
    const rows = await db(
      'SELECT question_id, category, is_correct, time_ms, answered_at FROM quiz_results WHERE session_id=? ORDER BY answered_at DESC LIMIT 50',
      [req.params.sid]
    );
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* ── Start ── */
app.listen(PORT, async () => {
  console.log(`\n🎓 Matura Informatyka – http://localhost:${PORT}`);
  console.log(`   Baza: ${process.env.DB_NAME||'matura_db'} @ ${process.env.DB_HOST||'127.0.0.1'}:${process.env.DB_PORT||3306}`);
  console.log(`   Wersja: 2026-03-15`);
  console.log(`   Sprawdź: curl http://localhost:${PORT}/api/health\n`);

  // Wypisz wszystkie zarejestrowane endpointy API (diagnostyka)
  const routes = app._router.stack
    .filter(r => r.route)
    .map(r => `   ${Object.keys(r.route.methods)[0].toUpperCase().padEnd(6)} ${r.route.path}`);
  console.log('   Endpointy:\n' + routes.join('\n'));

  await runMigrations();
  console.log('\n   Migracje: OK\n');
});

/* ============================================================
   ADMIN ENDPOINTS – CRUD zadań i testów
============================================================ */

/* POST /api/tasks – dodaj nowe zadanie */
app.post('/api/tasks', async (req, res) => {
  const { title, difficulty, description, hint, ex_input, ex_output, solution } = req.body;
  if (!title || !description) return res.status(400).json({ error: 'Brak tytułu lub opisu.' });
  try {
    const r = await db(
      'INSERT INTO algo_tasks (title, difficulty, description, hint, ex_input, ex_output, solution, is_active) VALUES (?,?,?,?,?,?,?,1)',
      [title, difficulty || 'easy', description, hint || '', ex_input || '', ex_output || '', solution || null]
    );
    res.json({ ok: true, id: r.insertId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* PUT /api/tasks/:id – edytuj zadanie */
app.put('/api/tasks/:id', async (req, res) => {
  const { title, difficulty, description, hint, ex_input, ex_output, solution } = req.body;
  if (!title || !description) return res.status(400).json({ error: 'Brak tytułu lub opisu.' });
  const id = parseInt(req.params.id);
  if (!id || isNaN(id)) return res.status(400).json({ error: 'Nieprawidłowe id.' });
  try {
    const result = await db(
      'UPDATE algo_tasks SET title=?, difficulty=?, description=?, hint=?, ex_input=?, ex_output=?, solution=? WHERE id=?',
      [title, difficulty || 'easy', description, hint || '', ex_input || '', ex_output || '', solution || null, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Zadanie nie istnieje.' });
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* DELETE /api/tasks/:id – usuń zadanie (kaskadowo usuwa testy) */
app.delete('/api/tasks/:id', async (req, res) => {
  try {
    await db('DELETE FROM algo_tasks WHERE id=?', [req.params.id]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* GET /api/admin/tests – lista wszystkich testów (opcjonalnie filtr task_id) */
app.get('/api/admin/tests', async (req, res) => {
  try {
    const tid  = req.query.task_id;
    const rows = tid
      ? await db('SELECT * FROM algo_task_tests WHERE task_id=? ORDER BY task_id, id', [tid])
      : await db('SELECT * FROM algo_task_tests ORDER BY task_id, id');
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* POST /api/admin/tests – dodaj test */
app.post('/api/admin/tests', async (req, res) => {
  const { task_id, test_name, input_data, expected, is_hidden } = req.body;
  if (!task_id)   return res.status(400).json({ error: 'Brak task_id.' });
  if (!test_name) return res.status(400).json({ error: 'Brak nazwy testu.' });
  try {
    const r = await db(
      'INSERT INTO algo_task_tests (task_id, test_name, input_data, expected, is_hidden) VALUES (?,?,?,?,?)',
      [task_id, test_name, input_data || '', expected || '', is_hidden || 0]
    );
    res.json({ ok: true, id: r.insertId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* DELETE /api/admin/tests/:id – usuń test */
app.delete('/api/admin/tests/:id', async (req, res) => {
  try {
    await db('DELETE FROM algo_task_tests WHERE id=?', [req.params.id]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* GET /api/history/sql/:sid – historia SQL */
app.get('/api/history/sql/:sid', async (req, res) => {
  try {
    const rows = await db(
      'SELECT task_id,task_title,query,is_correct,attempted_at FROM sql_attempts WHERE session_id=? ORDER BY attempted_at DESC LIMIT 50',
      [req.params.sid]
    );
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});
/* ════════════════════════════════════════════════════════════
   SQL TASKS – nowy system z bazą MariaDB i SQLite runner
   ════════════════════════════════════════════════════════════ */

/* GET /api/sql/tasks – scenariusze z zadaniami (solution included for DB panel) */
app.get('/api/sql/tasks', async (_req, res) => {
  try {
    const scenarios = await db('SELECT id, name, description, ddl, seed FROM sql_scenarios WHERE is_active=1 ORDER BY id');
    const tasks     = await db('SELECT id, scenario_id, title, difficulty, description, hint, solution FROM sql_tasks WHERE is_active=1 ORDER BY id');
    const map = {};
    for (const t of tasks) {
      if (!map[t.scenario_id]) map[t.scenario_id] = [];
      map[t.scenario_id].push(t);
    }
    res.json(scenarios.map(s => ({ ...s, tasks: map[s.id] || [] })));
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* GET /api/sql/scenarios – lista scenariuszy (z DDL/seed, dla panelu DB) */
app.get('/api/sql/scenarios', async (_req, res) => {
  try {
    const rows = await db('SELECT id, name, description, ddl, seed, is_active FROM sql_scenarios ORDER BY id');
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* POST /api/sql/scenarios – dodaj scenariusz */
app.post('/api/sql/scenarios', async (req, res) => {
  const { name, description, ddl, seed, is_active } = req.body;
  if (!name || !ddl) return res.status(400).json({ error: 'Brak nazwy lub DDL.' });
  try {
    const r = await db(
      'INSERT INTO sql_scenarios (name, description, ddl, seed, is_active) VALUES (?,?,?,?,?)',
      [name, description || '', ddl, seed || '', is_active ?? 1]
    );
    res.json({ ok: true, id: r.insertId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* PUT /api/sql/scenarios/:id – edytuj scenariusz */
app.put('/api/sql/scenarios/:id', async (req, res) => {
  const { name, description, ddl, seed, is_active } = req.body;
  if (!name || !ddl) return res.status(400).json({ error: 'Brak nazwy lub DDL.' });
  const id = parseInt(req.params.id);
  if (!id || isNaN(id)) return res.status(400).json({ error: 'Nieprawidłowe id.' });
  try {
    const result = await db(
      'UPDATE sql_scenarios SET name=?, description=?, ddl=?, seed=?, is_active=? WHERE id=?',
      [name, description || '', ddl, seed || '', is_active ?? 1, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Scenariusz nie istnieje.' });
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* DELETE /api/sql/scenarios/:id – usuń scenariusz (kaskadowo usuwa zadania) */
app.delete('/api/sql/scenarios/:id', async (req, res) => {
  try {
    await db('DELETE FROM sql_scenarios WHERE id=?', [req.params.id]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* POST /api/sql/tasks – dodaj zadanie SQL */
app.post('/api/sql/tasks', async (req, res) => {
  const { scenario_id, title, difficulty, description, hint, solution } = req.body;
  if (!scenario_id || !title || !description || !solution)
    return res.status(400).json({ error: 'Brak scenariusza, tytułu, opisu lub rozwiązania.' });
  try {
    const r = await db(
      'INSERT INTO sql_tasks (scenario_id, title, difficulty, description, hint, solution, is_active) VALUES (?,?,?,?,?,?,1)',
      [scenario_id, title, difficulty || 'hard', description, hint || '', solution]
    );
    res.json({ ok: true, id: r.insertId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* PUT /api/sql/tasks/:id – edytuj zadanie SQL */
app.put('/api/sql/tasks/:id', async (req, res) => {
  const { scenario_id, title, difficulty, description, hint, solution } = req.body;
  if (!title || !description || !solution)
    return res.status(400).json({ error: 'Brak tytułu, opisu lub rozwiązania.' });
  const id = parseInt(req.params.id);
  if (!id || isNaN(id)) return res.status(400).json({ error: 'Nieprawidłowe id.' });
  try {
    const result = await db(
      'UPDATE sql_tasks SET scenario_id=?, title=?, difficulty=?, description=?, hint=?, solution=? WHERE id=?',
      [scenario_id, title, difficulty || 'hard', description, hint || '', solution, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Zadanie nie istnieje.' });
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* DELETE /api/sql/tasks/:id – usuń zadanie SQL */
app.delete('/api/sql/tasks/:id', async (req, res) => {
  try {
    await db('DELETE FROM sql_tasks WHERE id=?', [req.params.id]);
    res.json({ ok: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

/* POST /api/sql/submit – wykonaj i sprawdź zapytanie ucznia */
app.post('/api/sql/submit', async (req, res) => {
  const { session_id, task_id, query } = req.body;
  if (!query || !task_id) return res.status(400).json({ error: 'Brak zapytania lub task_id.' });
  if (/^\s*(DROP|ALTER|CREATE|INSERT|UPDATE|DELETE|TRUNCATE|REPLACE|ATTACH|PRAGMA)\b/i.test(query))
    return res.status(400).json({ error: 'Tylko SELECT jest dozwolone.' });

  let taskRow;
  try {
    const rows = await db(
      'SELECT t.id,t.title,t.solution,s.ddl,s.seed FROM sql_tasks t JOIN sql_scenarios s ON t.scenario_id=s.id WHERE t.id=? AND t.is_active=1',
      [task_id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Zadanie nie istnieje.' });
    taskRow = rows[0];
  } catch (e) { return res.status(500).json({ error: e.message }); }

  /* Uruchom SQLite in-memory */
  if (!Database) return res.status(500).json({ error: 'Brak modułu better-sqlite3. Uruchom: npm install better-sqlite3' });

  let userRows=[], refRows=[], userCols=[], refCols=[], errMsg=null, queryTimeMs=0;

  try {
    const sqliteDb = new Database(':memory:');
    const stmts = (taskRow.ddl + '\n' + taskRow.seed).split(';').map(s => s.trim()).filter(Boolean);
    for (const s of stmts) {
      try { sqliteDb.exec(s); }
      catch (e) { console.warn('SQLite setup warning [task %d]:', task_id, e.message); }
    }

    // wzorzec
    const refAll = sqliteDb.prepare(taskRow.solution).all();
    refCols = refAll.length > 0 ? Object.keys(refAll[0]) : [];
    refRows = refAll.map(r => refCols.map(c => (r[c] !== null && r[c] !== undefined) ? String(r[c]) : null));

    // zapytanie ucznia — mierzymy czas wykonania
    try {
      const t0 = Date.now();
      const userAll = sqliteDb.prepare(query).all();
      queryTimeMs = Date.now() - t0;
      userCols = userAll.length > 0 ? Object.keys(userAll[0]) : [];
      userRows = userAll.map(r => userCols.map(c => (r[c] !== null && r[c] !== undefined) ? String(r[c]) : null));
    } catch (e) { errMsg = e.message; }

    sqliteDb.close();
  } catch (e) { return res.status(500).json({ error: 'Błąd SQLite: ' + e.message }); }

  // porównanie — uniezależnione od kolejności kolumn
  let passed = false;
  if (!errMsg) {
    if (userRows.length === 0 && refRows.length === 0) {
      // oba zwróciły 0 wierszy — traktuj jako poprawne
      passed = true;
    } else if (userRows.length === refRows.length && userRows.length > 0) {
      // Porównaj po nazwach kolumn (kolejność kolumn nie ma znaczenia)
      passed = userRows.every((row, i) => {
        return userCols.every((col, j) => {
          const refIdx = refCols.indexOf(col);
          if (refIdx === -1) return false;            // kolumna nie istnieje w wzorcu
          const u = row[j]    === null ? null : String(row[j]).trim().toLowerCase();
          const r = refRows[i][refIdx] === null ? null : String(refRows[i][refIdx]).trim().toLowerCase();
          if (u === r) return true;
          const un = parseFloat(u), rn = parseFloat(r);
          return !isNaN(un) && !isNaN(rn) && Math.abs(un - rn) < 0.05;
        });
      }) && userCols.length === refCols.length;
    }
  }

  if (session_id) {
    ensureSession(session_id).then(() =>
      db(
        'INSERT INTO sql_attempts (session_id, task_id, task_title, query, is_correct, task_id_ref, scenario_id, error_msg) VALUES (?,?,?,?,?,?,?,?)',
        [session_id, task_id, taskRow.title, query, passed ? 1 : 0, task_id, taskRow.scenario_id || null, errMsg || null]
      )
    ).catch(() => {});
  }

  res.json({
    passed,
    error:          errMsg,
    time_ms:        queryTimeMs,
    user_rows:      userRows,
    user_cols:      userCols,
    ref_rows:       passed ? null : refRows,
    ref_cols:       passed ? null : refCols,
    row_count:      userRows.length,
    expected_count: refRows.length,
  });
});