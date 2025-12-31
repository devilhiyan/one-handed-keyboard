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
; Shared Navigation Keys (Capslock, Tab, Shift)
; ------------------------------------------------------------------------------
#HotIf NavMode

; Backspace on Space + Tab (Kanata sends bspc if mapped, but bridge can handle it)
; Actually Kanata maps q to bspc in spc-mod. Let's stick to what Kanata sends or map specific F keys.

; Capslock / Shift logic based on MouseMode
$*Capslock:: {
    SetCapsLockState "Off"
    if (MouseMode) { ; Mouse Mode -> Click
        Click "Down"
        KeyWait "Capslock"
        Click "Up"
    } else { ; Keyboard Mode -> Enter
        SendInput("{Enter}")
    }
}

Space & Capslock:: {
    if (MouseMode) {
        SendInput("{Enter}")
    } else {
        Click "Down"
        KeyWait "Capslock"
        Click "Up"
    }
}

; Right Click logic
$*LShift::
$*RShift:: {
    if (MouseMode) {
        Click "Right"
    } else {
        SendInput "{Blind}{LShift Down}"
        KeyWait A_ThisHotkey
        SendInput "{Blind}{LShift Up}"
    }
}

#HotIf NavMode && !MouseMode
Space & LShift::
Space & RShift::Click "Right"
#HotIf

; ------------------------------------------------------------------------------
; Movement Timer Logic
; ------------------------------------------------------------------------------
ProcessMovement() {
    global CurrentSpeed, MoveUpVar, MoveDownVar, MoveLeftVar, MoveRightVar
    
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
    if (left)  moveX -= 1
    if (right) moveX += 1
    if (up)    moveY -= 1
    if (down)  moveY += 1

    if (moveX != 0 || moveY != 0) {
        DllCall("mouse_event", "UInt", 0x0001, "Int", moveX * CurrentSpeed, "Int", moveY * CurrentSpeed, "UInt", 0, "UPtr", 0)
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

; Wheels / Chords
*F19:: {
    While GetKeyState("F19") {
        SendInput "{Blind}{Home}"
        Sleep(50)
    }
}
*F20:: {
    While GetKeyState("F20") {
        SendInput "{Blind}{End}"
        Sleep(50)
    }
}
*F21::SendInput "{Blind}{Home}"
*F22::SendInput "{Blind}{End}"

*Home::Click "WheelUp"
*End::Click "WheelDown"
#HotIf

; Mouse Navigation Mode (MouseMode = 1)
; WASD (F13-F16) -> Mouse
; Space+WASD (Arrows) -> Arrows
#HotIf NavMode && MouseMode
*F13:: {
    Global MoveUpVar := 1
    StartMove()
}
*F13 Up:: {
    Global MoveUpVar := 0
}

*F14:: {
    Global MoveLeftVar := 1
    StartMove()
}
*F14 Up:: {
    Global MoveLeftVar := 0
}

*F15:: {
    Global MoveDownVar := 1
    StartMove()
}
*F15 Up:: {
    Global MoveDownVar := 0
}

*F16:: {
    Global MoveRightVar := 1
    StartMove()
}
*F16 Up:: {
    Global MoveRightVar := 0
}

*Up::SendInput "{Blind}{Up}"
*Left::SendInput "{Blind}{Left}"
*Down::SendInput "{Blind}{Down}"
*Right::SendInput "{Blind}{Right}"

; Wheels / Chords
*F19:: {
    While GetKeyState("F19") {
        Click "WheelUp"
        Sleep(50)
    }
}
*F20:: {
    While GetKeyState("F20") {
        Click "WheelDown"
        Sleep(50)
    }
}
*F21::SendInput "{Blind}{Home}"
*F22::SendInput "{Blind}{End}"

*Home::SendInput "{Blind}{Home}"
*End::SendInput "{Blind}{End}"
#HotIf