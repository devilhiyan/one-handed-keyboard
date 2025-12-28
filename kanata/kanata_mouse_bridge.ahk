#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 2
SetMouseDelay -1 

; ==============================================================================
; Kanata Mouse Bridge
; Maps F13-F20 to Mouse Actions
; ==============================================================================

; Configuration
MouseSpeed := 15
ScrollSpeed := 1

; ------------------------------------------------------------------------------
; Movement (F13-F16)
; ------------------------------------------------------------------------------

; Up (F13)
*F13:: {
    While GetKeyState("F13", "P") {
        MouseMove(0, -MouseSpeed, 0, "R")
        Sleep(10)
    }
}

; Left (F14)
*F14:: {
    While GetKeyState("F14", "P") {
        MouseMove(-MouseSpeed, 0, 0, "R")
        Sleep(10)
    }
}

; Down (F15)
*F15:: {
    While GetKeyState("F15", "P") {
        MouseMove(0, MouseSpeed, 0, "R")
        Sleep(10)
    }
}

; Right (F16)
*F16:: {
    While GetKeyState("F16", "P") {
        MouseMove(MouseSpeed, 0, 0, "R")
        Sleep(10)
    }
}

; ------------------------------------------------------------------------------
; Clicks (F17-F18)
; ------------------------------------------------------------------------------

; Left Click (F17)
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
