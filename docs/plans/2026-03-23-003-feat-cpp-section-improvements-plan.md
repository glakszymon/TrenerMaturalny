---
title: "feat: Improve C++ section — custom stdin, undo submissions, editor autocomplete"
type: feat
status: active
date: 2026-03-23
---

# Improve C++ Section — Custom Stdin, Undo Submissions, Editor Autocomplete

## Enhancement Summary

**Deepened on:** 2026-03-23
**Research agents used:** CodeMirror 5 deep dive, Express DELETE patterns, online judge UX research, security audit, data integrity review

### Key Improvements From Research
1. **SID is the user's nick** (not `sess_<timestamp>_<random>`) — the undo endpoint must account for publicly-known session IDs
2. **Use `registerHelper('hint', 'text/x-c++src', fn)`** instead of `'clike'` — scopes hints to C++ only, not all C-like languages
3. **LeetCode two-button model** for Run/Submit — "Uruchom" always uses custom stdin, "Zatwierdz" always runs official tests. No toggle/mode switching.
4. **Add stdout/stderr cap** (1MB) to `runBin()` — prevents memory DoS from infinite output loops
5. **Add compilation concurrency limit** (max 3) — prevents CPU exhaustion from parallel requests
6. **Add keyboard shortcuts** — Ctrl+Enter to run, Ctrl+Shift+Enter to submit

### New Considerations Discovered
- The `DELETE` request body has no defined semantics in HTTP (RFC 9110) — use `X-Session-Id` header instead
- Token types for clike mode: `"string"`, `"comment"`, `"keyword"`, `"type"`, `"variable"`, `"number"`, `"operator"`, `"meta"`, `"atom"`, `"def"`, `null`
- `ON DELETE CASCADE` on `algo_test_results` is already defined and sufficient — no explicit transaction needed
- Stats queries need `COALESCE(..., 0)` on SUM aggregates to handle empty result sets after last attempt deleted

---

## Overview

Three improvements to the C++ algorithmic tasks section of the Matura trainer:

1. **Fix example data input** — the "Uruchom" (Run) button misleadingly displays `ex_input` in the terminal but actually runs all test cases. Add a custom stdin textarea so students can test their code with arbitrary input.
2. **Add undo for submissions** — once "Zatwierdz" is clicked, the attempt is permanent. Add a time-limited undo button (30s window) to allow reverting accidental submissions.
3. **Add C++ editor autocomplete** — the `show-hint.js` addon is loaded but not configured for C++. The SQL editor has Ctrl+Space autocomplete; the C++ editor does not.

## Problem Statement / Motivation

Students preparing for the matura exam need a fast feedback loop. Currently:
- They cannot test code with custom input — only pre-configured test cases run, and the terminal display is misleading about what input was used.
- A misclick on "Zatwierdz" permanently records a failed attempt, polluting their history and stats.
- The C++ editor lacks basic autocomplete that modern editors provide, making it harder to discover STL functions and reducing typing efficiency.

## Proposed Solution

### Feature 1: Custom Stdin Input + Fix Run Display

**New endpoint:** `POST /api/algo/run` — accepts `{code, stdin}`, compiles C++ and runs once with the provided stdin, returns raw `{compiled, compile_error, stdout, stderr, time_ms, timedOut}`. No `task_id` required, no DB persistence.

**Frontend changes (LeetCode two-button model — no toggles, no modes):**
- Add a `<textarea id="algoStdin">` in the "Przykladowe dane" card for custom stdin input (always visible, compact 3 rows, resizable up to 140px)
- Add "Wklej przyklad" button that copies `ex_input` into the textarea
- Add small "x" clear button next to it
- **Run button logic (simplified — no mode detection):**
  - "Uruchom" ALWAYS calls `POST /api/algo/run` with `{code, stdin: textarea.value}` — even if textarea is empty (empty stdin is valid)
  - "Zatwierdz" ALWAYS calls `POST /api/algo/submit` — unchanged, runs all official tests, saves to DB
- Fix terminal display: show structured `stdin:` / `stdout:` blocks instead of misleading `$ ./program <<< "..."`
- After a run (not submit), show: `"Wynik testowy — nie zapisano. Kliknij Zatwierdz, aby zapisac."`
- Add sub-labels on buttons: "testowe — bez zapisu" under Uruchom, "oficjalne testy" under Zatwierdz
- Reset textarea on task switch; use `sessionStorage` for per-task persistence within same session

