# Kanata Mouse Bridge Specification (Fixed)

## Navigation Mode Toggle
-   **Key:** `F24` (Sent by Kanata when `Ctrl` is tapped).
-   **Action:** Toggles `NavMode`.

## Mouse Mode Toggle
-   **Key:** `Ctrl + Space`.
-   **Action:** Toggles `MouseMode` (Keyboard-First vs Mouse-First).

## Mode Behaviors

### Keyboard Navigation Mode (`MouseMode = 0`)
-   `F13-F16` (Kanata WASD) -> Arrow Keys.
-   `F19-F20` (Kanata Q/E) -> Home/End.
-   `Up/Down/Left/Right` (Kanata Space+WASD) -> Mouse Movement.
-   `Home/End` (Kanata Space+Q/E) -> Mouse Wheels.

### Mouse Navigation Mode (`MouseMode = 1`)
-   `F13-F16` (Kanata WASD) -> Mouse Movement.
-   `F19-F20` (Kanata Q/E) -> Mouse Wheels.
-   `Up/Down/Left/Right` (Kanata Space+WASD) -> Arrow Keys.
-   `Home/End` (Kanata Space+Q/E) -> Home/End.
