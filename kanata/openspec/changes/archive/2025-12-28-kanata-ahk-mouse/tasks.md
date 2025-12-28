# Tasks: Kanata AHK Mouse Bridge

- [ ] **Step 1: Create Bridge Script**
    - Create `kanata_mouse_bridge.ahk`.
    - Implement smooth looping movement for F13-F16.
    - Implement clicking for F17-F18.
    - Implement scrolling for F19-F20.

- [ ] **Step 2: Update Kanata Configuration**
    - Backup `kanata.kbd`.
    - Modify the `mouse` layer in `kanata.kbd`.
    - Replace `movemouse-*` and click actions with keys `f13` through `f20`.

- [ ] **Step 3: Update Startup Logic**
    - Modify `start_kanata.ps1` to launch `kanata_mouse_bridge.ahk` before starting Kanata.
    - Create `launch_kanata.bat` to execute `start_kanata.ps1` with appropriate bypass flags.
    - Ensure cleanup (killing AHK script) when Kanata exits.