#### Research Insights — Custom Stdin

**Best Practices (from online judge research):**
- LeetCode, Codeforces, AtCoder all use a separate "Run/Test" vs "Submit" model
- LeetCode's two-button approach is the best fit: zero cognitive overhead, no hidden modes
- Always-visible textarea beats toggle/accordion — students test with custom input 80% of the time during practice, every extra click hurts
- `Ctrl+Enter` for Run, `Ctrl+Shift+Enter` for Submit — industry standard (VS Code, LeetCode, Repl.it)

**Terminal Output Format (structured blocks):**
```
── Uruchomienie z danymi ──────────────────
stdin:
  5
  3 7 2 1
───────────────────────────────────────────
stdout:
  1 2 3 5 7
── Czas: 2 ms ────────────────────────────
ℹ Wynik testowy — nie zapisano.
```

**Keyboard Shortcuts to Add:**

| Action | Shortcut | Scope |
|--------|----------|-------|
| Run with custom stdin | `Ctrl+Enter` | Global (algo section) + stdin textarea |
| Submit (official tests) | `Ctrl+Shift+Enter` | Global (algo section) |
| Focus stdin textarea | `Ctrl+I` | Global (algo section) |
| Return to editor from textarea | `Escape` | Stdin textarea |

**Backend:**
- New `POST /api/algo/run` endpoint in `server.js` (after existing `/api/algo/submit`)
- Validate: `code.length <= 64000`, `stdin.length <= 64000`
- Reuse existing `compileCpp()` and `runBin()` functions
- Cleanup temp dir in `finally` block
- **Add `child.stdin.on('error', () => {})` handler** to prevent EPIPE crash when binary exits before consuming all stdin

### Feature 2: Undo Recent Submission (30s Window)

**New endpoint:** `DELETE /api/algo/attempts/:id` — deletes an attempt if:
1. The `X-Session-Id` header matches the attempt's `session_id` (REST convention — DELETE body has no defined semantics per RFC 9110)
2. The attempt's `attempted_at` is within 30 seconds of `NOW()` (server-side enforcement in SQL, using the same clock that wrote `attempted_at`)

**Database:** The `algo_test_results.attempt_id` FK already has `ON DELETE CASCADE` (confirmed in `dane.sql`), so deleting an attempt automatically removes its test results. CASCADE for 5-10 child rows is sub-millisecond. No explicit transaction needed.

**Frontend:**
- After a successful submit, show a "Cofnij" button with a 30s countdown timer
- Button disappears after 30s or when user navigates to a different task
- On click: `DELETE /api/algo/attempts/:id` with `X-Session-Id` header
- On success: refresh history via `loadAlgoHistory(taskId)`, show toast "Cofnieto ostatnie zgloszenie"
- On failure (time expired, 409): show toast "Nie mozna cofnac — uplynal limit czasu"

#### Research Insights — Undo Feature

**Critical Discovery: SID = user's nick (public knowledge)**
The canonical `index.html` (line 2480-2526) shows `SID = nick` stored in localStorage. Session IDs are human-readable strings like `"Piotr"` — not random tokens. Classmates know each other's nicks. This means:
- A student CAN call `DELETE /api/algo/attempts/:id` with another student's nick
- **Mitigation:** The 30-second window limits the attack surface. Persistent griefing requires automated polling, which is unlikely in a classroom setting.
- **Additional mitigation:** Log all deletions: `console.log('UNDO: attempt', id, 'deleted by session', sid)`

**HTTP Status Codes:**

| Scenario | Status | Rationale |
|----------|--------|-----------|
| Successful delete | `200` with JSON `{ ok: true }` | Codebase convention |
| Attempt not found OR wrong session | `404` | Don't reveal existence |
| Time window expired | `409 Conflict` | Resource state conflicts with operation |
| Invalid ID | `400` | Malformed request |
| Rate limit exceeded | `429` | Too many requests |

**Rate Limiting:** 5 deletes per minute per session, in-memory Map with 60s expiry.

