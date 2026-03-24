---
title: "feat: Leitner Bucket System for Quiz Question Selection"
type: feat
status: active
date: 2026-03-24
origin: docs/brainstorms/2026-03-24-leitner-question-selection-requirements.md
---

# feat: Leitner Bucket System for Quiz Question Selection

## Overview

Replace the uniform random Fisher-Yates shuffle used by all three quiz-like modes (timed quiz, focus mode, learning/flashcard mode) with a 3-bucket Leitner system that prioritizes weak questions. Bucket state is derived from historical `quiz_results` data and persisted across sessions. A visible progression indicator shows the student their mastery distribution.

## Problem Statement / Motivation

Students currently see questions in a purely random order. A student who consistently answers a question correctly sees it just as often as one they always get wrong. This wastes study time on mastered material and fails to reinforce weak areas. The existing `quiz_results` table already stores per-question correctness and timing data, but this data is never fed back into question selection (see origin: `docs/brainstorms/2026-03-24-leitner-question-selection-requirements.md`).

## Proposed Solution

A 3-bucket Leitner system with server-side bucket computation:

- **Unseen**: Never answered (default for new users)
- **Weak**: Answered but not yet promoted (consecutive correct count < 2)
- **Strong**: Promoted after 2 consecutive correct answers

Draw probability: weighted toward weaker buckets (~60% Weak, 25% Unseen, 15% Strong). When buckets are empty, probability redistributes proportionally to remaining non-empty buckets. Always on — no user toggle.

### Key Decisions Carried Forward (see origin)

- **3 buckets over 4-5**: Simpler mental model, clearer progression
- **Consecutive correct to promote (not single answer)**: Prevents lucky guesses from premature promotion
- **Always on**: Reduces UI complexity, ensures all students benefit
- **Bucket approach over weighted random**: Enables visible progression tracking

### Resolved During Planning

- **N = 2 consecutive correct to promote Weak → Strong**: With aggressive demotion (1 wrong = demote), N=2 is sufficient. Lucky promotions self-correct quickly. N=3 would make the Strong bucket unreachable for typical session lengths with 108 questions.
- **Server-side bucket computation**: The client should not compute buckets from raw `quiz_results` — the table can grow large, and the consecutive-correct logic is better centralized. A new endpoint returns pre-computed bucket assignments.
- **Learning mode feeds the bucket system**: `learnRate(known)` currently writes nothing persistent. To fulfill R1 (all quiz-like modes), learning mode will write to `quiz_results` with `is_correct` = known/unknown. This ensures flashcard study counts toward bucket progression.
- **Timer timeout = wrong answer for bucket purposes**: Matches existing behavior where timeout records `is_correct: false`.
- **Consecutive correct is global across modes**: A correct answer in timed quiz followed by a correct answer in focus mode both count toward the same question's consecutive streak.
- **Category switching rebuilds the weighted draw**: When the student selects a new category, the current deck is discarded and a new weighted draw is performed from the selected category's buckets.
- **Empty bucket redistribution**: Proportional. If Weak is empty, its 60% redistributes to Unseen and Strong proportionally. If only Strong remains, draw 100% from Strong.
- **NULL question_id rows are skipped**: Bucket computation ignores `quiz_results` rows where `question_id IS NULL` (orphans from deleted questions).

## Technical Considerations

### Architecture

The implementation spans two files:

1. **`server.js`** — New endpoint `GET /api/quiz/buckets/:sid` that computes bucket assignments from `quiz_results`
2. **`index.html`** — Replace `shuffle(getQs().slice())` at 3 integration points with weighted bucket draw. Add progression indicator UI. Add `quiz_results` write to learning mode.

### Database

No schema changes needed. The existing `quiz_results` table has all required columns: `session_id`, `question_id`, `is_correct`, `answered_at`. The `answered_at` column provides ordering for consecutive-correct computation.

### Performance

- Bucket computation runs once at quiz load (not per-question). Updated in-memory after each answer.
- The SQL query groups by `question_id` and computes consecutive correct streaks. With ~108 questions and typical result volumes (hundreds to low thousands of rows per student), this is fast.
- `COALESCE` pattern (established in Plan 003) used for aggregate safety.

### Existing `flashcard_progress` table

