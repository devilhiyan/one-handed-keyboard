#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetMouseDelay -1 

; ==============================================================================
; Kanata Mouse Bridge
; Maps F13-F20 to Mouse Actions + Acceleration + Notification
; Uses Timers to avoid Key Repeat Stutter/Delay
; ==============================================================================

; Configuration
MinSpeed := 1
MaxSpeed := 35
AccelFactor := 0.02 ; This is now the "Ease Factor"
ScrollSpeed := 1
CurrentSpeed := MinSpeed

; Navigation Settings
Global NavStyle := "Old" ; Default to Old (WASD)
Global MouseMode := 0 ; 0 = Keyboard Nav, 1 = Mouse Nav
Global NavToggleKey := "Ctrl"

; Navigation State
Global NavMode := false

; ------------------------------------------------------------------------------
; Notification / State Toggle
; ------------------------------------------------------------------------------
Notify(Text, Duration:=1000) {
    ToolTip Text
    SetTimer () => ToolTip(), -Duration
}

; Suppress Start Menu on simple press, allowing it only if held
#HotIf NavToggleKey == "LWin"
$LWin:: {
    StartTime := A_TickCount
    SpaceTriggered := False
    
    While GetKeyState("LWin", "P") {
        if (NavMode && GetKeyState("Space", "P")) { ; Only check for Space combo if NavMode is active
            if !SpaceTriggered {
                Global MouseMode := !MouseMode
                if (MouseMode) {
                    Notify("Mouse Navigation Mode")
                } else {
                    Notify("Keyboard Navigation Mode")
                }
                SpaceTriggered := True
            }
        }
        
        if (A_TickCount - StartTime > 500) { ; Held for more than 0.50s
            SendInput "{LWin Down}"
            KeyWait "LWin"
            SendInput "{LWin Up}"
            return
        }
        Sleep 10
    }
    
    ; Key Released
    if (SpaceTriggered) {
        return ; Handled by Space combo
    }
    
    if (A_TickCount - StartTime <= 500) { ; Released within 0.50s (Tap)
        if (A_PriorKey = "LWin") { ; Only if no other key was pressed
            Global NavMode := !NavMode
            if (NavMode) {
                Notify("Navigation Mode: ON (" . (MouseMode ? "Mouse Nav" : "Keyboard Nav") . ")")
                SoundBeep 1000, 150
            } else {
                Notify("Navigation Mode: OFF")
                SoundBeep 500, 150
            }
        }
    }
}
#HotIf

#HotIf NavToggleKey == "Ctrl"
~Ctrl Up:: {
	Critical ; Prevents this thread from being interrupted
	if (A_PriorKey = "LControl" || A_PriorKey = "RControl") {
		Global NavMode := !NavMode
		if (NavMode) {
			Notify("Navigation Mode: ON (" . (MouseMode ? "Mouse Nav" : "Keyboard Nav") . ")")
			SoundBeep 1000, 150
		} else {
			Notify("Navigation Mode: OFF")
			SoundBeep 500, 150
		}
	}
}
#HotIf

#HotIf NavMode && NavToggleKey == "Ctrl"
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
; Shared Navigation Keys (Shift, Capslock, Tab)
; ------------------------------------------------------------------------------

#HotIf NavMode

; Shared Backspace
Space & Tab::SendInput("{Blind}{Backspace}")

#HotIf NavMode && !MouseMode ; Keyboard Navigation Mode

; Capslock (Enter)
$*Capslock:: {
    SetCapsLockState "Off"
    SendInput("{Enter}")
}
; Space + Capslock (Left Click / Drag)
Space & Capslock:: {
    Click "Down"
    KeyWait "Capslock"
    Click "Up"
}

; Space + Shift (Right Click)
Space & LShift::Click "Right"
Space & RShift::Click "Right"

#HotIf NavMode && MouseMode ; Mouse Navigation Mode

; Capslock (Left Click / Drag)
$*Capslock:: {
    SetCapsLockState "Off"
    Click "Down"
    KeyWait "Capslock"
    Click "Up"
}
; Space + Capslock (Enter)
Space & Capslock::SendInput("{Enter}")

; Shift (Right Click)
$*LShift::Click "Right"
$*RShift::Click "Right"

#HotIf

; ------------------------------------------------------------------------------
; Movement Timer Logic
; ------------------------------------------------------------------------------
ProcessMovement() {
    global CurrentSpeed
    
    ; Check which keys are physically held
    ; Allow both WASD and ESDF based on style (implementing WASD for now as requested)
    up    := GetKeyState("w", "P")
    left  := GetKeyState("a", "P")
    down  := GetKeyState("s", "P")
    right := GetKeyState("d", "P")

    ; If no keys are held, stop timer and reset speed
    if (!up && !left && !down && !right) {
        SetTimer ProcessMovement, 0 ; Turn off
        CurrentSpeed := MinSpeed
        return
    }

    ; Calculate Movement
    moveX := 0
    moveY := 0
    
    if (left)  
        moveX -= 1
    if (right) 
        moveX += 1
    if (up)    
        moveY -= 1
    if (down)  
        moveY += 1

    ; Apply Movement
    if (moveX != 0 || moveY != 0) {
        MouseMove(moveX * CurrentSpeed, moveY * CurrentSpeed, 0, "R")
        
        ; Accelerate (Ease-out)
        CurrentSpeed += (MaxSpeed - CurrentSpeed) * AccelFactor
    }
}

; Start Timer on Key Down
StartMove() {
    SetTimer ProcessMovement, 10 ; Run every 10ms
}

; ------------------------------------------------------------------------------
; Navigation Mode Key Mappings
; ------------------------------------------------------------------------------

#HotIf NavMode && !MouseMode ; Keyboard Navigation Mode (WASD = Arrows)

; Direct Keys -> Arrows
$*w::SendInput "{Blind}{Up}"
$*a::SendInput "{Blind}{Left}"
$*s::SendInput "{Blind}{Down}"
$*d::SendInput "{Blind}{Right}"

; Chords
q & w::SendInput "{Blind}{Home}"
~w & e::SendInput "{Blind}{End}"

; Space + Keys -> Mouse
Space & w::StartMove()
Space & a::StartMove()
Space & s::StartMove()
Space & d::StartMove()

; Wheel
Space & q::Click "WheelUp"
Space & e::Click "WheelDown"

#HotIf

#HotIf NavMode && MouseMode ; Mouse Navigation Mode (WASD = Mouse)

; Direct Keys -> Mouse
*w::StartMove()
*a::StartMove()
*s::StartMove()
*d::StartMove()

; Wheel
*q::Click "WheelUp"
*e::Click "WheelDown"

; Space + Keys -> Arrows
Space & w::SendInput "{Blind}{Up}"
Space & a::SendInput "{Blind}{Left}"
Space & s::SendInput "{Blind}{Down}"
Space & d::SendInput "{Blind}{Right}"
Space & q::SendInput "{Blind}{Home}"
Space & e::SendInput "{Blind}{End}"

#HotIf

; ------------------------------------------------------------------------------
; Clicks (F17-F18)
; ------------------------------------------------------------------------------
*F17::Click "Down"
*F17 Up::Click "Up"

*F18::Click "Down Right"
*F18 Up::Click "Up Right"

; ------------------------------------------------------------------------------
; Scroll (F19-F20)
; ------------------------------------------------------------------------------
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