**Endpoint Implementation Pattern:**
```js
// Phase 1: Atomic check (one query, avoids TOCTOU race)
const rows = await conn.query(
  `SELECT id, session_id,
          TIMESTAMPDIFF(SECOND, attempted_at, NOW()) AS age_seconds
   FROM algo_attempts WHERE id = ?`, [id]);

// Phase 2: Atomic delete with SAME conditions (prevents race)
const result = await conn.query(
  `DELETE FROM algo_attempts
   WHERE id = ? AND session_id = ?
     AND attempted_at >= NOW() - INTERVAL 30 SECOND`, [id, sid]);
```

**Stats Edge Cases After Delete:**
- `COUNT(*)` returns 0 and `SUM(...)` returns `NULL` when all attempts deleted — add `COALESCE(..., 0)` to stats queries
- ID gaps from deleted attempts are harmless — frontend sorts by `attempted_at`, never by `id`

### Feature 3: C++ Editor Autocomplete

**Approach:** Register a custom `CodeMirror.registerHelper('hint', 'text/x-c++src', fn)` that combines:
1. A curated list of ~100 C++ keywords and matura-relevant STL identifiers with category icons
2. Anyword-style document scanning (words already typed in the editor)

#### Research Insights — CodeMirror Hints

**`registerHelper` vs `hintOptions.hint`:**
- `registerHelper('hint', 'text/x-c++src', fn)` is the idiomatic approach — it cooperates with the `hint: auto` resolver system
- `hintOptions.hint = fn` completely replaces the auto resolver — use only if you want total control
- Register under `'text/x-c++src'` (MIME type) for C++-only, not `'clike'` which covers C, Java, C#, Scala etc.

**Token types returned by `cm.getTokenAt(cursor).type` for clike mode:**

| Token type | Produces | Guard? |
|-----------|----------|--------|
| `"string"` | Inside `"..."` or `'...'` | Skip hints |
| `"comment"` | Inside `//` or `/* */` | Skip hints |
| `"meta"` | Preprocessor `#include`, `#define` | Skip hints |
| `"keyword"` | `if`, `while`, `class`, etc. | Allow hints |
| `"type"` | `int`, `double`, `void`, `size_t`, etc. | Allow hints |
| `"variable"` | User identifiers, `std`, `cout` | Allow hints |
| `"atom"` | `true`, `false`, `nullptr` | Allow hints |
| `null` | Punctuation `;`, `{`, `(`, etc. | Skip hints |

**Debouncing:** 150ms on `inputRead` event. Also trigger immediately on `::`, `.`, and `->` operators for member access completion.

**Category Icons (VS Code style):** Use the `render` property on completion objects to add colored badges:

| Category | Badge | Color (Dracula) |
|----------|-------|-----------------|
| Keyword | K | `#ff79c6` (pink) |
| Type | T | `#8be9fd` (cyan) |
| Function | F | `#bd93f9` (purple) |
| Variable | V | `#50fa7b` (green) |
| Macro | M | `#ffb86c` (orange) |

**Trigger strategy:**
- **Explicit:** `Ctrl-Space` keybinding (always available)
- **Auto-trigger:** On `inputRead` event after 2+ alphanumeric characters, with guards:
  - Skip if cursor is inside a string, comment, or meta token (`cm.getTokenAt(cursor).type`)
  - `completeSingle: false` — CRITICAL: never auto-insert when only one match (the default `true` causes infuriating auto-completions)
  - 150ms debounce to avoid flickering
  - Immediate trigger on `::`, `.`, `->` operators (no debounce)

