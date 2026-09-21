#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
#MaxThreadsPerHotkey 2
SetMouseDelay -1 

; Hotkey rate limit tuning:
; Disable the 70 hotkeys / 2000ms warning dialog for intentionally held keys (e.g. Tab+Q peek)
A_HotkeyInterval := 0
A_MaxHotkeysPerInterval := 10000

; Debug Logging
; FileAppend "AHK Script Started at " A_Now "`n", "ahk_debug.log"
; OnExit((ExitReason, ExitCode) => FileAppend("AHK Script Exiting: " ExitReason " Code: " ExitCode " at " A_Now "`n", "ahk_debug.log"))

; FileAppend "Initializing configuration...`n", "ahk_debug.log"

; ==============================================================================
; Kanata Mouse Bridge
; Maps F13-F20 and Arrow Keys to Mouse/Keyboard Actions based on Mode
; ==============================================================================

; Configuration
MinSpeed := 1
MaxSpeed := 35
AccelFactor := 0.02
ScrollSpeed := 1
CurrentSpeed := MinSpeed

; Navigation Settings
Global MouseMode := 1 ; 0 = Keyboard Nav (Arrows), 1 = Mouse Nav (Movement)

; Navigation State
Global NavMode := false
Global Ishyn := true
Global MiddleClickMode := "Double" ; "Double" = Double-click NVDA / Single-click normal; "Single" = Single-click NVDA / Space+click normal
Global MiddleClickActive := false
Global MButtonWaitingForSecond := false
Global MoveUpVar := 0, MoveDownVar := 0, MoveLeftVar := 0, MoveRightVar := 0
Global CheatSheetGui := ""
Global CheatPic := ""
Global CurPicX := 0, CurPicY := 0, CurPicW := 0, CurPicH := 0
Global BasePicX := 0, BasePicY := 0, BasePicW := 0, BasePicH := 0
Global CurZoom := 1.0
Global CheatInputHook := ""
Global F9Pressed := false
Global F9DownTime := 0
Global F9ClosedByToggle := false

; Key Output Overlay Settings & State
Global SettingsFile := A_ScriptDir . "\kanata_settings.ini"
Global ShowKeyOverlay := Integer(IniRead(SettingsFile, "Settings", "ShowOutputKeys", "0"))
Global StickyHoldEnabled := Integer(IniRead(SettingsFile, "Settings", "StickyHoldEnabled", "0"))
Global OutputKeyGui := ""
Global OutputKeyText := ""
Global OutputKeyTrail := ""
Global OutputKeyHook := ""
Global OutputRecentKeys := []
Global ActiveStickyMods := Map()
Global ActiveHeldKeys := Map()
Global ActiveChainDisplay := []
Global LastModifierTapped := 0
Global LastModifierTapTime := 0

; Tray Menu Configuration
try {
    A_TrayMenu.Add() ; Separator
    A_TrayMenu.Add("Show Output Keys (Space + X)", ToggleKeyOverlay)
    A_TrayMenu.Add("Sticky Modifiers (Ctrl + Space + X)", ToggleStickyModifiers)
    UpdateKeyOverlayMenu()
    UpdateStickyModifiersMenu()
}

; Initialize Overlay if enabled in settings
if (ShowKeyOverlay) {
    EnsureOutputKeyGui()
    SetTimer HideOutputKeyOverlay, -2000
}

; Start InputHook if either Key Overlay or Sticky Modifiers is enabled
if (ShowKeyOverlay || StickyHoldEnabled) {
    StartOutputKeyHook()
}

; FileAppend "Configuration initialized. Setting up functions...`n", "ahk_debug.log"

; ------------------------------------------------------------------------------
; Notification Helper
; ------------------------------------------------------------------------------
Notify(Text, Duration:=2000) {
    ToolTip Text
    SetTimer () => ToolTip(), -Duration
}

; ------------------------------------------------------------------------------
; Navigation Mode Control (F24 = ON, F23 = hyn, F22 = QWERTY)
; ------------------------------------------------------------------------------
*F24:: {
    if GetKeyState("Ctrl") && GetKeyState("Shift") {
        ChangeBrightness(-5) ; Down
        return
    }
    global NavMode := true
    global Ishyn := false
    CloseCheatSheet()
    Notify("Navigation Mode: ON (" . (MouseMode ? "Mouse Nav" : "Keyboard Nav") . ")")
    ; Distinct sound for Navigation Mode (High pitch beep, 2 beeps)
    Loop 2 {
        SoundBeep 1200, 150
        Sleep 50
    }
}

*F23:: {
    if GetKeyState("Ctrl") && GetKeyState("Shift") {
        ChangeBrightness(5) ; Up
        return
    }
    global NavMode := false
    global Ishyn := true
    Notify("Layout: hyn")
    ; Distinct sound for hyn Mode (Medium pitch beep, 1 beep)
    SoundBeep 750, 150
}

^!F22:: {
    global NavMode := false
    global Ishyn := false
    CloseCheatSheet()
    Notify("Layout: QWERTY")
    ; Distinct sound for QWERTY Mode (Low pitch beep, 3 beeps)
    Loop 3 {
        SoundBeep 400, 150
        Sleep 50
    }
}

; ------------------------------------------------------------------------------
; Mouse Mode Toggle (^Space - Toggle Keyboard vs Mouse Priority)
; ------------------------------------------------------------------------------
#HotIf NavMode
^Space:: {
    Global MouseMode := !MouseMode
    if (MouseMode) {
        Notify("Mouse Navigation Mode")
    } else {
        Notify("Keyboard Navigation Mode")
    }
}
#HotIf

; ------------------------------------------------------------------------------
; Shared Navigation Keys (Mapped from Kanata F17/F18)
; ------------------------------------------------------------------------------
#HotIf NavMode

