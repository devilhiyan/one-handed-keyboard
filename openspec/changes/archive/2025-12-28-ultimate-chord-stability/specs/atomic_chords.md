# Spec: Atomic Chord Management

## 1. Timer Exclusivity
- When `EvaluateChordBuffer` runs, it MUST stop `ChordMasterTick`.
- When `ChordMasterTick` is started, it MUST stop `EvaluateChordBuffer`.

## 2. Repetition State
- `CurrentChord` SHALL be the sole source of truth for repetition.
- If `CurrentChord` is set to `""`, the repeat timer MUST stop.

## 3. Concurrency
- `Critical` SHALL be used to protect Map/Object access.
- `SendInput` SHALL be executed OUTSIDE of `Critical` whenever possible to allow the OS to process hook events.
