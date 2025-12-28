#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetMouseDelay -1 

; ==============================================================================
; Kanata Mouse Bridge
; Maps F13-F20 to Mouse Actions + Acceleration + Notification
; ==============================================================================

; Configuration
MinSpeed := 1
MaxSpeed := 25
AccelFactor := 1.15 ; Multiply speed by this factor per loop
ScrollSpeed := 1

; Navigation State (Tracked via F24 toggle)
NavMode := false

; ------------------------------------------------------------------------------
; Notification / State Toggle (F24)
; ------------------------------------------------------------------------------
*F24:: {
    global NavMode := !NavMode
    if (NavMode) {
        SoundBeep 1000, 150
        ToolTip "Navigation Mode: ON"
        SetTimer () => ToolTip(), -1000 ; Hide after 1s
    } else {
        SoundBeep 500, 150
        ToolTip "Navigation Mode: OFF"
        SetTimer () => ToolTip(), -1000
    }
}

; ------------------------------------------------------------------------------
; Movement Logic with Acceleration
; ------------------------------------------------------------------------------
MoveMouseAccel(xMult, yMult) {
    CurrentSpeed := MinSpeed
    While (
        GetKeyState("F13", "P") || 
        GetKeyState("F14", "P") || 
        GetKeyState("F15", "P") || 
        GetKeyState("F16", "P")
    ) {
        ; Calculate movement based on held keys
        moveX := 0
        moveY := 0
        
        if GetKeyState("F14", "P") ; Left
            moveX -= 1
        if GetKeyState("F16", "P") ; Right
            moveX += 1
        if GetKeyState("F13", "P") ; Up
            moveY -= 1
        if GetKeyState("F15", "P") ; Down
            moveY += 1

        ; Apply speed
        MouseMove(moveX * CurrentSpeed, moveY * CurrentSpeed, 0, "R")
        
        ; Accelerate
        if (CurrentSpeed < MaxSpeed) {
            CurrentSpeed *= AccelFactor
            if (CurrentSpeed > MaxSpeed)
                CurrentSpeed := MaxSpeed
        }
        
        Sleep(10)
    }
}

; ------------------------------------------------------------------------------
; Movement Triggers (F13-F16)
; ------------------------------------------------------------------------------

; We use a shared handler because multiple keys can be held (diagonal).
; Any directional key triggers the movement loop if it's not already running.

*F13::MoveMouseAccel(0, -1) ; Up
*F14::MoveMouseAccel(-1, 0) ; Left
*F15::MoveMouseAccel(0, 1)  ; Down
*F16::MoveMouseAccel(1, 0)  ; Right

; ------------------------------------------------------------------------------
; Clicks (F17-F18)
; ------------------------------------------------------------------------------

; Left Click (F17) - Supports Hold/Drag
*F17::Click "Down"
*F17 Up::Click "Up"

; Right Click (F18)
*F18::Click "Down Right"
*F18 Up::Click "Up Right"

; ------------------------------------------------------------------------------
; Scroll (F19-F20)
; ------------------------------------------------------------------------------

; Scroll Up (F19)
*F19:: {
    While GetKeyState("F19", "P") {
        Click "WheelUp"
        Sleep(50)
    }
}

; Scroll Down (F20)
*F20:: {
    While GetKeyState("F20", "P") {
        Click "WheelDown"
        Sleep(50)
    }
}