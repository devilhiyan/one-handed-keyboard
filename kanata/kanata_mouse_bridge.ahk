#Requires AutoHotkey v2.0
#SingleInstance Force
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