Kept as-is for backward compatibility with the stats page. The Leitner system uses `quiz_results` as its sole data source. `flashcard_progress` may be deprecated in a future release but is not touched in this implementation.

## Acceptance Criteria

### Functional Requirements

- [ ] New endpoint `GET /api/quiz/buckets/:sid` returns bucket assignment for every active question
- [ ] Bucket assignments: Unseen (never answered), Weak (answered, <2 consecutive correct), Strong (>=2 consecutive correct)
- [ ] One wrong answer demotes Strong → Weak; does not affect Unseen → stays Unseen until first attempt
- [ ] First attempt (correct or wrong) moves Unseen → Weak
- [ ] Weighted draw replaces `shuffle(getQs().slice())` in all 3 modes: timed quiz (`qzShuffle` line 4505), focus mode (`qzFShuffle` line 4742), learning mode (`learnStart` line 4366)
- [ ] Draw probabilities: 60% Weak / 25% Unseen / 15% Strong (when all non-empty), proportional redistribution when empty
- [ ] Answer options within a question remain uniformly shuffled (lines 4546, 4779 unchanged)
- [ ] Learning mode `learnRate()` writes to `quiz_results` via `POST /api/quiz/result` (known=correct, unknown=incorrect)
- [ ] Progression indicator visible in all quiz modes showing count per bucket (e.g., "Nowe: 30 | Slabe: 50 | Opanowane: 28")
- [ ] Progression indicator updates in real-time after each answer
- [ ] Category filtering works with buckets: switching category triggers a new weighted draw from that category's questions only
- [ ] Bucket state persists across sessions (derived from all historical `quiz_results`)

### Non-Functional Requirements

- [ ] No regression in quiz UX: timer, keyboard controls, scoring, and stats continue as before
- [ ] New user experience: all questions Unseen, draw is effectively random (R7)
- [ ] Bucket endpoint responds in <200ms for typical data volumes
- [ ] Two-tab scenario: acceptable degradation (stale in-memory state, no data corruption)

## Implementation Phases

### Phase 1: Backend — Bucket Computation Endpoint

**Files:** `server.js`

**New endpoint:** `GET /api/quiz/buckets/:sid`

SQL logic:
1. For each active `question_id` in `quiz_questions`, find the last N answers in `quiz_results` for this session
2. Compute consecutive correct count from the most recent answers (working backward from newest)
3. Classify: no results → Unseen, consecutive_correct >= 2 → Strong, else → Weak

**Response shape:**
```json
{
  "buckets": {
    "42": { "bucket": "weak", "consecutive_correct": 1 },
    "43": { "bucket": "unseen", "consecutive_correct": 0 },
    "44": { "bucket": "strong", "consecutive_correct": 3 }
  }
}
```

Questions not present in the response (because they have no `quiz_results` rows) are Unseen by default on the client.

**SQL approach:**
```sql
-- For each question answered by this session, get results ordered by time
SELECT question_id, is_correct, answered_at
FROM quiz_results
WHERE session_id = ? AND question_id IS NOT NULL
ORDER BY question_id, answered_at DESC
```

Then in JS: iterate per question_id, count consecutive `is_correct = 1` from the top (most recent). Stop counting at the first `is_correct = 0`. This avoids complex window functions that MariaDB may not support well.

**Acceptance:**
- [ ] Endpoint returns correct bucket for questions with mixed history
- [ ] Endpoint skips NULL question_id rows
- [ ] Endpoint returns empty object for new users (all questions implicitly Unseen)
- [ ] Response time <200ms with 1000 quiz_result rows

### Phase 2: Frontend — Weighted Draw Function

**Files:** `index.html`

**New function:** `weightedDraw(questions, bucketMap)`

Replace the 3 shuffle call sites with a weighted draw:

1. **`qzShuffle()`** (line 4505) → `qzWeightedDraw()`
2. **`qzFShuffle()`** (line 4742) → `qzFWeightedDraw()`
3. **`learnStart(qs)`** (line 4366) → use weighted order instead of `shuffle(qs.slice())`

