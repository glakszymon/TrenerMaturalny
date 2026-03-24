---
date: 2026-03-24
topic: leitner-question-selection
---

# Leitner Bucket System for Question Selection

## Problem Frame

Students using the quiz, focus mode, and learning modes currently receive questions in a uniform random order. This means a student who consistently answers a question correctly sees it just as often as one they always get wrong. Weak areas are not reinforced, and time is wasted on already-mastered material.

The existing `quiz_results` table already records per-question correctness and timing across sessions, but this data is never fed back into question selection.

## Requirements

- R1. Replace the current uniform random shuffle with a 3-bucket Leitner system across all quiz-like modes (timed quiz, focus mode, and learning/flashcard mode).
- R2. Three buckets: **Unseen** (never answered), **Weak** (answered but not yet promoted), **Strong** (promoted after consecutive correct answers).
- R3. Questions promote from Unseen -> Weak after their first answer attempt (correct or wrong). Questions promote from Weak -> Strong after N consecutive correct answers (N to be determined during planning, likely 2-3). One wrong answer demotes a question back one bucket (Strong -> Weak).
- R4. Draw probability is weighted toward weaker buckets. Exact distribution to be tuned during planning (starting point: ~60% Weak, ~25% Unseen, ~15% Strong when all buckets are non-empty).
- R5. Bucket state is derived from historical `quiz_results` data, persisted across sessions. When a student returns, their bucket assignments reflect all prior answers.
- R6. Display a visible progression indicator showing how many questions are in each bucket, so the student can see their mastery progress.
- R7. The system is always on -- no toggle between random and smart mode. For new users with no history, all questions start in the Unseen bucket and the experience degrades gracefully to near-random behavior.
- R8. Category filtering continues to work: when a category is selected, only questions in that category are bucketed and drawn from.

## Success Criteria

- Students who have answered questions before see their weak questions more frequently than their strong ones.
- The progression indicator accurately reflects the student's mastery state and updates in real time as they answer.
- New users with no history experience a smooth onboarding (all questions are Unseen, drawn near-randomly).
- No regression in quiz UX: timer, keyboard controls, scoring, and stats continue to work as before.

## Scope Boundaries

- No full spaced repetition (SM-2, time-based scheduling) -- this is about frequency weighting, not scheduling reviews over days/weeks.
- No difficulty metadata on questions themselves -- difficulty is inferred entirely from the student's personal performance.
- No changes to how quiz results are stored in `quiz_results` -- the existing schema is sufficient.
- No gamification beyond the progression indicator (no badges, streaks UI, or level-ups).

## Key Decisions

- **3 buckets over 4-5**: Simpler mental model, clearer progression, less edge-case tuning needed.
- **Consecutive correct to promote (not single answer)**: Prevents lucky guesses from moving questions to Strong prematurely. One wrong answer still demotes immediately to catch forgotten material.
- **Always on**: Reduces UI complexity and ensures all students benefit without needing to discover a toggle.
- **Bucket approach over weighted random**: Enables visible progression tracking, which was a desired feature.

## Dependencies / Assumptions

- The existing `quiz_results` data is sufficient to reconstruct bucket state (question ID, correctness, session ordering).
- Bucket state can be computed on the frontend from fetched results, or pre-computed on the backend -- to be decided during planning.

## Outstanding Questions

### Deferred to Planning
- [Affects R3][Needs research] Exact value of N for consecutive correct answers to promote (2 vs 3). May want to test with real data.
- [Affects R4][Technical] Exact draw probability distribution across buckets. Starting suggestion (60/25/15) needs validation.
- [Affects R5][Technical] Whether bucket state should be computed client-side from raw `quiz_results` or pre-computed and stored on the backend. Tradeoff between simplicity and performance with large result sets.
- [Affects R6][Technical] UI design for the progression indicator -- where it appears and how it integrates with the existing quiz UI.
- [Affects R4][Technical] Fallback behavior when a bucket is empty (e.g., all questions are Strong). Likely redistribute probability to remaining buckets.

## Next Steps

→ `/ce:plan` for structured implementation planning
