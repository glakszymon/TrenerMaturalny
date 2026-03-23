/**
 * apply_patch.js — Surgical live DB patch for TrenerMaturalny
 *
 * Fixes:
 *   B1: Remove duplicate algo_task_tests (IDs 507–635)
 *   B2: Remove duplicate quiz_questions (IDs 109–216)
 *   B3: Update all wrong/NULL algo_tasks solutions from dane.sql
 *   B4: Insert test cases for task 15 (Euklidesa rekurencyjna)
 *
 * Usage: node apply_patch.js [--dry-run]
 */

const fs   = require('fs');
const mariadb = require('mariadb');

const DRY_RUN = process.argv.includes('--dry-run');

/* ── DB connection ── */
const pool = mariadb.createPool({
  host:     '127.0.0.1',
  port:     3306,
  user:     'root',
  password: '0000',
  database: 'matura_db',
  connectionLimit: 2,
  bigIntAsNumber: true
});

/* ── Parse SQL string value starting at position pos (after the opening quote) ── */
function parseSQLString(sql, startPos) {
  let pos = startPos;
  let value = '';
  while (pos < sql.length) {
    if (sql[pos] === "'" && sql[pos + 1] === "'") {
      value += "'";
      pos += 2;
    } else if (sql[pos] === "'") {
      pos++; // closing quote
      return { value, endPos: pos };
    } else {
      value += sql[pos];
      pos++;
    }
  }
  throw new Error(`Unterminated SQL string starting near position ${startPos}`);
}

/* ── Parse a single SQL value (string, number, or NULL) at position pos ── */
function parseSQLValue(sql, pos) {
  // Skip whitespace
  while (pos < sql.length && /\s/.test(sql[pos])) pos++;

  if (sql[pos] === "'") {
    pos++; // skip opening quote
    const result = parseSQLString(sql, pos);
    return { value: result.value, endPos: result.endPos };
  } else if (sql.substring(pos, pos + 4) === 'NULL') {
    return { value: null, endPos: pos + 4 };
  } else {
    // Numeric
    let num = '';
    while (pos < sql.length && /[0-9.\-]/.test(sql[pos])) {
      num += sql[pos];
      pos++;
    }
    return { value: num, endPos: pos };
  }
}

/* ── Extract algo_tasks records from dane.sql ── */
function extractAlgoTasks(sql) {
  const tasks = [];
  const header = 'INSERT INTO matura_db.algo_tasks (title,difficulty,description,hint,ex_input,ex_output,is_active,created_at,solution) VALUES';
  let searchFrom = 0;

  while (true) {
    const blockIdx = sql.indexOf(header, searchFrom);
    if (blockIdx === -1) break;

    let pos = blockIdx + header.length;

    // Parse records from this block
    while (pos < sql.length) {
      // Skip whitespace
      while (pos < sql.length && /\s/.test(sql[pos])) pos++;

      if (sql[pos] !== '(') break;
      pos++; // skip '('

      // Parse 9 fields: title, difficulty, description, hint, ex_input, ex_output, is_active, created_at, solution
      const fields = [];
      for (let i = 0; i < 9; i++) {
        // Skip whitespace
        while (pos < sql.length && /\s/.test(sql[pos])) pos++;

        const result = parseSQLValue(sql, pos);
        fields.push(result.value);
        pos = result.endPos;

        // Skip comma between fields
        while (pos < sql.length && /\s/.test(sql[pos])) pos++;
        if (sql[pos] === ',') pos++;
      }

      tasks.push({
        title:    fields[0],
        solution: fields[8]
      });

      // Skip closing ')' and delimiter
      while (pos < sql.length && /\s/.test(sql[pos])) pos++;
      if (sql[pos] === ')') pos++;
      while (pos < sql.length && /\s/.test(sql[pos])) pos++;
      if (sql[pos] === ',') {
        pos++;
        continue;
      }
      if (sql[pos] === ';') {
        pos++;
        break;
      }
    }

    searchFrom = pos;
  }

  return tasks;
}

/* ── Note: B4 (task 15 test cases) not needed.
   The "Euklidesa rekurencyjna" task is ID 16 in the live DB (ID 15 was deleted).
   Task 16 already has test cases in both dane.sql and the live DB. ── */

