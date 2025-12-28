# Proposal: Mouse Acceleration & Key Remapping

## 1. Goal
Implement smooth mouse acceleration (momentum) and update mouse layer key bindings to match user preference.

## 2. Changes
### AutoHotkey (`kanata_mouse_bridge.ahk`)
- **Acceleration**: Instead of constant speed, mouse movement will start slow (`1`) and accelerate to `MaxSpeed` while the direction key is held.
- **Reset**: Speed resets when keys are released.

### Kanata Runtime
- Switch from CLI (`kanata.exe`) to GUI executable (`kanata_windows_gui_wintercept_cmd_allowed_x64.exe`) to allow for system tray presence or status window if desired.
- **Notification**: Use AHK to provide audio/visual feedback when toggling Navigation Mode (triggered by a virtual key from Kanata).
- **Mouse Layer Updates**:
    - **Caps Lock** (`caps`) -> **Left Click** (`f17`).
    - **Left Shift** (`lsft`) -> **Right Click** (`f18`) (via chord/alias).
    - **Space** (`spc`) -> **Space**.
    - **Chord**: `(lsft spc)` -> **Shift Modifier** (`lsft`).
    - **Previous Mappings**:
        - Remove old bindings to ensure clean slate.

## 3. Impact
- **Files Modified**: `kanata.kbd`, `kanata_mouse_bridge.ahk`.
