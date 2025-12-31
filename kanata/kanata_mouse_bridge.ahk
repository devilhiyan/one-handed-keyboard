#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetMouseDelay -1 

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
Global MoveUpVar := 0, MoveDownVar := 0, MoveLeftVar := 0, MoveRightVar := 0

; ------------------------------------------------------------------------------
; Notification Helper
; ------------------------------------------------------------------------------
Notify(Text, Duration:=2000) {
    ToolTip Text
    SetTimer () => ToolTip(), -Duration
}

; ------------------------------------------------------------------------------
; Navigation Mode Control (F24 = ON, F23 = OFF)
; ------------------------------------------------------------------------------
*F24:: {
    global NavMode := true
    Notify("Navigation Mode: ON (" . (MouseMode ? "Mouse Nav" : "Keyboard Nav") . ")")
    SoundBeep 1000, 150
}

*F23:: {
    global NavMode := false
    Notify("Navigation Mode: OFF")
    SoundBeep 500, 150
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

; F17 = Left Click (Capslock in Kanata)
*F17:: {
    Click "Down"
}
*F17 Up:: {
    Click "Up"
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