; F17 = CapsLock (Mapped from Kanata)
*F17:: {
    if (MouseMode) { ; Mouse Mode -> Left Click
        Click "Down"
    } else { ; Keyboard Mode -> Enter
        SendInput "{Enter}"
    }
}
*F17 Up:: {
    if (MouseMode) {
        Click "Up"
    }
}

; F11 = Space + CapsLock (Mapped from Kanata)
*F11:: {
    if (MouseMode) { ; Mouse Mode -> Enter
        SendInput "{Enter}"
    } else { ; Keyboard Mode -> Left Click
        Click "Down"
    }
}
*F11 Up:: {
    if (!MouseMode) {
        Click "Up"
    }
}

; F18 = Shift (Physical Shift in Kanata)
*F18:: {
    if (MouseMode) { ; Mouse Mode -> Right Click
        Click "Right"
    } else { ; Keyboard Mode -> Shift
        SendInput "{Blind}{LShift Down}"
    }
}
*F18 Up:: {
    if (!MouseMode) {
        SendInput "{Blind}{LShift Up}"
    }
}

; Space + Shift (Handled via F12 from Kanata)
*F12::Click "Right"

; ------------------------------------------------------------------------------
; Mouse Wheel & Chords (Mapped from Kanata F19-F22)
; ------------------------------------------------------------------------------
#HotIf NavMode

; F19 = Q (Wheel Up in Mouse Mode)
*F19:: {
    if (MouseMode) {
        Click "WheelUp"
        Sleep 50 ; Debounce/Repeat control
    }
}

; F20 = E (Wheel Down in Mouse Mode)
*F20:: {
    if (MouseMode) {
        Click "WheelDown"
        Sleep 50
    }
}

; F21 = Q+W Chord (Home in Keyboard Mode)
*F21::SendInput "{Blind}{Home}"

; F22 = W+E Chord (End in Keyboard Mode)
*F22::SendInput "{Blind}{End}"

#HotIf

; ------------------------------------------------------------------------------
; Movement Timer Logic
; ------------------------------------------------------------------------------
ProcessMovement() {
    global ; Assume global scope for everything
    
    ; Check held state
    up    := MoveUpVar
    left  := MoveLeftVar
    down  := MoveDownVar
    right := MoveRightVar

    if (!up && !left && !down && !right) {
        SetTimer ProcessMovement, 0
        CurrentSpeed := MinSpeed
        return
    }

    moveX := 0
    moveY := 0
    if (left)
        moveX -= 1
    if (right)
        moveX += 1
    if (up) {
        moveY -= 1
    }
    if (down)
        moveY += 1

    if (moveX != 0 || moveY != 0) {
        DllCall("mouse_event", "UInt", 0x0001, "Int", Integer(moveX * CurrentSpeed), "Int", Integer(moveY * CurrentSpeed), "UInt", 0, "UPtr", 0)
        CurrentSpeed += (MaxSpeed - CurrentSpeed) * AccelFactor
    }
}

StartMove() {
    SetTimer ProcessMovement, 10
}

; FileAppend "Script initialized and ready. Entering idle state.`n", "ahk_debug.log"

; ------------------------------------------------------------------------------
; Key Mappings (Catching keys from Kanata)
; ------------------------------------------------------------------------------

#HotIf NavMode

; Keyboard Navigation Mode (MouseMode = 0)
; WASD (F13-F16) -> Arrows
; Space+WASD (Arrows) -> Mouse
#HotIf NavMode && !MouseMode
*F13::SendInput "{Blind}{Up}"
*F14::SendInput "{Blind}{Left}"
*F15::SendInput "{Blind}{Down}"
*F16::SendInput "{Blind}{Right}"

*Up:: {
    Global MoveUpVar := 1
    StartMove()
}
*Up Up::Global MoveUpVar := 0

*Left:: {
    Global MoveLeftVar := 1
    StartMove()
}
*Left Up::Global MoveLeftVar := 0

*Down:: {
    Global MoveDownVar := 1
    StartMove()
}
*Down Up::Global MoveDownVar := 0

*Right:: {
    Global MoveRightVar := 1
    StartMove()
}
*Right Up::Global MoveRightVar := 0

#HotIf

; Mouse Navigation Mode (MouseMode = 1)
; WASD (F13-F16) -> Mouse
; Space+WASD (Arrows) -> Arrows
#HotIf NavMode && MouseMode
*F13:: {
    global MoveUpVar
    ; ToolTip "Up"
    MoveUpVar := 1
    StartMove()
}
*F13 Up:: {
    global MoveUpVar
    MoveUpVar := 0
    ; ToolTip
}

*F14:: {
    global MoveLeftVar
    ; ToolTip "Left"
    MoveLeftVar := 1
    StartMove()
}
*F14 Up:: {
    global MoveLeftVar
    MoveLeftVar := 0
    ; ToolTip
}

*F15:: {
    global MoveDownVar
    ; ToolTip "Down"
    MoveDownVar := 1
    StartMove()
}
*F15 Up:: {
    global MoveDownVar
    MoveDownVar := 0
    ; ToolTip
}

*F16:: {
    global MoveRightVar
    ; ToolTip "Right"
    MoveRightVar := 1
    StartMove()
}
*F16 Up:: {
    global MoveRightVar
    MoveRightVar := 0
    ; ToolTip
}

*Up::SendInput "{Blind}{Up}"
*Left::SendInput "{Blind}{Left}"
*Down::SendInput "{Blind}{Down}"
*Right::SendInput "{Blind}{Right}"

#HotIf

