# Fix Tray Menu Positioning

## 1. Problem
The Custom Tray Menu appears at incorrect coordinates because the script relies on the default `CoordMode` (which is typically relative to the active window) when using `MouseGetPos`. When clicking the tray icon, the active window might be the Taskbar or another application, causing unpredictable placement. Additionally, the menu is not intelligently anchored "above" the icon when the taskbar is at the bottom.

## 2. Proposed Solution
Update `Show_Custom_Menu` in `Mirrored keyboard one hand.ahk2` to:
1.  Enforce `CoordMode "Mouse", "Screen"` so coordinates are always absolute.
2.  Calculate the Menu's dimensions before displaying it to properly position it above the cursor (standard Tray behavior).

## 3. Implementation Details
```ahk
Show_Custom_Menu() {
    Global CustomMenuGui, NavStyle, MirrorStyle, NavToggleKey
    
    ; ... (GUI Build Code) ...
    
    ; Calculate Position
    CoordMode "Mouse", "Screen"
    MouseGetPos(&mx, &my)
    
    CustomMenuGui.Show("Hide AutoSize") ; Calculate layout without showing
    CustomMenuGui.GetPos(,, &w, &h)
    
    ; Determine X (Center on mouse)
    nx := mx - (w / 2)
    
    ; Determine Y (Above mouse if space permits, else below)
    ; Assuming Taskbar is usually at bottom
    if (my > A_ScreenHeight / 2) {
        ny := my - h - 15 ; Show above
    } else {
        ny := my + 15 ; Show below
    }
    
    ; Screen Boundaries
    if (nx < 0)
        nx := 0
    if (nx + w > A_ScreenWidth)
        nx := A_ScreenWidth - w
        
    CustomMenuGui.Show("NoActivate x" nx " y" ny)
}
```
