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
    global CurrentSpeed, MouseMode
    
    ; Determine which keys to check based on Mode
    if (MouseMode == 1) { ; Mouse Navigation Mode: WASD (F13-F16) moves mouse
        up    := GetKeyState("F13")
        left  := GetKeyState("F14")
        down  := GetKeyState("F15")
        right := GetKeyState("F16")
    } else { ; Keyboard Navigation Mode: Space+WASD (Arrows) moves mouse
        up    := GetKeyState("Up")
        left  := GetKeyState("Left")
        down  := GetKeyState("Down")
        right := GetKeyState("Right")
    }

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

*Up::StartMove()
*Left::StartMove()
*Down::StartMove()
*Right::StartMove()

; Wheels / Chords
*F19:: {
    if (MouseMode == 1) { ; Mouse Mode -> Wheel Up
        While GetKeyState("F19") {
            Click "WheelUp"
            Sleep(50)
        }
    } else { ; Keyboard Mode -> Home
        SendInput "{Blind}{Home}"
    }
}

*F20:: {
    if (MouseMode == 1) { ; Mouse Mode -> Wheel Down
        While GetKeyState("F20") {
            Click "WheelDown"
            Sleep(50)
        }
    } else { ; Keyboard Mode -> End
        SendInput "{Blind}{End}"
    }
}

*F21::SendInput "{Blind}{Home}"
*F22::SendInput "{Blind}{End}"

*Home:: {
    if (MouseMode == 0) { ; Keyboard Mode -> Wheel Up
        While GetKeyState("Home") {
            Click "WheelUp"
            Sleep(50)
        }
    } else { ; Mouse Mode -> Home
        SendInput "{Blind}{Home}"
    }
}

*End:: {
    if (MouseMode == 0) { ; Keyboard Mode -> Wheel Down
        While GetKeyState("End") {
            Click "WheelDown"
            Sleep(50)
        }
    } else { ; Mouse Mode -> End
        SendInput "{Blind}{End}"
    }
}