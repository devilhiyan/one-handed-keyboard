# Non-Blocking Custom Tray Menu

## 1. Problem
When the user right-clicks the System Tray icon to open the menu, the AutoHotkey script enters a modal menu loop. This pauses all timers, including the `MoveMouseTick` timer used for Navigation Mode. Consequently, the user cannot move the mouse using the keyboard keys (`E, S, D, F`) to interact with the menu itself, causing a usability deadlock for one-handed users.

## 2. Proposed Solution
Replace the native Windows/AHK Tray Menu with a **Custom GUI** that simulates a menu. Unlike the native menu, a GUI window does not block the script's main thread or timers.

### Implementation Logic
1.  **Intercept Tray Clicks**: Use `OnMessage(0x404, ...)` to listen for the `AHK_NOTIFYICON` message.
2.  **Detect Right Click**: Check for `lParam == 0x205` (`WM_RBUTTONUP`).
3.  **Show GUI**: Create and display a borderless GUI window positioned at the mouse cursor.
4.  **Populate Items**: Add buttons or clickable text controls mimicking the original menu items:
    *   "Switch Navigation Style"
    *   "Switch Mirror Style"
    *   "Pause Mirror Keys"
    *   "Reload"
    *   "Quit"
    *   (And others)
5.  **Behavior**:
    *   The GUI will be `AlwaysOnTop`.
    *   Clicking an item executes the function and closes the GUI.
    *   Clicking outside the GUI (deactivation) closes it.

## 3. Changes
*   **`Mirrored keyboard one hand.ahk2`**:
    *   Remove standard `Tray.Add` calls (or keep them as fallback but intercept the open event).
    *   Add `OnMessage(0x404, Tray_Handler)`.
    *   Add `Show_Custom_Menu()` function.
    *   Add `Create_Menu_Gui()` function.

## 4. Dependencies
*   Requires standard AHK v2 `Gui` and `OnMessage` functionality.
*   Assumes `0x404` is the message ID for the tray icon (standard for compiled/uncompiled AHK scripts).
