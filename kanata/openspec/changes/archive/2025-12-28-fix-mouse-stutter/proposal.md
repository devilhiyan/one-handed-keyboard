# Proposal: Fix Mouse Stuttering

## 1. Goal
Eliminate the start-stop stuttering behavior when holding down mouse movement keys.

## 2. Issue Analysis
- **Symptom**: Mouse moves, stops, moves again while key is held.
- **Cause**: Keyboard autorepeat sends multiple `Down` events. AHK's default behavior allows new threads to interrupt existing ones (`#MaxThreadsPerHotkey`), causing the `While` loop to restart or conflict.
- **Solution**: 
    1.  Use `KeyWait` to prevent re-triggering the hotkey while it's already active.
    2.  Check if the "Movement Loop" is already running before starting a new one.

## 3. Changes
### AutoHotkey (`kanata_mouse_bridge.ahk`)
- Add logic to ignore the hotkey if the key is already physically down and the loop is active.
- Refactor `MoveMouseAccel` to be robust against re-entry.

## 4. Impact
- **Files Modified**: `kanata_mouse_bridge.ahk`.
