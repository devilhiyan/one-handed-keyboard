# Spec: Chord Repeat Logic

## 1. Auto-Repeat Suppression
- If a chord (e.g., `ads`) is already in `ActiveChords`, any call to `PerformChord` with a subset of those keys (e.g., `a, s` or `d, s`) MUST be ignored.

## 2. Evaluation Refinement
- When the 200ms window expires, the script SHALL:
    1.  Refresh the `PendingChordKeys` buffer with all keys currently physically held that belong to the chord set.
    2.  Sort and identify the longest possible match in `ChordMap`.
    3.  If no match is found AND no keys are currently held, perform fallback typing.
    4.  If no match is found BUT keys are still held, wait or do nothing (to prevent bleeding).

## 3. Continuous Action
- Repetition SHALL trigger every 50ms after the initial 200ms delay.
- The `count` in `ActiveChords` data should reset after firing to allow a consistent rate, or use a threshold of 1 for subsequent fires.
