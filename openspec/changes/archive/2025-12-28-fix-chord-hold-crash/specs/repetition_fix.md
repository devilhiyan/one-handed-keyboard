# Spec: Robust Chord Repetition

## 1. Thread Safety
- The system SHALL use `Critical` only for the duration of Map/Object updates.
- `SendInput` and `MouseMove` MUST NOT be called while the thread is `Critical`.
- All chord-related timers MUST explicitly disable the other competing timers at the start of their execution.

## 2. State Management
- `CurrentChord` SHALL be the single source of truth for the active repeating chord.
- If `CurrentChord` is set to `""`, all repetition timers MUST stop immediately.
- `PendingChordKeys` MUST be cleared at the end of every evaluation, regardless of whether a chord was resolved.

## 3. Repetition Logic
- The `ChordMasterTick` SHALL check the physical state of all keys in the `CurrentChord`.
- If any key is physically released (as tracked by `KeyTracker`), the repetition MUST stop.
- The repetition rate SHALL be set to **50ms** by default, but the logic MUST be robust enough to handle rates down to 30ms.

## 4. Error Handling
- The evaluation and repetition logic SHOULD be wrapped in `try...catch` blocks.
- Any unexpected errors SHOULD be logged or handled gracefully without terminating the script.
