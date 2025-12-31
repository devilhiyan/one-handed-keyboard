#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetMouseDelay -1 

; ==============================================================================
; Kanata Mouse Bridge (Fixed)
; Maps F13-F20 and Arrow Keys to Mouse/Keyboard Actions based on Mode
; ==============================================================================

; Configuration
MinSpeed := 1
MaxSpeed := 35
AccelFactor := 0.02
ScrollSpeed := 1
CurrentSpeed := MinSpeed

; Navigation Settings
Global MouseMode := 0 ; 0 = Keyboard Nav (Arrows), 1 = Mouse Nav (Movement)

; Navigation State
Global NavMode := false
Global MoveState := {up: 0, down: 0, left: 0, right: 0}

; ------------------------------------------------------------------------------
; Notification Helper
; ------------------------------------------------------------------------------
Notify(Text, Duration:=1000) {
    ToolTip Text
    SetTimer () => ToolTip(), -Duration
}

; ------------------------------------------------------------------------------
; Navigation Mode Toggle (F24 - Sent by Kanata on Ctrl Tap)
; ------------------------------------------------------------------------------
*F24:: {
    global NavMode := !NavMode
    if (NavMode) {
        Notify("Navigation Mode: ON (" . (MouseMode ? "Mouse Nav" : "Keyboard Nav") . ")")
        SoundBeep 1000, 150
    } else {
        Notify("Navigation Mode: OFF")
        SoundBeep 500, 150
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
    global CurrentSpeed, MoveState
    
    ; Check held state from our tracking object
    up    := MoveState.up
    left  := MoveState.left
    down  := MoveState.down
    right := MoveState.right

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
        MouseMove(moveX * CurrentSpeed, moveY * CurrentSpeed, 0, "R")
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
    MoveState.up := 1
    StartMove()
}
*Up Up::MoveState.up := 0

*Left:: {
    MoveState.left := 1
    StartMove()
}
*Left Up::MoveState.left := 0

*Down:: {
    MoveState.down := 1
    StartMove()
}
*Down Up::MoveState.down := 0

*Right:: {
    MoveState.right := 1
    StartMove()
}
*Right Up::MoveState.right := 0

; Wheels / Chords
*F19:: {
    While GetKeyState("F19", "P") {
        SendInput "{Blind}{Home}"
        Sleep(50)
    }
}
*F20:: {
    While GetKeyState("F20", "P") {
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
    MoveState.up := 1
    StartMove()
}
*F13 Up::MoveState.up := 0

*F14:: {
    MoveState.left := 1
    StartMove()
}
*F14 Up::MoveState.left := 0

*F15:: {
    MoveState.down := 1
    StartMove()
}
*F15 Up::MoveState.down := 0

*F16:: {
    MoveState.right := 1
    StartMove()
}
*F16 Up::MoveState.right := 0

*Up::SendInput "{Blind}{Up}"
*Left::SendInput "{Blind}{Left}"
*Down::SendInput "{Blind}{Down}"
*Right::SendInput "{Blind}{Right}"

; Wheels / Chords
*F19:: {
    While GetKeyState("F19", "P") {
        Click "WheelUp"
        Sleep(50)
    }
}
*F20:: {
    While GetKeyState("F20", "P") {
        Click "WheelDown"
        Sleep(50)
    }
}
*F21::SendInput "{Blind}{Home}"
*F22::SendInput "{Blind}{End}"

*Home::SendInput "{Blind}{Home}"
*End::SendInput "{Blind}{End}"
#HotIf