# Spec: Simplified Chord Repeat Logic

## 1. Single Chord Constraint
- The system SHALL only support one active repeating chord at a time.
- If a new chord is evaluated while another is active, the old one is replaced or the new one is ignored (replacement is preferred for responsiveness).

## 2. Repetition Guard
- The `ChordMasterTick` SHALL check the physical state of the `CurrentChord` keys.
- If any key is released, `CurrentChord` MUST be set to an empty string and the timer stopped.

## 3. Auto-Repeat Filtering
- Key auto-repeats from Windows MUST NOT start new `EvaluateChordBuffer` windows if those keys are part of the `CurrentChord`.
