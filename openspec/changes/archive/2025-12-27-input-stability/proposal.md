# Proposal: Input Stability & Hook Reliability

## Goal
Optimize the input engine to prevent "input bleeding" (where native keys leak through the script) and eliminate crashes/hangs during rapid multi-key presses (chords).

## Current State
- The script uses a mix of `InputHook` for state tracking and standard `Space & key` hotkeys.
- Rapid input sometimes overwhelms the AHK message queue, causing the script to drop hotkeys and the OS to fallback to native typing.
- Multiple simultaneous key presses (chords) can occasionally lead to thread competition or evaluation crashes.

## Proposed Changes

### 1. Robust Hook Suppression
- Enable `#MaxThreadsBuffer On` to ensure that keystrokes occurring while a hotkey is already running are queued rather than ignored.
- Use the `$*` (wildcard + hook) prefix for all core typing keys to ensure strict capture and suppression of native input regardless of modifier state.

### 2. Synchronization & Critical Sections
- Use the `Critical` command in `PerformChord` and `ChordMasterTick` to prevent thread interruption during the high-speed evaluation of key states.
- Ensure `KeyTracker` updates are atomic by wrapping the `InputHook` callbacks in `Critical` if needed.

### 3. Prefix Leak Prevention
- Refactor the `Space` release logic. If a chord or mirrored key was sent while `Space` was held, the subsequent `Space Up` must be strictly suppressed. 
- Ensure `A_PriorKey` logic is not fooled by rapid interleaved events.

### 4. Optimized Send Handling
- Standardize on `SendMode "Input"` and ensure `SetKeyDelay` is balanced (e.g., `0, 0` or `SetKeyDelay -1, -1` only when safe).
- Add a small `Sleep 1` or `Critical` buffer in `MirrorSend` to prevent overwhelming the target application's input buffer.

## Expected Outcome
- Zero input leakage: the keyboard will never type natively while the script is active and the hotkeys are matched.
- Rock-solid stability during "mash" scenarios (multiple keys pressed simultaneously).
- No more crashes during complex Halmak chord sequences.
