# Ctrl Toggle Specification

## Toggle Command
-   **Shortcut:** `Ctrl` (Tap)
-   **Action:** Toggles **Navigation Mode** ON/OFF.
-   **Condition:** Only when `NavToggleKey` is set to `"Ctrl"`.

## Toggle Logic
-   Triggers on `Ctrl Up` if `A_PriorKey` was `LControl` or `RControl`.
-   Uses `Critical` to prevent interruption.
-   Provides ToolTip notification and SoundBeep.