; ------------------------------------------------------------------------------
; Brightness Control (WMI)
; ------------------------------------------------------------------------------
ChangeBrightness(Amount) {
    try {
        ; Get current brightness
        CurrentBrightness := 0
        For Mon in ComObjGet("winmgmts:\\.\root\wmi").ExecQuery("Select * from WmiMonitorBrightness") {
            CurrentBrightness := Mon.CurrentBrightness
            break
        }

        ; Calculate new
        NewBrightness := CurrentBrightness + Amount
        NewBrightness := Max(0, Min(NewBrightness, 100))

        ; Apply
        For Mon in ComObjGet("winmgmts:\\.\root\wmi").ExecQuery("Select * from WmiMonitorBrightnessMethods") {
            Mon.WmiSetBrightness(1, NewBrightness)
            break
        }
        Notify("Brightness: " . NewBrightness . "%", 1000)
    } catch as e {
        Notify("Brightness Error (WMI)", 2000)
    }
}

; ------------------------------------------------------------------------------
; One-Handed Keyboard Cheat Sheet Overlay (Hyn Mode Only - Maximized Fit)
; ------------------------------------------------------------------------------
CloseCheatSheet() {
    Global CheatSheetGui, CheatPic, CheatInputHook, CurZoom
    if (CheatInputHook != "") {
        hook := CheatInputHook
        CheatInputHook := ""
        try hook.Stop()
    }
    if (CheatSheetGui != "") {
        guiObj := CheatSheetGui
        CheatSheetGui := ""
        CheatPic := ""
        try guiObj.Destroy()
    }
    CurZoom := 1.0
}

