# Fix Mouse Mode Navigation in Kanata Bridge

## Goal
Fix the issue where Mouse Navigation Mode (`WASD` -> Mouse Movement) is not working, even though Keyboard Navigation Mode works.

## Context
The user reports that in Mouse Mode, the keys don't move the mouse. In Keyboard Mode, `Space+WASD` (which sends Arrows) *does* move the mouse.
This suggests that `GetKeyState("F13")` (used in Mouse Mode) is failing to detect the virtual key press sent by Kanata, whereas `GetKeyState("Up")` (used in Keyboard Mode) works.
Virtual keys injected by other low-level hooks (Kanata) sometimes don't reflect correctly in AHK's `GetKeyState` when they are immediately trapped by an AHK hotkey.

## Solution
Switch from polling `GetKeyState` to explicit State Tracking using KeyDown/KeyUp hotkeys.
This ensures that AHK registers the "Held" state based on the events it intercepts, regardless of what the OS logical state reports.

## Changes
1.  **Modify `kanata/kanata_mouse_bridge.ahk`**:
    -   Introduce `MoveState` object to track `up`, `down`, `left`, `right`.
    -   Update Movement Hotkeys (`F13-F16` and `Arrows`) to:
        -   On Down: Set corresponding `MoveState` to 1, call `StartMove()`.
        -   On Up: Set corresponding `MoveState` to 0.
    -   Update `ProcessMovement` to read from `MoveState` instead of `GetKeyState`.
    -   Consolidate logic so `F13` updates `up` state if `MouseMode=1`, etc.

## Logic Table

| Physical (Kanata) | AHK Hotkey | Mode | Action |
| :--- | :--- | :--- | :--- |
| **F13** (W) | `*F13` | Mouse (1) | Set `MoveState.up = 1` -> Move Mouse |
| | | Keyboard (0) | Send `{Up}` |
| **Up** (Spc+W) | `*Up` | Mouse (1) | Send `{Up}` |
| | | Keyboard (0) | Set `MoveState.up = 1` -> Move Mouse |

(And so on for other directions)
