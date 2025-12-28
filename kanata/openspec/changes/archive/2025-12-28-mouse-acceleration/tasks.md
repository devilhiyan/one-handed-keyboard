# Tasks: Mouse Acceleration & Remapping

- [ ] **Step 1: Implement Acceleration in AHK**
    - Modify `kanata_mouse_bridge.ahk`.
    - Create a function/logic to handle acceleration:
        - Start at speed 1.
        - Accelerate linearly or exponentially up to MaxSpeed.
        - Cap at MaxSpeed (e.g., 30-40).
    - Apply this to F13, F14, F15, F16 handlers.

- [ ] **Step 3: Update Runtime & Notification**
    - Modify `start_kanata.ps1`:
        - Point to `kanata_windows_gui_wintercept_cmd_allowed_x64.exe` (ensure it exists or is unzipped).
    - Modify `kanata.kbd`:
        - Bind `lctl` tap to `(multi f24 (layer-switch ...))`.
    - Modify `kanata_mouse_bridge.ahk`:
        - Add `*F24::` handler to toggle a variable `NavMode`.
        - If `NavMode` ON: SoundBeep High, Tooltip "Navigation ON".
        - If `NavMode` OFF: SoundBeep Low, Tooltip "Navigation OFF".