**Algorithm:**
```
function weightedDraw(questions, bucketMap):
  // Classify questions into buckets
  unseen = questions where bucketMap[q.id] is undefined or bucket === 'unseen'
  weak   = questions where bucketMap[q.id].bucket === 'weak'
  strong = questions where bucketMap[q.id].bucket === 'strong'
  
  // Calculate effective weights (proportional redistribution)
  weights = {}
  if unseen.length > 0: weights.unseen = 0.25
  if weak.length > 0:   weights.weak = 0.60
  if strong.length > 0: weights.strong = 0.15
  totalWeight = sum(weights)
  normalize each weight by dividing by totalWeight
  
  // Build shuffled deck using weighted selection
  result = []
  pools = { unseen: shuffle(unseen), weak: shuffle(weak), strong: shuffle(strong) }
  poolIdx = { unseen: 0, weak: 0, strong: 0 }
  
  while result.length < questions.length:
    // Pick a bucket by weighted random
    roll = Math.random() * totalWeight
    selected = bucket where cumulative weight exceeds roll
    
    // Draw from that bucket's shuffled pool
    if poolIdx[selected] < pools[selected].length:
      result.push(pools[selected][poolIdx[selected]++])
    else:
      // Bucket exhausted — remove from weights, recalculate
      remove selected from weights, recalculate totalWeight
      continue
  
  return result
```

This produces a full shuffled deck (same length as input) but with bucket-weighted ordering. The existing sequential iteration (`qzSesIdx++`) continues to work unchanged.

**In-memory bucket state update:** After each answer, update `bucketMap[q.id]` locally:
- If correct: increment consecutive_correct. If >= 2, set bucket = 'strong'
- If wrong: reset consecutive_correct to 0, set bucket = 'weak'
- If first answer for Unseen: set bucket = 'weak', consecutive_correct = (1 if correct, 0 if wrong)

**Deck exhaustion:** When `qzSesIdx >= qzShuffled.length`, re-run `weightedDraw()` with updated `bucketMap`. This matches the current re-shuffle behavior but now uses updated bucket weights.

**Category switching:** When `qCat` changes (line 4276), if a quiz session is active, discard the current deck and call `weightedDraw()` for the new category.

**Acceptance:**
- [ ] Questions from Weak bucket appear ~4x more than Strong in a sample of 100+ draws
- [ ] All questions in the pool eventually appear (no starvation)
- [ ] New user gets effectively random order (all Unseen)
- [ ] Category change mid-quiz rebuilds the deck
- [ ] In-memory updates are consistent with what the server would return

### Phase 3: Frontend — Learning Mode Integration

**Files:** `index.html`

**Change:** `learnRate(known)` (line 4413) must write to `quiz_results`.

```javascript
// After line 4415: learnDeck[learnCursor].known = known;
var q = learnDeck[learnCursor].q;
apiPost('/api/quiz/result', {
  session_id: SID,
  question_id: q.id,
  category: q.cat,
  question_text: q.q,
  is_correct: known,
  time_ms: 0
}).catch(function(){});
// Also update in-memory bucketMap
updateBucketLocal(q.id, known);
```

**Learning mode "Repeat unknown" button** (line 4451): Remains session-local. It filters by `d.known === false` (the in-session self-report), not by Leitner bucket. This is intentional — the student explicitly asked to review what they just marked as unknown.

**Learning mode initial deck order:** Uses `weightedDraw()` instead of `shuffle()` so that the initial deck order is bucket-weighted.

**Acceptance:**
- [ ] Learning mode "known" press records `is_correct: true` in `quiz_results`
- [ ] Learning mode "unknown" press records `is_correct: false` in `quiz_results`
- [ ] Bucket state updates in real-time during learning mode
- [ ] "Repeat unknown" still uses session-local self-report, not bucket assignment
- [ ] Stats page (`/api/stats/:sid`) correctly includes learning mode results in quiz totals

### Phase 4: Frontend — Progression Indicator UI

**Files:** `index.html`

**New UI element:** A small bar or counter showing bucket distribution, visible in all quiz modes.

**Placement:**
- **Timed quiz and learning mode**: Below the category pills, above the question area
- **Focus mode**: In the top bar of the fullscreen overlay (next to the existing score counters)

**Design:**
```html
<div class="bucket-progress">
  <span class="bp-unseen" title="Nowe">● <span id="bpUnseen">0</span></span>
  <span class="bp-weak" title="Do nauki">● <span id="bpWeak">0</span></span>
  <span class="bp-strong" title="Opanowane">● <span id="bpStrong">0</span></span>
</div>
```