GetActiveMonitorIndex() {
    monCount := MonitorGetCount()
    if (monCount <= 1)
        return 1

    ; Priority 1: Check mouse cursor position
    CoordMode "Mouse", "Screen"
    MouseGetPos &mx, &my
    mouseMon := 0
    Loop monCount {
        MonitorGet(A_Index, &mL, &mT, &mR, &mB)
        if (mx >= mL && mx < mR && my >= mT && my < mB) {
            mouseMon := A_Index
            break
        }
    }

    ; Priority 2: Check active focused application window
    activeHwnd := WinActive("A")
    winMon := 0
    if (activeHwnd) {
        try {
            winClass := WinGetClass(activeHwnd)
            if (winClass != "WorkerW" && winClass != "Progman" && winClass != "Shell_TrayWnd") {
                WinGetPos(&wx, &wy, &ww, &wh, activeHwnd)
                if (ww > 50 && wh > 50) {
                    cx := wx + (ww // 2)
                    cy := wy + (wh // 2)
                    Loop monCount {
                        MonitorGet(A_Index, &mL, &mT, &mR, &mB)
                        if (cx >= mL && cx < mR && cy >= mT && cy < mB) {
                            winMon := A_Index
                            break
                        }
                    }
                }
            }
        }
    }

    ; If mouse is on a valid monitor, use mouse monitor (where user is looking/pointing)
    if (mouseMon > 0)
        return mouseMon

    ; Fallback to active window monitor
    if (winMon > 0)
        return winMon

    return MonitorGetPrimary()
}

CheatSheetActive() {
    Global CheatSheetGui
    if (CheatSheetGui == "")
        return false
    try {
        return WinExist("ahk_id " . CheatSheetGui.Hwnd)
    }
    return false
}

ZoomCheatSheet(factor) {
    Global CheatSheetGui, CheatPic
    Global CurPicX, CurPicY, CurPicW, CurPicH
    Global BasePicX, BasePicY, BasePicW, BasePicH
    Global CurZoom

    if (CheatSheetGui == "" || CheatPic == "")
        return

    CoordMode "Mouse", "Screen"
    MouseGetPos &screenMX, &screenMY

    CheatSheetGui.GetPos(&guiX, &guiY, &guiW, &guiH)

    mouseX := screenMX - guiX
    mouseY := screenMY - guiY

    if (CurPicW <= 0 || CurPicH <= 0)
        return

    ; Normalized anchor position (0.0 to 1.0) under cursor
    u := (mouseX - CurPicX) / CurPicW
    v := (mouseY - CurPicY) / CurPicH

    ; Clamp anchor to prevent drift if cursor is in outer letterbox margins
    u := Max(0.0, Min(1.0, u))
    v := Max(0.0, Min(1.0, v))

    newZoom := CurZoom * factor
    newZoom := Max(1.0, Min(6.0, newZoom))

    ; If zoomed back to normal 1.0x, snap cleanly back to base fit
    if (newZoom <= 1.01) {
        CurZoom := 1.0
        CurPicX := BasePicX
        CurPicY := BasePicY
        CurPicW := BasePicW
        CurPicH := BasePicH
        CheatPic.Move(CurPicX, CurPicY, CurPicW, CurPicH)
        CheatPic.Redraw()
        return
    }

    k := newZoom / CurZoom
    CurZoom := newZoom

    newW := Integer(CurPicW * k)
    newH := Integer(CurPicH * k)

    ; Preserve point under mouse cursor
    newX := Integer(mouseX - (u * newW))
    newY := Integer(mouseY - (v * newH))

    ; Clamp boundaries to prevent image from moving off-screen
    if (newW > guiW) {
        newX := Min(0, Max(newX, guiW - newW))
    } else {
        newX := (guiW - newW) // 2
    }

    if (newH > guiH) {
        newY := Min(0, Max(newY, guiH - newH))
    } else {
        newY := (guiH - newH) // 2
    }

    CurPicX := newX
    CurPicY := newY
    CurPicW := newW
    CurPicH := newH

    CheatPic.Move(CurPicX, CurPicY, CurPicW, CurPicH)
    CheatPic.Redraw()
}

; ------------------------------------------------------------------------------
; Panning Handler (Hold and Drag Middle Mouse Button to Pan Zoomed Cheat Sheet)
; ------------------------------------------------------------------------------
PanCheatSheetStart() {
    Global CheatSheetGui, CheatPic
    Global CurPicX, CurPicY, CurPicW, CurPicH
    Global CurZoom

    if (CheatSheetGui == "" || CheatPic == "")
        return

    CheatSheetGui.GetPos(&guiX, &guiY, &guiW, &guiH)

    ; If image fits completely within the window, nothing to pan
    if (CurPicW <= guiW && CurPicH <= guiH)
        return

    CoordMode "Mouse", "Screen"
    MouseGetPos &startMouseX, &startMouseY
    startPicX := CurPicX
    startPicY := CurPicY

    ; Drag loop while Middle Mouse Button is held down
    while GetKeyState("MButton", "P") {
        MouseGetPos &currentMouseX, &currentMouseY
        dx := currentMouseX - startMouseX
        dy := currentMouseY - startMouseY

        newX := startPicX + dx
        newY := startPicY + dy

        ; Clamp boundaries so image remains within viewable screen area
        if (CurPicW > guiW) {
            newX := Min(0, Max(newX, guiW - CurPicW))
        } else {
            newX := (guiW - CurPicW) // 2
        }

        if (CurPicH > guiH) {
            newY := Min(0, Max(newY, guiH - CurPicH))
        } else {
            newY := (guiH - CurPicH) // 2
        }

        if (newX != CurPicX || newY != CurPicY) {
            CurPicX := newX
            CurPicY := newY
            CheatPic.Move(CurPicX, CurPicY, CurPicW, CurPicH)
            CheatPic.Redraw()
        }
        Sleep 10 ; Smooth ~100 FPS polling with low CPU
    }
}

ToggleCheatSheet() {
    Global CheatSheetGui, CheatPic, Ishyn
    Global CurPicX, CurPicY, CurPicW, CurPicH
    Global BasePicX, BasePicY, BasePicW, BasePicH
    Global CurZoom, CheatInputHook

    ; Strict requirement: only accessible in Hyn mode
    if (!Ishyn)
        return

    ; If already open, close it (toggle behavior)
    if (CheatSheetGui != "") {
        CloseCheatSheet()
        return
    }

    imgPath := A_ScriptDir . "\layout_cheatsheet.png"
    if (!FileExist(imgPath)) {
        Notify("Cheat sheet image not found!", 2000)
        return
    }

    ; Detect active monitor (where mouse or focused app is)
    targetMon := GetActiveMonitorIndex()

    ; Get monitor work area (matches maximized window bounds)
    MonitorGetWorkArea(targetMon, &wLeft, &wTop, &wRight, &wBottom)
    monW := wRight - wLeft
    monH := wBottom - wTop

    ; Native image resolution: 1600 x 1020 (ratio ~1.5686)
    imgRatio := 1600.0 / 1020.0

    ; Scale to fit screen like a maximized window (preserving aspect ratio)
    if ((monW / monH) > imgRatio) {
        ; Screen is wider: fit to full height, center horizontally
        imgH := monH
        imgW := Integer(monH * imgRatio)
        imgX := (monW - imgW) // 2
        imgY := 0
    } else {
        ; Screen is narrower/taller: fit to full width, center vertically
        imgW := monW
        imgH := Integer(monW / imgRatio)
        imgX := 0
        imgY := (monH - imgH) // 2
    }

    ; Create GUI covering the entire monitor work area like a maximized window
    CheatSheetGui := Gui("-DPIScale +AlwaysOnTop -Caption +ToolWindow", "One-Handed Keyboard Cheat Sheet")
    CheatSheetGui.BackColor := "181825"

    ; Add image control scaled to fit
    CheatPic := CheatSheetGui.Add("Picture", "x" . imgX . " y" . imgY . " w" . imgW . " h" . imgH, imgPath)

    ; Initialize base and current bounds for zoom tracking
    BasePicX := imgX
    BasePicY := imgY
    BasePicW := imgW
    BasePicH := imgH
    CurPicX := imgX
    CurPicY := imgY
    CurPicW := imgW
    CurPicH := imgH
    CurZoom := 1.0

    ; Dismiss when clicking image, closing window, or pressing Escape
    CheatPic.OnEvent("Click", (*) => CloseCheatSheet())
    CheatSheetGui.OnEvent("Close", (*) => CloseCheatSheet())
    CheatSheetGui.OnEvent("Escape", (*) => CloseCheatSheet())

    ; Hook keyboard input: ANY key press immediately closes the cheat sheet
    CheatInputHook := InputHook("L0")
    CheatInputHook.KeyOpt("{All}", "E")
    CheatInputHook.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "E")
    CheatInputHook.KeyOpt("{F9}{Tab}{q}", "-E") ; Exclude F9, Tab, and Q so chord transitions don't prematurely close
    CheatInputHook.OnEnd := (ih) => CloseCheatSheet()
    CheatInputHook.Start()

    ; Display across the work area of the active monitor
    CheatSheetGui.Show("x" . wLeft . " y" . wTop . " w" . monW . " h" . monH)
}

; F9 is the Kanata bridge hotkey for physical Tab + Q in Hyn mode
; Supports dual behavior:
; - Tap (<300ms): Pins the cheat sheet open on screen.
; - Hold (>=300ms): Peeks the cheat sheet; releasing Tab + Q automatically hides it.
*F9:: {
    Global Ishyn, F9Pressed, F9DownTime, F9ClosedByToggle
    if (!Ishyn)
        return

    ; Suppress auto-repeat while holding Tab + Q to avoid error loops
    if (F9Pressed)
        return

    F9Pressed := true
    F9DownTime := A_TickCount
    F9ClosedByToggle := false

    ; If already open, close it (toggle behavior)
    if (CheatSheetActive()) {
        F9ClosedByToggle := true
        CloseCheatSheet()
        return
    }

    ToggleCheatSheet()
}

*F9 Up:: {
    Global Ishyn, F9Pressed, F9DownTime, F9ClosedByToggle
    if (!F9Pressed)
        return

    F9Pressed := false

    ; If this press was used to toggle an already-open cheat sheet closed, do nothing
    if (F9ClosedByToggle) {
        F9ClosedByToggle := false
        return
    }

    ; Calculate hold duration
    holdDuration := A_TickCount - F9DownTime

    ; If held for >= 300ms, user was peeking -> hide on release
    if (holdDuration >= 300) {
        CloseCheatSheet()
    }
    ; Otherwise: user tapped quickly (<300ms) -> keep open (pinned)
}

; ------------------------------------------------------------------------------
; NVDA Screen Reader Toggle (Physical B Key in Hyn Mode)
; ------------------------------------------------------------------------------
ToggleNVDA() {
    Global Ishyn
    if (!Ishyn)
        return

    nvdaDir := "C:\Program Files\NVDA"
    nvdaSlave := nvdaDir . "\nvda_slave.exe"
    nvdaMain := nvdaDir . "\nvda.exe"

    if ProcessExist("nvda.exe") {
        ; NVDA is currently open -> Close it cleanly
        Notify("NVDA: Closing...", 1500)
        try {
            Run('"' . nvdaMain . '" -q', nvdaDir)
        }
        ; Wait up to 2 seconds for process to exit; force close if hung
        if (ProcessWaitClose("nvda.exe", 2) == 0) {
            try ProcessClose("nvda.exe")
        }
        Notify("NVDA: Off", 1500)
        SoundBeep 400, 150
    } else {
        ; NVDA is closed -> Launch without asking for permission (zero UAC prompt)
        Notify("NVDA: Starting...", 1500)
        SoundBeep 850, 150
        
        ; Priority 1: Direct launch with working directory set to NVDA install directory
        try {
            Run('"' . nvdaSlave . '" launchNVDA -r', nvdaDir)
        } catch {
            ; Priority 2: Fallback via PowerShell Start-Process (inherits uiAccess elevation)
            psCmd := 'powershell.exe -WindowStyle Hidden -Command "Start-Process \"' . nvdaSlave . '\" -ArgumentList \"launchNVDA -r\" -WorkingDirectory \"' . nvdaDir . '\""'
            try {
                Run(psCmd,, "Hide")
            } catch as err {
                Notify("NVDA Launch Failed: " . err.Message, 3000)
            }
        }
    }
}

; F7 is the Kanata bridge hotkey for physical B in Hyn mode
*F7:: {
    if (Ishyn) {
        ToggleNVDA()
    }
}

; ------------------------------------------------------------------------------
; Middle Mouse Button Mode Toggle (Ctrl + B in Hyn or Navigation Mode)
; Switches between:
; - "Double": Single click is normal middle click; Double click toggles NVDA
; - "Single": Single click toggles NVDA; Space + Middle click is normal middle click
; ------------------------------------------------------------------------------
ToggleMiddleButtonMode() {
    Global MiddleClickMode, MButtonWaitingForSecond, MiddleClickActive, Ishyn, NavMode
    ; Only operable in Hyn or Navigation mode
    if (!Ishyn && !NavMode)
        return

    ; Cancel any pending timers/states
    SetTimer SendPendingMiddleClick, 0
    MButtonWaitingForSecond := false
    MiddleClickActive := false

    if (MiddleClickMode == "Single") {
        MiddleClickMode := "Double"
        Notify("Middle Click: Normal Click (Double-Click NVDA)", 2000)
        SoundBeep 650, 100
        Sleep 40
        SoundBeep 900, 150
    } else {
        MiddleClickMode := "Single"
        Notify("Middle Click: Single-Click NVDA (Space+Click Normal)", 2000)
        SoundBeep 900, 100
        Sleep 40
        SoundBeep 650, 150
    }
}

; Bridge hotkeys for Ctrl + B (Toggle Middle Button Mode)
^!F10::ToggleMiddleButtonMode()
^F7::ToggleMiddleButtonMode()

#HotIf (Ishyn || NavMode)
^b::ToggleMiddleButtonMode()
#HotIf

; Context-sensitive hotkeys when the Cheat Sheet overlay is active:
; - Mouse wheel zooms in/out anchored at the cursor (up to 6X)
; - Middle mouse button hold & drag pans the zoomed image
; - Left click, right click, or Esc immediately dismisses the overlay
#HotIf CheatSheetActive()
*WheelUp::ZoomCheatSheet(1.25)
*WheelDown::ZoomCheatSheet(0.8)
*LButton::CloseCheatSheet()
*RButton::CloseCheatSheet()
*MButton::PanCheatSheetStart()
*Esc::CloseCheatSheet()
#HotIf

; Helper to send delayed single middle click in Double-Click Mode
SendPendingMiddleClick() {
    Global MButtonWaitingForSecond
    if (MButtonWaitingForSecond) {
        MButtonWaitingForSecond := false
        Click "Middle"
    }
}

; Middle Mouse Button in Hyn or Navigation Mode:
; - In "Single" Mode:
;   - Space held: Simple Middle Click (supports click and hold-to-drag/autoscroll)
;   - Alone: Toggles NVDA Screen Reader
; - In "Double" Mode:
;   - Single click: Standard middle click
;   - Double click: Toggles NVDA Screen Reader
;   - Hold & drag: Standard middle button hold & drag (autoscroll / CAD pan)
; In QWERTY mode: passes through natively to Windows.
#HotIf (Ishyn || NavMode) && !CheatSheetActive()
*MButton:: {
    Global MiddleClickMode, MiddleClickActive, MButtonWaitingForSecond

    ; ---------------------------------------------------------
    ; MODE 1: Single-Click Mode (B-Key Mode)
    ; ---------------------------------------------------------
    if (MiddleClickMode == "Single") {
        if (GetKeyState("Space", "P") || GetKeyState("Space")) {
            MiddleClickActive := true
            Click "Middle Down"
        } else {
            MiddleClickActive := false
            ToggleNVDA()
        }
        return
    }

    ; ---------------------------------------------------------
    ; MODE 2: Double-Click Mode (Standard Mode)
    ; ---------------------------------------------------------
    ; If already waiting for second click -> this IS the double click!
    if (MButtonWaitingForSecond) {
        SetTimer SendPendingMiddleClick, 0
        MButtonWaitingForSecond := false
        ToggleNVDA()
        return
    }

    ; Check if user is holding the button down (> 180ms) for drag / autoscroll
    if !KeyWait("MButton", "T0.18") {
        MiddleClickActive := true
        Click "Middle Down"
        KeyWait "MButton"
        Click "Middle Up"
        MiddleClickActive := false
        return
    }

    ; User released quickly within 180ms -> start timer to check for double-click
    MButtonWaitingForSecond := true
    SetTimer SendPendingMiddleClick, -240
}

*MButton Up:: {
    Global MiddleClickActive
    if (MiddleClickActive) {
        MiddleClickActive := false
        Click "Middle Up"
    }
}
#HotIf

; ==============================================================================
; Key Output Overlay (Small popup near system tray showing final output keys)
; Toggled via Space + X (Kanata sends Ctrl+Alt+F8) or System Tray Menu
; ==============================================================================

PositionOutputKeyGui() {
    Global OutputKeyGui
    if (OutputKeyGui == "")
        return

    ; Detect primary monitor dimensions and work area
    primaryMon := MonitorGetPrimary()
    MonitorGet(primaryMon, &mL, &mT, &mR, &mB)
    MonitorGetWorkArea(primaryMon, &wL, &wT, &wR, &wB)

    ; Get exact rendered window size on screen in physical screen pixels
    WinGetPos(&curX, &curY, &realW, &realH, OutputKeyGui.Hwnd)
    if (realW <= 0 || realH <= 0)
        return

    ; Dynamic DPI scale factor (e.g. 1.75 at 168 DPI)
    dpiScale := A_ScreenDPI / 96.0

    ; Retrieve taskbar height if present, with DPI-scaled fallback (48px standard at 100% DPI)
    tbH := 0
    try {
        if WinExist("ahk_class Shell_TrayWnd")
            WinGetPos(,,, &tbH, "ahk_class Shell_TrayWnd")
    }
    minTbH := Integer(48 * dpiScale)
    if (tbH < minTbH)
        tbH := minTbH

    ; Handle both standard and auto-hide taskbars:
    ; When auto-hide is enabled, wB reaches mB, so we reserve space for the taskbar (mB - tbH)
    taskbarTop := Min(wB, mB - tbH)
    paddingY := Integer(20 * dpiScale)
    paddingX := Integer(20 * dpiScale)

    ; Calculate final physical coordinates
    finalX := Min(wR, mR) - realW - paddingX
    finalY := taskbarTop - realH - paddingY

    ; Keep within screen bounds
    if (finalX < mL + 10)
        finalX := mL + 10
    if (finalY < mT + 10)
        finalY := mT + 10

    ; WinMove operates directly in raw screen pixels without DPI coordinate multiplication
    WinMove(finalX, finalY,,, OutputKeyGui.Hwnd)
}

EnsureOutputKeyGui() {
    Global OutputKeyGui, OutputKeyText, OutputKeyTrail
    if (OutputKeyGui != "")
        return

    ; +AlwaysOnTop: Visible over apps
    ; -Caption: Sleek borderless window
    ; +Border: Crisp high-contrast 1px border
    ; +ToolWindow: Doesn't clutter taskbar / Alt+Tab
    ; +E0x20: WS_EX_TRANSPARENT -> 100% click-through!
    OutputKeyGui := Gui("+AlwaysOnTop -Caption +Border +ToolWindow +E0x20", "Key Output Overlay")
    OutputKeyGui.BackColor := "181825"

    ; Header
    OutputKeyGui.SetFont("s8 bold", "Segoe UI")
    OutputKeyGui.Add("Text", "x15 y10 w230 h18 cA6ADC8 Center", "OUTPUT KEY")

    ; Main Key Display
    OutputKeyGui.SetFont("s16 bold", "Segoe UI")
    OutputKeyText := OutputKeyGui.Add("Text", "x15 y32 w230 h36 c89DCEB Center", "Ready")

    ; Recent Key History Trail
    OutputKeyGui.SetFont("s8", "Segoe UI")
    OutputKeyTrail := OutputKeyGui.Add("Text", "x15 y72 w230 h20 c9399B2 Center", "")

    ; Render window with initial size
    OutputKeyGui.Show("w260 h102 NoActivate")

    ; Pin directly above the system tray and inside the right screen edge
    PositionOutputKeyGui()
}

HideOutputKeyOverlay() {
    Global OutputKeyGui
    if (OutputKeyGui != "") {
        try OutputKeyGui.Hide()
    }
}

FormatOutputKeyName(vk, sc) {
    name := GetKeyName(Format("vk{:02x}sc{:03x}", vk, sc))
    if (name == "")
        name := Format("vk{:02X}", vk)

    ; Make common keys clean and friendly
    switch StrLower(name) {
        case "backspace": return "Backspace"
        case "delete":    return "Delete"
        case "insert":    return "Insert"
        case "return":    return "Enter"
        case "escape":    return "Escape"
        case "space":     return "Space"
        case "tab":       return "Tab"
        case "up":        return "Up"
        case "down":      return "Down"
        case "left":      return "Left"
        case "right":     return "Right"
        case "prior":     return "Page Up"
        case "next":      return "Page Down"
        case "home":      return "Home"
        case "end":       return "End"
        case "printscreen": return "PrtScn"
        default:
            if (StrLen(name) == 1)
                return StrUpper(name)
            return name
    }
}

IsModVk(vk) {
    Global StickyHoldEnabled
    if (vk == 0x2D)
        return (StickyHoldEnabled != 0)
    return (vk == 0x10 || vk == 0x11 || vk == 0x12 || vk == 0x5B || vk == 0x5C || (vk >= 0xA0 && vk <= 0xA5))
}

GetModSendName(vk) {
    switch vk {
        case 0x11, 0xA2: return "LCtrl"
        case 0xA3: return "RCtrl"
        case 0x10, 0xA0: return "LShift"
        case 0xA1: return "RShift"
        case 0x12, 0xA4: return "LAlt"
        case 0xA5: return "RAlt"
        case 0x5B: return "LWin"
        case 0x5C: return "RWin"
        case 0x2D: return "Insert"
        default: return ""
    }
}

GetModFriendlyName(vk) {
    switch vk {
        case 0x11, 0xA2, 0xA3: return "Ctrl"
        case 0x10, 0xA0, 0xA1: return "Shift"
        case 0x12, 0xA4, 0xA5: return "Alt"
        case 0x5B, 0x5C: return "Win"
        case 0x2D: return "Insert"
        default: return ""
    }
}

DisarmStickyModifiers() {
    Global ActiveStickyMods, ActiveChainDisplay, ActiveHeldKeys
    for modSend, _ in ActiveStickyMods {
        try SendInput("{Blind}{" . modSend . " Up}")
    }
    ActiveStickyMods.Clear()
    ActiveChainDisplay := []
    ActiveHeldKeys.Clear()
}

OnOutputKeyDown(ih, vk, sc) {
    Global OutputKeyGui, OutputKeyText, OutputKeyTrail, OutputRecentKeys, ShowKeyOverlay
    Global StickyHoldEnabled, ActiveStickyMods, ActiveHeldKeys, ActiveChainDisplay, LastModifierTapped, LastModifierTapTime

    ; Ignore internal bridge F-keys (F13..F24: vk 0x7C..0x87)
    if (vk >= 0x7C && vk <= 0x87)
        return

    ; Ignore internal hotkey triggers:
    ; ^!F7 (0x76) = Toggle Sticky Modifiers (Ctrl+Space+X)
    ; ^!F8 (0x77) = Toggle Key Output Overlay (Space+X)
    ; ^!F10 (0x79) = Toggle Middle Mode (Ctrl+B)
    if (GetKeyState("Ctrl") && GetKeyState("Alt") && (vk == 0x76 || vk == 0x77 || vk == 0x79))
        return

    ; Escape cancels sticky modifiers and resets active chain
    if (vk == 0x1B) {
        if (ActiveStickyMods.Count > 0)
            DisarmStickyModifiers()
        if (ShowKeyOverlay) {
            EnsureOutputKeyGui()
            OutputKeyText.Text := "Escape"
            try OutputKeyGui.Show("NoActivate")
            PositionOutputKeyGui()
            SetTimer HideOutputKeyOverlay, -1500
        }
        return
    }

    ; If modifier is pressed down
    if IsModVk(vk) {
        if (StickyHoldEnabled) {
            LastModifierTapped := vk
            LastModifierTapTime := A_TickCount
        }
        return
    }

    ; Non-modifier key pressed down
    ActiveHeldKeys[vk] := true

    ; Reset sticky modifier 3-second safety timeout
    if (ActiveStickyMods.Count > 0)
        SetTimer DisarmStickyModifiers, -3000

    ; If Key Output Overlay is enabled, update visual representation
    if (ShowKeyOverlay) {
        baseKey := FormatOutputKeyName(vk, sc)

        ; Build active modifier prefix (combining actual physical keys + active sticky modifiers)
        mods := ""
        if (GetKeyState("Ctrl") || ActiveStickyMods.Has("LCtrl") || ActiveStickyMods.Has("RCtrl"))
            mods .= "Ctrl + "
        if (GetKeyState("Alt") || ActiveStickyMods.Has("LAlt") || ActiveStickyMods.Has("RAlt"))
            mods .= "Alt + "
        if (GetKeyState("Shift") || ActiveStickyMods.Has("LShift") || ActiveStickyMods.Has("RShift"))
            mods .= "Shift + "
        if (GetKeyState("LWin") || GetKeyState("RWin") || ActiveStickyMods.Has("LWin") || ActiveStickyMods.Has("RWin"))
            mods .= "Win + "
        if (GetKeyState("Insert") || ActiveStickyMods.Has("Insert"))
            mods .= "Insert + "

        displayText := mods . baseKey

        ; Append to current chain if multiple keys are chained
        ActiveChainDisplay.Push(baseKey)
        if (ActiveChainDisplay.Length > 1) {
            chainStr := mods
            for idx, k in ActiveChainDisplay {
                if (idx > 1)
                    chainStr .= " + "
                chainStr .= k
            }
            displayText := chainStr
        }

        ; Update history trail (deduplicated)
        if (OutputRecentKeys.Length == 0 || OutputRecentKeys[OutputRecentKeys.Length] != displayText) {
            OutputRecentKeys.Push(displayText)
            if (OutputRecentKeys.Length > 3)
                OutputRecentKeys.RemoveAt(1)
        }

        trailText := ""
        for idx, k in OutputRecentKeys {
            if (idx > 1)
                trailText .= "  ->  "
            trailText .= k
        }

        EnsureOutputKeyGui()
        OutputKeyText.Text := displayText
        OutputKeyTrail.Text := trailText

        try OutputKeyGui.Show("NoActivate")
        PositionOutputKeyGui()
        SetTimer HideOutputKeyOverlay, -2500
    }
}

OnOutputKeyUp(ih, vk, sc) {
    Global OutputKeyGui, OutputKeyText, ShowKeyOverlay
    Global StickyHoldEnabled, ActiveStickyMods, ActiveHeldKeys, ActiveChainDisplay, LastModifierTapped, LastModifierTapTime

    ; Ignore internal bridge F-keys and triggers
    if (vk >= 0x7C && vk <= 0x87)
        return

    ; Check if modifier was tapped and released alone
    if IsModVk(vk) {
        if (StickyHoldEnabled && LastModifierTapped == vk) {
            elapsed := A_TickCount - LastModifierTapTime
            ; Only arm if tapped quickly (< 450ms) and no character keys were held during the tap
            if (elapsed < 450 && ActiveHeldKeys.Count == 0) {
                modSend := GetModSendName(vk)
                friendlyName := GetModFriendlyName(vk)
                if (modSend != "") {
                    if ActiveStickyMods.Has(modSend) {
                        ; Tapping an already-active sticky modifier cancels it
                        try SendInput("{Blind}{" . modSend . " Up}")
                        ActiveStickyMods.Delete(modSend)
                        SoundBeep 700, 60
                        if (ShowKeyOverlay) {
                            EnsureOutputKeyGui()
                            OutputKeyText.Text := "[" . friendlyName . " Cancelled]"
                            try OutputKeyGui.Show("NoActivate")
                            PositionOutputKeyGui()
                            SetTimer HideOutputKeyOverlay, -1500
                        }
                    } else {
                        ; Arm the sticky modifier
                        ActiveStickyMods[modSend] := true
                        try SendInput("{Blind}{" . modSend . " Down}")
                        SetTimer DisarmStickyModifiers, -3000
                        SoundBeep 1200, 50
                        if (ShowKeyOverlay) {
                            EnsureOutputKeyGui()
                            OutputKeyText.Text := "[" . friendlyName . " Sticky]"
                            try OutputKeyGui.Show("NoActivate")
                            PositionOutputKeyGui()
                            SetTimer HideOutputKeyOverlay, -2500
                        }
                    }
                }
            }
            LastModifierTapped := 0
        }
        return
    }

    ; Non-modifier key was released
    if ActiveHeldKeys.Has(vk)
        ActiveHeldKeys.Delete(vk)

    ; Check if the entire chain is now completed/broken:
    ; The chain stays alive as long as ANY key is still held down OR Space is still held physically for mirroring
    isSpaceHeld := GetKeyState("Space", "P")
    if (ActiveHeldKeys.Count == 0 && !isSpaceHeld) {
        ; All keys in chain released! Auto-release sticky modifiers
        if (ActiveStickyMods.Count > 0) {
            DisarmStickyModifiers()
        }
        ActiveChainDisplay := []
    }
}

EnsureHookRunning() {
    Global OutputKeyHook, ShowKeyOverlay, StickyHoldEnabled
    shouldRun := (ShowKeyOverlay || StickyHoldEnabled)
    if (shouldRun) {
        if (OutputKeyHook == "")
            StartOutputKeyHook()
    } else {
        if (OutputKeyHook != "")
            StopOutputKeyHook()
    }
}

StartOutputKeyHook() {
    Global OutputKeyHook
    if (OutputKeyHook != "") {
        try OutputKeyHook.Stop()
    }
    OutputKeyHook := InputHook("V")
    OutputKeyHook.KeyOpt("{All}", "N")
    OutputKeyHook.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "N")
    OutputKeyHook.OnKeyDown := OnOutputKeyDown
    OutputKeyHook.OnKeyUp := OnOutputKeyUp
    OutputKeyHook.Start()
}