**Keyword list (matura-focused):**
- C++ reserved words: `auto`, `bool`, `break`, `case`, `catch`, `char`, `class`, `const`, `constexpr`, `continue`, `do`, `double`, `else`, `enum`, `false`, `float`, `for`, `if`, `int`, `long`, `namespace`, `new`, `noexcept`, `nullptr`, `return`, `short`, `signed`, `sizeof`, `static`, `struct`, `switch`, `template`, `this`, `throw`, `true`, `try`, `typedef`, `typename`, `unsigned`, `using`, `virtual`, `void`, `volatile`, `while`
- STL types: `string`, `vector`, `map`, `set`, `pair`, `array`, `stack`, `queue`, `deque`, `priority_queue`, `list`
- STL functions: `sort`, `reverse`, `find`, `count`, `min`, `max`, `swap`, `abs`, `push_back`, `pop_back`, `size`, `empty`, `begin`, `end`, `front`, `back`, `first`, `second`, `insert`, `erase`, `clear`, `length`, `substr`, `stoi`, `to_string`, `getline`, `ignore`
- I/O: `cout`, `cin`, `cerr`, `endl`, `fixed`, `setprecision`, `setw`, `ifstream`, `ofstream`
- Headers: `iostream`, `fstream`, `sstream`, `vector`, `algorithm`, `cmath`, `cstdlib`, `iomanip`, `map`, `set`, `queue`, `stack`, `numeric`
- Constants: `INT_MAX`, `INT_MIN`, `npos`
- Preprocessor: `include`, `define`, `main`, `std`

**CSS for Dracula theme compatibility:**
```css
/* Container */
.CodeMirror-hints {
  background: #282a36;
  border: 1px solid #44475a;
  border-radius: 4px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
  font-size: 13px;
  max-height: 20em;
  overflow-y: auto;
  padding: 2px 0;
  z-index: 100;
  scrollbar-width: thin;
  scrollbar-color: #44475a #282a36;
}

/* Individual items */
.CodeMirror-hint {
  color: #f8f8f2;
  padding: 4px 8px;
  cursor: pointer;
  white-space: pre;
  line-height: 1.4;
}
.CodeMirror-hint:hover {
  background: #343746;
}

/* Active/selected */
li.CodeMirror-hint-active {
  background: #44475a;
  color: #f8f8f2;
}

/* Icon layout */
.hint-with-icon.CodeMirror-hint {
  display: flex;
  align-items: center;
  padding: 3px 8px;
}
.hint-icon {
  display: inline-block;
  width: 16px; height: 16px;
  margin-right: 6px;
  border-radius: 3px;
  text-align: center;
  font-size: 10px;
  font-weight: bold;
  line-height: 16px;
}
.hint-icon-keyword { background: #ff79c6; color: #282a36; }
.hint-icon-keyword::after { content: "K"; }
.hint-icon-type { background: #8be9fd; color: #282a36; }
.hint-icon-type::after { content: "T"; }
.hint-icon-function { background: #bd93f9; color: #282a36; }
.hint-icon-function::after { content: "F"; }
.hint-icon-variable { background: #50fa7b; color: #282a36; }
.hint-icon-variable::after { content: "V"; }
.hint-icon-macro { background: #ffb86c; color: #282a36; }
.hint-icon-macro::after { content: "M"; }
.hint-label { flex: 1; }
.hint-detail { color: #6272a4; font-size: .85em; margin-left: 12px; font-style: italic; }
```

**No new CDN includes needed** — the custom hint function reimplements anyword scanning in ~30 lines, avoiding the need for `anyword-hint.min.js`.

## Technical Considerations

### Architecture
- All changes go in `server.js` (root, ~865 lines) and `index.html` (root, ~5154 lines) — these are the canonical files
- `backend/` and `frontend/` directories are stale copies — do NOT modify them
- The new `/api/algo/run` endpoint is intentionally separate from `/api/algo/submit` to keep concerns clean

### Security

**For new features:**
- Custom stdin is validated with the same 64KB limit as code
- The undo endpoint enforces both session ownership AND server-side 30s time window — client-side timer is cosmetic only
- C++ execution remains unsandboxed (existing risk, accepted for trusted environment — see audit requirements doc)

**Hardening to add alongside these features (from security audit):**
1. **Cap stdout/stderr in `runBin()`** to 1MB — prevents memory DoS from `while(true) cout << "A";`
   ```js
   const MAX_OUTPUT = 1024 * 1024;
   child.stdout.on('data', d => { if (out.length < MAX_OUTPUT) out += d.toString(); });
   ```
2. **Add EPIPE handler** — `child.stdin.on('error', () => {})` prevents crash when binary exits before consuming stdin
3. **Add compilation concurrency limit** — max 3 concurrent compilations, return 429 if exceeded
   ```js
   let activeCompilations = 0;
   const MAX_CONCURRENT = 3;
   ```
4. **Log undo deletions** — `console.log('UNDO: attempt', id, 'by session', sid)` for accountability

