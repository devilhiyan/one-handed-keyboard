# Proposal: Fix Chord Repeat and Prevent Input Bleeding

## Problem
When a chord is held for more than 200ms, the Windows auto-repeat mechanism triggers the chord hotkeys again. This starts new 200ms buffering windows. Because Windows often only repeats the most recently pressed key, these new windows often fail to capture the full set of keys (e.g., they see `a+d` instead of `a+s+d`). This causes two issues:
1.  **Input Bleeding**: The "Typing Fallback" logic in `EvaluateChordBuffer` triggers because the partial set doesn't match a chord.
2.  **Repetition Failure**: The original chord repeat is interrupted or superseded by partial chord actions.

## Proposed Changes
1.  **Ignore Auto-Repeats**: Update `PerformChord` to ignore incoming keys if they are already part of a currently active chord in `ActiveChords`.
2.  **Physical State Validation**: Modify `EvaluateChordBuffer` to check the actual physical state (`GetKeyState`) of keys when a window expires. This ensures that even if only one key auto-repeated, the full held set is considered.
3.  **Prioritize Complex Chords**: Ensure that 3nd key combinations always take precedence over 2-key subsets during the evaluation.
4.  **Suppress Fallback during Active Chords**: Do not send remapped characters if the user is still holding any key involved in a successful chord.

## Why
This ensures that holding a chord results in a continuous stream of the intended action (e.g., Backspace) without leaking the underlying characters (e.g., 'e', 'a', 'i').
