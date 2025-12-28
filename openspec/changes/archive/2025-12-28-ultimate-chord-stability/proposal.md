# Proposal: Ultimate Chord Stability (Atomic Processing)

## Problem
The script continues to crash during sustained chord holding. This points to a deeper conflict between the high-frequency `ChordMasterTick` timer and the `EvaluateChordBuffer` window timer, likely aggravated by `Critical` sections that may be too long or causing thread starvation.

## Proposed Changes
1.  **Eliminate Global Lock Flag**: Remove `ProcessingChords`. It can lead to "stuck" states if a thread is interrupted.
2.  **Strict Timer Mutex**:
    -   Ensure `EvaluateChordBuffer` and `ChordMasterTick` are mutually exclusive by explicitly stopping the other timer at the start of each function.
    -   Use `SetTimer TimerName, 0` to kill a timer immediately.
3.  **Leaner Repetition**:
    -   Reduce the work done in `ChordMasterTick`.
    -   Move `Critical` to only cover the data access, not the `SendInput` action. This allows the keyboard hook to process events while the key is being sent.
4.  **Buffer Uniqueness and Safety**:
    -   Use a simple array for `PendingChordKeys` instead of a Map to reduce iteration overhead.
5.  **Increase Repeat Interval**: Set to 50ms (standard) to prevent OS event buffer overflow.

## Why
By making the timers strictly sequential and reducing the time spent in `Critical` sections, we prevent the script from "choking" on its own input events, which is the most common cause of silent crashes in AutoHotkey scripts using hooks.
