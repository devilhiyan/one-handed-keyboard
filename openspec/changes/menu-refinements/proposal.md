# Menu Refinements: Focus Handling & Dynamic Updates

## 1. Problem
The current Custom Tray Menu has two usability issues:
1.  **Does not close on click-away**: Being a `NoActivate` window without focus tracking, clicking outside requires manual closure via a "Close" button.
2.  **Closes on Toggle**: Clicking "Switch Navigation Style" closes the menu, requiring the user to reopen it if they wanted to check the new state or toggle back.

## 2. Proposed Solution

### A. Focus Tracking (Auto-Close)
1.  **Activate Window**: Change `Gui.Show("NoActivate ...")` to `Gui.Show("...")` (Active). This allows the window to receive Focus messages.
2.  **Monitor Deactivation**: Use `OnMessage(0x0006, ...)` (`WM_ACTIVATE`) to detect when the menu loses focus (e.g., user clicks the desktop or another app).
3.  **Action**: When focus is lost (`wParam == 0`), destroy the menu.

### B. Dynamic Updates (Cycle without Closing)
1.  **Retain Menu**: Modify the "Click" handlers for Navigation and Mirror style buttons. instead of calling `Destroy()`, they will:
    *   Execute the toggle function (`ToggleNavStyle`, etc.).
    *   Update the Button's `Text` property to reflect the new state immediately.
2.  **Helpers**: Extract text generation logic into `GetNavText()` and `GetMirrorText()` for reuse.

## 3. Implementation Details
```ahk
Global CustomMenuGui := ""
Global BtnNavStyle := ""
Global BtnMirrorStyle := ""

Menu_LostFocus(wParam, lParam, msg, hwnd) {
    if (IsObject(CustomMenuGui) && hwnd == CustomMenuGui.Hwnd && wParam == 0) {
        ; Use a Timer to allow the click to potentially process if it was on a valid control? 
        ; Actually, if we click outside, we want it gone.
        SetTimer CloseMenu, -50
    }
}

CloseMenu() {
    if IsObject(CustomMenuGui)
        CustomMenuGui.Destroy()
}

Show_Custom_Menu() {
    ; ... (Setup) ...
    OnMessage(0x0006, Menu_LostFocus)
    
    ; ... (Items) ...
    BtnNavStyle := CustomMenuGui.Add("Button", BtnStyle, GetNavText())
    BtnNavStyle.OnEvent("Click", (*) => (ToggleNavStyle(), BtnNavStyle.Text := GetNavText()))
    
    ; ... (Show with Activation) ...
    CustomMenuGui.Show("x" nx " y" ny)
}
```