### Performance
- Custom stdin runs one compilation + one execution — same cost as a single test case
- Autocomplete document scanning is O(n) on document text; matura programs are 20-80 lines, negligible cost
- Server-side time check for undo uses `NOW()` in the same MariaDB clock that wrote `attempted_at` — zero skew
- CASCADE delete of 5-10 test result rows is sub-millisecond

### Compatibility
- CodeMirror 5.65.16 — all APIs used are stable and documented
- MariaDB 2.x driver — `conn.end()` releases to pool (not destroys)
- No new npm dependencies required

## System-Wide Impact

- **`/api/algo/run` is a new public endpoint** — same security posture as existing `/api/algo/submit` (no auth, session-based)
- **Undo DELETE cascades** through `algo_test_results` via existing FK constraint — no orphaned rows, no explicit transaction needed
- **Stats queries** (`/api/stats/detailed/:sid`) use live aggregates from `algo_attempts` — deleting an attempt automatically updates stats. Add `COALESCE(..., 0)` to `SUM()` aggregates to handle edge case where all attempts are deleted.
- **`visible_tests` data** from `GET /api/tasks` is currently unused by the frontend and will remain unused — the new "Uruchom" button uses custom stdin, not visible tests.

## Acceptance Criteria

### Feature 1: Custom Stdin
- [ ] New `POST /api/algo/run` endpoint accepts `{code, stdin}` and returns compilation + execution results
- [ ] Stdin validated: max 64KB
- [ ] Custom stdin textarea visible in the "Przykladowe dane" card (`index.html`), always visible, 3 rows
- [ ] "Wklej przyklad" button copies `ex_input` into textarea
- [ ] Clear button (x) empties textarea
- [ ] Run button always calls `/api/algo/run` with textarea content (even if empty)
- [ ] Terminal shows structured `stdin:` / `stdout:` blocks, not misleading `<<<`
- [ ] Info message after run: "Wynik testowy — nie zapisano"
- [ ] Sub-labels on buttons: "testowe — bez zapisu" / "oficjalne testy"
- [ ] Textarea resets on task switch, persists per-task via sessionStorage
- [ ] Keyboard shortcuts: Ctrl+Enter (run), Ctrl+Shift+Enter (submit), Ctrl+I (focus stdin), Escape (back to editor)
- [ ] `child.stdin.on('error')` handler prevents EPIPE crash
- [ ] stdout/stderr capped at 1MB in `runBin()`
- [ ] Compilation concurrency limited to 3

### Feature 2: Undo Submission
- [ ] New `DELETE /api/algo/attempts/:id` endpoint with `X-Session-Id` header verification
- [ ] Server-side 30s time window enforcement via `attempted_at >= NOW() - INTERVAL 30 SECOND`
- [ ] Rate limited: 5 deletes/minute/session
- [ ] "Cofnij" button appears after successful submit with countdown
- [ ] Button auto-hides after 30s or on task navigation
- [ ] Successful undo refreshes history panel
- [ ] Toast notifications for success (200) / time expired (409) / rate limit (429)
- [ ] Cascading delete removes `algo_test_results` rows automatically
- [ ] Deletions logged to console
- [ ] Stats queries updated with `COALESCE(..., 0)` on SUM aggregates

### Feature 3: Autocomplete
- [ ] Custom hint helper registered for `'text/x-c++src'` mode (not generic `'clike'`)
- [ ] Curated keyword list (~100 items) with C++ reserved words + matura-relevant STL
- [ ] Category icons: K (keyword), T (type), F (function), V (variable), M (macro)
- [ ] Document word scanning (anyword-style) merged with keywords
- [ ] `Ctrl-Space` triggers hints explicitly
- [ ] Auto-trigger on 2+ chars with 150ms debounce, skipping strings/comments/meta tokens
- [ ] Immediate trigger on `::`, `.`, `->` operators
- [ ] `completeSingle: false` — never auto-inserts
- [ ] Dracula-theme-compatible hint popup CSS with scrollbar styling
- [ ] No new CDN includes required (custom implementation)