StopOutputKeyHook() {
    Global OutputKeyHook
    if (OutputKeyHook != "") {
        try OutputKeyHook.Stop()
        OutputKeyHook := ""
    }
    HideOutputKeyOverlay()
}

UpdateKeyOverlayMenu() {
    Global ShowKeyOverlay
    try {
        if (ShowKeyOverlay) {
            A_TrayMenu.Check("Show Output Keys (Space + X)")
        } else {
            A_TrayMenu.Uncheck("Show Output Keys (Space + X)")
        }
    }
}

ToggleKeyOverlay(*) {
    Global ShowKeyOverlay, SettingsFile, OutputKeyText, OutputKeyTrail, OutputKeyGui, OutputRecentKeys
    ShowKeyOverlay := !ShowKeyOverlay
    try IniWrite(String(ShowKeyOverlay), SettingsFile, "Settings", "ShowOutputKeys")

    UpdateKeyOverlayMenu()
    EnsureHookRunning()

    if (ShowKeyOverlay) {
        EnsureOutputKeyGui()
        Notify("Key Output Overlay: ON (Near Tray)", 1500)
        SoundBeep 850, 100
        Sleep 30
        SoundBeep 1150, 150
        OutputRecentKeys := []
        OutputKeyText.Text := "Ready"
        OutputKeyTrail.Text := ""
        try OutputKeyGui.Show("NoActivate")
        PositionOutputKeyGui()
        SetTimer HideOutputKeyOverlay, -2500
    } else {
        Notify("Key Output Overlay: OFF", 1500)
        SoundBeep 1150, 100
        Sleep 30
        SoundBeep 700, 150
    }
}

