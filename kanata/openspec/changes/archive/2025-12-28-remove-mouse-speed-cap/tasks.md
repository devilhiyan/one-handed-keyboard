# Tasks: Remove Mouse Speed Cap

- [ ] **Step 1: Update AHK Script**
    - Modify `kanata_mouse_bridge.ahk`.
    - Delete the line `MaxSpeed := 25`.
    - Remove the conditional check `if (CurrentSpeed < MaxSpeed)` and the capping logic `if (CurrentSpeed > MaxSpeed) CurrentSpeed := MaxSpeed`.
    - Ensure `CurrentSpeed *= AccelFactor` runs unconditionally while movement keys are held.
