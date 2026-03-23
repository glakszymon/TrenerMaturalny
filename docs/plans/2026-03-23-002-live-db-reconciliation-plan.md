# Plan 002: Live Database Reconciliation

**Date**: 2026-03-23
**Status**: COMPLETED
**Depends on**: Plan 001 (all code changes applied)

## Context

All code changes from Plan 001 (Phases 3, 4, 6) were successfully applied to `server.js`, `index.html`, and `dane.sql`. However, the live MariaDB database was never reseeded after `dane.sql` was corrected. An export of the live database (`structure.sql`, 1912 lines) was analyzed to identify discrepancies between the live state and the expected state.

## Decision: Option 2 (Surgical Live Patches)

We chose surgical patches to preserve user data (sessions, attempts, quiz results, flashcard progress).

## Findings & Resolutions

### A. Schema & Constraints — NO ACTION NEEDED

All migrations from `server.js` had been applied successfully to the live DB. Verified all FK constraints, CHECK constraints, index removals, and column defaults were in place.

### B1. Duplicate Algorithm Test Cases — RESOLVED

**Issue**: Live DB had 337 test rows. Tasks 8–35 had exact duplicate test sets (129 duplicate groups).

**Resolution**: Removed 129 duplicate rows via helper table approach. 208 unique tests remain. Matches dane.sql exactly.

**Note**: dane.sql itself was clean (208 tests, no duplicates). The live DB duplicates came from running the seed file twice.

### B2. Duplicate Quiz Questions — ALREADY CLEAN

**Issue (from analysis)**: Expected duplicates in quiz_questions (IDs 109-216 duplicating 1-108).

**Resolution**: When the patch ran, 0 duplicates were found. The DB had been partially cleaned between the structure.sql export and the patch execution. 108 questions total, no duplicates.

### B3. Wrong/NULL Algorithm Solutions — RESOLVED

**Issue**: ~27 algo_tasks in the live DB had wrong or NULL `solution` values.

**Resolution**: Created and ran `apply_patch.js` which:
1. Parsed dane.sql to extract correct solutions for all 37 algo_tasks
2. Connected to live MariaDB and updated 27 tasks with corrected solutions
3. Verified all 37 tasks now have correct, non-NULL solutions

### B4. Task 15 Missing Test Cases — NOT APPLICABLE

**Issue (from analysis)**: Assumed task 15 (Euklidesa rekurencyjna) had no test cases.

**Resolution**: This was a misidentification. The live DB has **gapped IDs** — IDs 15, 25, 30 are missing (deleted at some point). The actual task "Algorytm Euklidesa – wersja rekurencyjna" is **ID 16**, and it already had 5 test cases (10 before dedup). No action needed.

### B5. sql_attempts Legacy Data — NO ACTION NEEDED

Old rows with `task_id_ref = NULL` are historical. New submissions correctly populate both FK columns. No user-visible impact.

## Additional Fix: dane.sql ID Consistency — RESOLVED

**Critical discovery**: dane.sql had a fundamental inconsistency:
- `algo_tasks` INSERT statements did NOT specify explicit IDs (relied on auto_increment)
- `algo_task_tests` INSERT statements referenced specific task_ids (16, 26, 31, etc.) matching the live DB's gapped IDs
- On a fresh setup, auto_increment would assign sequential IDs 1–37, but test references expected IDs with gaps up to 40
- This meant **dane.sql was broken for fresh database setups**

**Resolution**: 
1. Added explicit `id` values to all 4 `INSERT INTO algo_tasks` blocks (37 tasks total)
2. IDs match live DB: 1-14, 16-24, 26-29, 31-40 (gaps at 15, 25, 30)
3. Added `ALTER TABLE matura_db.algo_tasks AUTO_INCREMENT = 41;` after the last INSERT block

## Final State

| Entity | Count | Status |
|---|---|---|
| algo_tasks | 37 | All have correct non-NULL solutions, explicit IDs in dane.sql |
| algo_task_tests | 208 | No duplicates, all FK references valid |
| quiz_questions | 108 | No duplicates |
| FK constraints | All applied | Via server.js migrations |
| dane.sql | Consistent | Fresh setup will produce correct state |

## Files Modified

- `dane.sql` — Added explicit IDs to algo_tasks INSERTs, AUTO_INCREMENT = 41
- `apply_patch.js` — One-time patch script (created and used, can be deleted)

## Artifacts (can be cleaned up)

- `apply_patch.js` — One-time patch script, no longer needed
- `structure.sql` — Stale DB export from before patches, no longer accurate
- `export_db.sql` — SQL script used to generate structure.sql
