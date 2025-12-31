# Navigation Mode Specification

## Toggle Command
-   **Shortcut:** `Ctrl + Space` (when `NavMode` is active)
-   **Action:** Toggles between **Keyboard Navigation Mode** and **Mouse Navigation Mode**.

## Keyboard Navigation Mode (`MouseMode = 0`)
Priority is given to keyboard arrows.

### WASD Style
-   **Direct Press:**
    -   `w`: Up Arrow
    -   `a`: Left Arrow
    -   `s`: Down Arrow
    -   `d`: Right Arrow
    -   `q + w` (Halmak `cs`): Home
    -   `w + e` (Halmak `st`): End
-   **Space + Key:**
    -   `Space + w`: Mouse Up
    -   `Space + a`: Mouse Left
    -   `Space + s`: Mouse Down
    -   `Space + d`: Mouse Right
    -   `Space + q`: Mouse Wheel Up
    -   `Space + e`: Mouse Wheel Down

## Mouse Navigation Mode (`MouseMode = 1`)
Priority is given to mouse movement.

### WASD Style
-   **Direct Press:**
    -   `w`: Mouse Up
    -   `a`: Mouse Left
    -   `s`: Mouse Down
    -   `d`: Mouse Right
    -   `q`: Mouse Wheel Up
    -   `e`: Mouse Wheel Down
-   **Space + Key:**
    -   `Space + w`: Up Arrow
    -   `Space + a`: Left Arrow
    -   `Space + s`: Down Arrow
    -   `Space + d`: Right Arrow
    -   `Space + q`: Home
    -   `Space + e`: End