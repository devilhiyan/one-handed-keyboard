# Proposal: Kanata AHK Mouse Bridge

## 1. Goal
Enable reliable mouse emulation (movement, clicking, scrolling) within the Kanata keyboard layout by bridging Kanata outputs to an AutoHotkey script.

## 2. Context / Problem
- **Current State**: Kanata is configured to send mouse events directly via Interception/WinIO.
- **Issue**: Mouse movement is not functioning, likely due to driver conflicts or OS-level restrictions on the injection method.
- **Constraint**: The user requires mouse functionality to be integrated into the keyboard layout (e.g., WASD for mouse movement).

## 3. Solution Architecture
- **Kanata**: Remap the "Mouse Layer" keys to high-range Function keys (Virtual Keys) that are rarely used (F13 - F20).
    - UP -> F13
    - LEFT -> F14
    - DOWN -> F15
    - RIGHT -> F16
    - L-CLICK -> F17
    - R-CLICK -> F18
    - SCROLL-UP -> F19
    - SCROLL-DOWN -> F20
- **AutoHotkey**: Run a companion script (`kanata_mouse_bridge.ahk`) that hooks F13-F20.
    - F13 Held -> `MouseMove 0, -10` (Loop)
    - etc.

## 4. Impact
- **Files Modified**: `kanata.kbd`, `start_kanata.ps1`
- **Files Created**: `kanata_mouse_bridge.ahk`, `launch_kanata.bat`