/* ── Main ── */
async function main() {
  const daneSql = fs.readFileSync('dane.sql', 'utf-8');
  console.log('Parsing dane.sql...');
  const correctTasks = extractAlgoTasks(daneSql);
  console.log(`Found ${correctTasks.length} algo_tasks in dane.sql`);

  let conn;
  try {
    conn = await pool.getConnection();

    // ── B1: Remove duplicate algo_task_tests ──
    console.log('\n=== B1: Removing duplicate algo_task_tests (IDs >= 507) ===');
    const dupTests = await conn.query('SELECT COUNT(*) AS cnt FROM algo_task_tests WHERE id >= 507 AND id <= 635');
    console.log(`  Found ${dupTests[0].cnt} duplicate test rows to delete`);
    if (!DRY_RUN && dupTests[0].cnt > 0) {
      const res = await conn.query('DELETE FROM algo_task_tests WHERE id >= 507 AND id <= 635');
      console.log(`  Deleted ${res.affectedRows} rows`);
    }

    // ── B2: Remove duplicate quiz_questions ──
    console.log('\n=== B2: Removing duplicate quiz_questions (IDs 109-216) ===');
    const dupQuiz = await conn.query('SELECT COUNT(*) AS cnt FROM quiz_questions WHERE id BETWEEN 109 AND 216');
    console.log(`  Found ${dupQuiz[0].cnt} duplicate quiz rows to delete`);
    if (!DRY_RUN && dupQuiz[0].cnt > 0) {
      // FKs have ON DELETE SET NULL so this is safe
      const res = await conn.query('DELETE FROM quiz_questions WHERE id BETWEEN 109 AND 216');
      console.log(`  Deleted ${res.affectedRows} rows`);
    }

    // ── B3: Update wrong/NULL algo_tasks solutions ──
    console.log('\n=== B3: Updating algo_tasks solutions ===');
    const liveTasks = await conn.query('SELECT id, title, solution FROM algo_tasks ORDER BY id');
    console.log(`  Live DB has ${liveTasks.length} algo_tasks`);

    // Build lookup by title
    const correctByTitle = new Map();
    for (const t of correctTasks) {
      correctByTitle.set(t.title, t.solution);
    }

    let updatedCount = 0;
    let skippedCount = 0;
    const updates = [];

    for (const liveTask of liveTasks) {
      const correctSolution = correctByTitle.get(liveTask.title);

      if (correctSolution === undefined) {
        // Task exists in live DB but not in dane.sql - skip
        continue;
      }

      // Compare solutions
      const liveSol = liveTask.solution || null;
      const correctSol = correctSolution || null;

      if (liveSol === correctSol) {
        skippedCount++;
        continue;
      }

      updates.push({ id: liveTask.id, title: liveTask.title, newSolution: correctSol });
    }

    console.log(`  ${skippedCount} tasks already correct`);
    console.log(`  ${updates.length} tasks need updating:`);

    for (const u of updates) {
      console.log(`    #${u.id}: ${u.title}`);
      if (!DRY_RUN) {
        await conn.query('UPDATE algo_tasks SET solution = ? WHERE id = ?', [u.newSolution, u.id]);
        updatedCount++;
      }
    }

    if (!DRY_RUN) {
      console.log(`  Updated ${updatedCount} tasks`);
    }

    // ── B4: Skipped — "Euklidesa rekurencyjna" is ID 16 (not 15) and already has tests ──
    console.log('\n=== B4: Skipped (Euklidesa rekurencyjna = ID 16, already has tests) ===');

    // ── Summary ──
    console.log('\n=== Summary ===');
    if (DRY_RUN) {
      console.log('DRY RUN — no changes were made.');
      console.log('Run without --dry-run to apply changes.');
    } else {
      // Verify counts
      const finalTests = await conn.query('SELECT COUNT(*) AS cnt FROM algo_task_tests');
      const finalQuiz  = await conn.query('SELECT COUNT(*) AS cnt FROM quiz_questions');
      const finalTasks = await conn.query('SELECT COUNT(*) AS cnt FROM algo_tasks WHERE solution IS NOT NULL');
      const t15Tests   = await conn.query('SELECT COUNT(*) AS cnt FROM algo_task_tests WHERE task_id = 15');

      console.log(`Total algo_task_tests:    ${finalTests[0].cnt}`);
      console.log(`Total quiz_questions:     ${finalQuiz[0].cnt}`);
      console.log(`algo_tasks with solution: ${finalTasks[0].cnt}`);
      console.log('Patch applied successfully!');
    }

  } finally {
    if (conn) conn.end();
    await pool.end();
  }
}

main().catch(err => {
  console.error('FATAL:', err.message);
  process.exit(1);
});
