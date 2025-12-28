# Tasks: Fix Mouse Stuttering

- [ ] **Step 1: Refactor AHK Loop**
    - Modify `kanata_mouse_bridge.ahk`.
    - In `MoveMouseAccel`, add a static flag or check to exit immediately if already running.
    - Alternatively, use `KeyWait` in the hotkey definition to ensure it doesn't fire repeatedly.
    - **Better Approach**: Use a Timer.
        - `*F13::SetTimer MoveLoop, 10`
        - `*F13 Up::SetTimer MoveLoop, Off`
        - This decouples the key repeat from the movement logic completely.
    
- [ ] **Step 2: Implement Timer-Based Logic**
    - Remove `While` loops inside hotkeys.
    - Create a label/function `ProcessMovement` that checks all 4 keys (F13-F16).
    - `F13/14/15/16 Down` -> Start Timer (if not running).
    - `F13/14/15/16 Up` -> Check if all keys are up -> Stop Timer.

- [ ] **Step 3: Verify Acceleration**
    - Ensure `CurrentSpeed` resets only when *all* direction keys are released, or resets per axis? 
    - Reset speed when timer stops.
