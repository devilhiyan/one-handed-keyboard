# Proposal: Update Mouse & Keyboard Navigation Actions

## Goal
Customize the navigation experience when in **Navigation Mode** (toggled via Left Ctrl). This affects both the "Mouse Navigation" (Permanent) and "Keyboard Navigation" (Transient) sub-modes.

## Mappings

### 1. Mouse Navigation Mode (`MouseMode = 1`)
*   **Physical Q** -> Mouse Wheel Up
*   **Physical E** -> Mouse Wheel Down
*   **Physical W** -> Mouse Move Up (Existing)

### 2. Keyboard Navigation Mode (`MouseMode = 0`)
*   **Combo (W + Q)** -> Home
*   **Combo (W + E)** -> End
*   **Physical W** -> Arrow Up (Existing)

## Implementation
We will use a dedicated chord group `mouse-nav-chords` in Kanata's `mouse` layer. This allows us to intercept the `W+Q` and `W+E` combinations specifically when in navigation mode, without conflicting with the `halmak` typing layer.

### Kanata Changes (`kanata.kbd`)
*   Update `mouse` layer to use chords for `q`, `w`, and `e`.
*   Map chords to F-keys for the AHK bridge:
    *   `q` -> `f19`
    *   `w` -> `f13`
    *   `e` -> `f20`
    *   `q+w` -> `f21`
    *   `w+e` -> `f22`

### AutoHotkey Changes (`kanata_mouse_bridge.ahk`)
*   Update logic to handle the new F-key assignments based on the current `MouseMode`.