UpdateStickyModifiersMenu() {
    Global StickyHoldEnabled
    try {
        if (StickyHoldEnabled) {
            A_TrayMenu.Check("Sticky Modifiers (Ctrl + Space + X)")
        } else {
            A_TrayMenu.Uncheck("Sticky Modifiers (Ctrl + Space + X)")
        }
    }
}

ToggleStickyModifiers(*) {
    Global StickyHoldEnabled, SettingsFile
    StickyHoldEnabled := !StickyHoldEnabled
    try IniWrite(String(StickyHoldEnabled), SettingsFile, "Settings", "StickyHoldEnabled")

    UpdateStickyModifiersMenu()
    EnsureHookRunning()

    if (StickyHoldEnabled) {
        Notify("Sticky Modifiers: ON (Ctrl + Space + X)", 1500)
        SoundBeep 850, 80
        Sleep 30
        SoundBeep 1200, 120
    } else {
        DisarmStickyModifiers()
        Notify("Sticky Modifiers: OFF", 1500)
        SoundBeep 1200, 80
        Sleep 30
        SoundBeep 700, 120
    }
}

; Bridge Hotkey: Space + X (Kanata sends Ctrl+Alt+F8)
^!f8::ToggleKeyOverlay()

; Bridge Hotkey: Ctrl + Space + X (Kanata sends Ctrl+Alt+F7)
^!f7::ToggleStickyModifiers()




