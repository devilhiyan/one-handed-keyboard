# Update Navigation Mode to Keyboard WASD & Toggle Logic

## Goal
Update the navigation mode to allow switching between "Keyboard Navigation Mode" and "Mouse Navigation Mode" using `Ctrl + Space`. 
Configure the Keyboard Navigation Mode to use WASD for movement and specific Halmak chords for Home/End.

## Context
The user wants to toggle between two distinct navigation behaviors:
1.  **Keyboard Navigation Mode** (Default/Transient):
    -   `w`, `a`, `s`, `d` -> Up, Left, Down, Right.
    -   `q` + `w` (Halmak `cs`) -> Home.
    -   `w` + `e` (Halmak `st`) -> End.
    -   `Space + w/a/s/d` -> Mouse Movement.
2.  **Mouse Navigation Mode** (Permanent/MouseMode):
    -   `w`, `a`, `s`, `d` -> Mouse Movement.
    -   `Space + w/a/s/d` -> Up, Left, Down, Right.

Toggle key: `Ctrl + Space`.

## Changes
1.  **Modify Toggle Logic:**
    -   Update `^Space` hotkey to toggle between "Keyboard Navigation Mode" and "Mouse Navigation Mode".
    -   Update notifications to reflect these names.
2.  **Update WASD Mappings:**
    -   Refine the `#HotIf` blocks for `NavMode && MouseMode` and `NavMode && !MouseMode` for `NavStyle == "Old"`.
3.  **Update Chords:**
    -   Ensure `qw` (Halmak `cs`) and `we` (Halmak `st`) are mapped to Home and End respectively in `NavMode`.
    -   Note: `qw` currently maps to `WheelUp` in mouse mode, we should ensure it maps to `Home` in keyboard mode.