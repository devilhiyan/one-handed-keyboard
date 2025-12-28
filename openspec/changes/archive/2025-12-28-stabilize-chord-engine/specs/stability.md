# Spec: Stable Chord Logic

## 1. Concurrency Mandate
- EVERY function that interacts with `PendingChordKeys` or `ActiveChords` MUST be `Critical`.
- Iteration over `ActiveChords` MUST use `.Clone()` if there is ANY possibility of deletion or modification during the loop.

## 2. State Transition
- `ChordTimerActive` MUST NOT be set to `False` until the buffer has been cleared and all actions have been processed.
- This ensures that new timers aren't started while an existing evaluation is in progress.

## 3. Empty State Safety
- Functions MUST handle empty `keys` arrays or empty `keyStr` strings without throwing errors.
- `GetRemappedKey` MUST return the input key if no mapping is found to prevent null returns.
