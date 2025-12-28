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
MaxSpeed := 25
AccelFactor := 1.07 
ScrollSpeed := 1
CurrentSpeed := MinSpeed

; Navigation State
NavMode := false

; ------------------------------------------------------------------------------
; Notification / State Toggle (F24)
; ------------------------------------------------------------------------------
*F24:: {
    global NavMode := !NavMode
    if (NavMode) {
        SoundBeep 1000, 150
        ToolTip "Navigation Mode: ON"
        SetTimer () => ToolTip(), -1000 
    } else {
        SoundBeep 500, 150
        ToolTip "Navigation Mode: OFF"
        SetTimer () => ToolTip(), -1000
    }
}

; ------------------------------------------------------------------------------
; Movement Timer Logic
; ------------------------------------------------------------------------------
ProcessMovement() {
    global CurrentSpeed
    
    ; Check which keys are physically held
    up    := GetKeyState("F13", "P")
    left  := GetKeyState("F14", "P")
    down  := GetKeyState("F15", "P")
    right := GetKeyState("F16", "P")

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
        
        ; Accelerate
        if (CurrentSpeed < MaxSpeed) {
            CurrentSpeed *= AccelFactor
            if (CurrentSpeed > MaxSpeed)
                CurrentSpeed := MaxSpeed
        }
    }
}

; Start Timer on Key Down
StartMove() {
    SetTimer ProcessMovement, 10 ; Run every 10ms
}

; ------------------------------------------------------------------------------
; Movement Triggers (F13-F16)
; ------------------------------------------------------------------------------
; keydown starts the timer immediately. 
; The timer handles the looping, so key repeat is ignored.

*F13::StartMove() ; Up
*F14::StartMove() ; Left
*F15::StartMove() ; Down
*F16::StartMove() ; Right

; Note: We don't strictly need *Up handlers to stop it because the Timer 
; checks GetKeyState itself and stops when all are released.

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