With colored dots: gray for Unseen, amber/orange for Weak, green for Strong. Updated after every answer by reading the current `bucketMap` filtered to the active category.

**Acceptance:**
- [ ] Indicator shows correct counts per bucket
- [ ] Counts reflect category filter (only shows buckets for selected category)
- [ ] Updates immediately after each answer
- [ ] Visible in all three modes (timed quiz, focus mode, learning mode)
- [ ] Does not break existing layout or overlap with other UI elements

### Phase 5: Load & Initialize

**Files:** `index.html`

**Initialization flow:**

1. After `loadQuizQuestionsFromDB()` completes (line 2787), fetch bucket state:
   ```javascript
   var BUCKET_MAP = {};
   async function loadBuckets() {
     try {
       var res = await apiFetch('/api/quiz/buckets/' + SID);
       var data = await res.json();
       BUCKET_MAP = data.buckets || {};
     } catch(e) { console.warn('loadBuckets:', e.message); BUCKET_MAP = {}; }
   }
   ```
2. `BUCKET_MAP` defaults to `{}` (all questions implicitly Unseen) — graceful degradation if fetch fails
3. All `weightedDraw()` calls read from `BUCKET_MAP`
4. After each answer, `updateBucketLocal(qId, isCorrect)` modifies `BUCKET_MAP` in-memory

**Acceptance:**
- [ ] Buckets load once after login, before first quiz interaction
- [ ] Failed bucket fetch falls back to all-Unseen (random behavior)
- [ ] No loading spinner or visible delay (fetch happens alongside questions load)

## System-Wide Impact

- **Interaction graph**: Answer → `POST /api/quiz/result` → server inserts row (unchanged) → client updates `BUCKET_MAP` locally → next draw reads updated map. No new server-side side effects.
- **Error propagation**: If bucket endpoint fails, client falls back to all-Unseen (random). If `POST /api/quiz/result` fails (already `.catch(function(){})` pattern), bucket update is still applied locally for the session.
- **State lifecycle risks**: `BUCKET_MAP` is in-memory only. If the tab refreshes, it re-fetches from server. No orphan state possible. Two-tab scenario: tabs have independent `BUCKET_MAP`s that diverge, but `quiz_results` is consistent (append-only). Acceptable.
- **API surface parity**: `POST /api/quiz/result` is unchanged. One new GET endpoint. No breaking changes.
- **Integration test scenarios**: (1) New user → all Unseen → random draw. (2) User with mixed history → verify bucket assignments match expected. (3) Answer correctly twice → verify promotion to Strong. (4) Answer wrong after Strong → verify demotion to Weak. (5) Category switch → verify deck rebuild with new category's buckets.

## Success Metrics

- Students who have answered questions before see weak questions more frequently than strong ones
- Progression indicator accurately reflects mastery state
- No regression in existing quiz functionality

## Dependencies & Prerequisites

- Existing `quiz_results` data is sufficient (confirmed — schema has `session_id`, `question_id`, `is_correct`, `answered_at`)
- No external dependencies or new packages required

## Sources & References

### Origin

- **Origin document:** [docs/brainstorms/2026-03-24-leitner-question-selection-requirements.md](docs/brainstorms/2026-03-24-leitner-question-selection-requirements.md) — Key decisions carried forward: 3-bucket system, always-on, consecutive-correct promotion, visible progression indicator

### Internal References

- Current shuffle function: `index.html:2672` (Fisher-Yates)
- Question filter: `index.html:4260` (`getQs()`)
- Timed quiz shuffle: `index.html:4505` (`qzShuffle`)
- Focus mode shuffle: `index.html:4742` (`qzFShuffle`)
- Learning mode start: `index.html:4366` (`learnStart`)
- Learning mode rate: `index.html:4413` (`learnRate` — no persistence, needs change)
- Focus mode answer: `index.html:4803` (`qzFAnswer` — writes to quiz_results)
- Quiz results insert: `server.js:507-516`
- Quiz history endpoint: `server.js:736-743` (LIMIT 50 — new endpoint needed)
- Stats endpoint: `server.js:687-708` (COALESCE pattern to reuse)
- FK constraint: `server.js:89` (ON DELETE SET NULL — bucket computation must handle NULLs)