## Dependencies & Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Undo deletes best score | Student loses their best result | Intended behavior — 30s window is short enough to prevent regret |
| Classmate deletes another's attempt (SID = nick) | Griefing within 30s window | Log deletions for accountability; 30s limits persistent abuse |
| Auto-trigger hints annoying | Students get distracted | `completeSingle: false` + string/comment guards + 2-char minimum + 150ms debounce |
| Custom stdin enables arbitrary input to compiled binary | Same risk as existing test data — no sandbox | Existing risk, accepted. 64KB limit + 3s timeout + 1MB output cap |
| Infinite stdout causes memory DoS | Node.js OOM crash | Cap stdout/stderr at 1MB in `runBin()` |
| Parallel compilations exhaust CPU | Server unresponsive | Max 3 concurrent compilations, 429 for excess |
| Stale `frontend/index.html` causes confusion | Changes only in root files | Clearly documented — root is canonical |

## Implementation Phases

### Phase 1: C++ Editor Autocomplete (lowest risk, self-contained)
**Files:** `index.html`
1. Define `CPP_KEYWORDS` array with category metadata (`{text, kind}`) before `initEditor()`
2. Add `CodeMirror.registerHelper('hint', 'text/x-c++src', fn)` with:
   - Token type guards (`string`, `comment`, `meta`, `null`)
   - Keyword matching + document word scanning
   - Category icon rendering via `render` property
3. Add `hintOptions: { completeSingle: false }` and `'Ctrl-Space': 'autocomplete'` to cppEditor config
4. Add `inputRead` listener with 150ms debounce + immediate trigger on `::`, `.`, `->`
5. Add Dracula-compatible `.CodeMirror-hints` CSS with scrollbar styling and icon classes

### Phase 2: Custom Stdin Input + Backend Hardening
**Files:** `server.js`, `index.html`
1. **Backend hardening first:**
   - Cap stdout/stderr at 1MB in `runBin()`
   - Add `child.stdin.on('error', () => {})` handler
   - Add compilation concurrency semaphore (MAX_CONCURRENT = 3)
2. Add `POST /api/algo/run` endpoint in `server.js`
3. Add stdin textarea + "Wklej przyklad" / "x" buttons to "Przykladowe dane" card
4. Rewrite `btnRun` click handler to always call `/api/algo/run`
5. Add structured terminal output format (`stdin:` / `stdout:` blocks)
6. Add "nie zapisano" info line after runs
7. Add sub-labels on Run/Submit buttons
8. Add keyboard shortcuts (Ctrl+Enter, Ctrl+Shift+Enter, Ctrl+I, Escape)
9. Add sessionStorage per-task stdin persistence + reset on task switch

### Phase 3: Undo Submissions
**Files:** `server.js`, `index.html`
1. Add in-memory rate limiter (5/min/session) with 60s expiry cleanup
2. Add `DELETE /api/algo/attempts/:id` endpoint:
   - Read `X-Session-Id` header
   - SELECT to check existence + ownership + age
   - Atomic DELETE with same conditions
   - Log deletion to console
3. Update stats queries with `COALESCE(..., 0)` on SUM aggregates
4. Add "Cofnij" button + 30s countdown timer in frontend
5. Wire up delete call + history refresh + toast notifications
6. Auto-hide on timeout/navigation

## Sources & References

### Internal References
- C++ editor configuration: `index.html:2740-2761`
- SQL hint configuration (reference pattern): `index.html:2769-2788`
- Submit endpoint: `server.js:225-303`
- `compileCpp()`: `server.js:116-129`
- `runBin()`: `server.js:131-146`
- History loading: `index.html:2952-2979`
- SID assignment (nick-based): `index.html:2480-2526`
- `algo_attempts` schema: `dane.sql` / `README.md:159-172`
- `algo_test_results` FK cascade: `dane.sql`

### External References
- CodeMirror 5 show-hint addon: https://codemirror.net/5/doc/manual.html#addon_show-hint
- CodeMirror 5 `registerHelper` API: https://codemirror.net/5/doc/manual.html#registerHelper
- CodeMirror 5 clike mode token types: analyzed from `clike.js` source
- HTTP DELETE semantics: RFC 9110 §9.3.5
- HTTP 409 Conflict: RFC 9110 §15.5.10
- Online judge UX patterns: LeetCode, Codeforces, AtCoder, HackerRank custom input interfaces
