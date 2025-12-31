# Fix Kanata Mouse Bridge Toggles and WASD

## Goal
Fix the issues where:
1.  `NavMode` toggle via `Ctrl` requires holding (should be a tap).
2.  WASD keys do not work for keyboard or mouse navigation.

## Context
The current implementation fails because:
-   Kanata intercepts `Ctrl` and sends `F24` on tap. AHK was trying to use native `Ctrl Up`, which Kanata suppresses or delays.
-   AHK was configured to look for physical `w,a,s,d` keys, but Kanata reassigns these to `F13-F16` (movement) and standard `Up/Down/Left/Right` (arrows) when its mouse layer is active.

## Changes
1.  **Toggle Logic:**
    -   Restore `*F24::` as the primary toggle for `NavMode`.
    -   Remove the `~Ctrl Up` logic.
2.  **WASD Mapping Logic:**
    -   Restore hotkeys for `F13-F16`, `F19-F20`, `Up/Down/Left/Right`, and `Home/End`.
    -   Implement behavior swapping based on `MouseMode`:
        -   **Keyboard Navigation Mode (`MouseMode = 0`):**
            -   `F13-F16` -> Arrows.
            -   `F19-F20` -> Home/End.
            -   `Up/Down/Left/Right` -> Mouse Movement.
            -   `Home/End` -> Mouse Wheels.
        -   **Mouse Navigation Mode (`MouseMode = 1`):**
            -   `F13-F16` -> Mouse Movement.
            -   `F19-F20` -> Mouse Wheels.
            -   `Up/Down/Left/Right` -> Arrows.
            -   `Home/End` -> Home/End.
3.  **ProcessMovement Logic:**
    -   Update `ProcessMovement` to check the keys sent by Kanata based on the current `MouseMode`.
