# Proposal: Fix Chord Hold Crash

The script crashes when chord keys (e.g., `w+e`, `s+d`) are pressed and held. This is a critical stability issue that prevents reliable navigation and text editing.

## Potential Causes
1. **Critical Section Deadlock/Starvation**: The use of `Critical()` in both the hotkey threads and the timer threads may be causing a race condition or an overflow in the message queue when Windows auto-repeat triggers the hotkeys at a high frequency.
2. **Timer Re-entrancy**: Although `SetTimer, 0` is used, the high-speed repetition might be causing timers to overlap in a way that exhausts the stack or causes an unhandled exception in the AHK runtime.
3. **State Corruption**: If `CurrentChord` or `PendingChordKeys` are modified in an unexpected order during a `Critical` section that is interrupted by a high-priority hook event.

## Proposed Changes
1. **Atomic Timer Management**: Refactor `PerformChord`, `EvaluateChordBuffer`, and `ChordMasterTick` to use a more strict state-machine approach.
2. **Minimize Critical Sections**: Reduce the scope of `Critical()` to the absolute minimum required for state updates, and ensure it is NEVER active during a `SendInput` or `MouseMove` call.
3. **Robustness Checks**: Add `try...catch` blocks around the core chord evaluation logic to prevent hard crashes and allow the script to recover.
4. **Auto-Repeat Suppression**: Improve the suppression of Windows auto-repeat to ensure that hotkey threads exit as fast as possible when a chord is already active.
5. **Optimize Key State Checking**: Use pre-calculated VK codes exclusively in the repetition loop.

## Desired Outcome
The script should be able to handle sustained chord holding (e.g., holding `w+e` for several seconds) without crashing, hanging, or failing to repeat the intended action.
