# Kanata-AHK Bridge Architecture

## 1. Overview

This project employs a hybrid input management architecture to combine the strengths of low-level driver interception with high-level scripting logic.

*   **Kanata (The Hardware Abstraction Layer):** 
    *   Uses the [Interception](https://github.com/oblitum/Interception) driver to hook into the keyboard input stream at a low level.
    *   Responsible for robust key remapping, layer management (Halmak/Mirror), and chording logic.
    *   Acts as the "Router", deciding whether a keypress is a character, a modifier, or a command signal.

*   **AutoHotkey (The Logic Layer):**
    *   Runs as a user-level script (`kanata_mouse_bridge.ahk`).
    *   Responsible for complex behaviors that are difficult or impossible to implement in Kanata's static configuration, specifically **Mouse Acceleration** and **GUI Feedback**.
    *   Listens for "Virtual Signals" (F-Keys) sent by Kanata.

## 2. The Bridge Protocol (Virtual Wires)

Communication is one-way: **Kanata -> AutoHotkey**. This is achieved by mapping specific logical actions in Kanata to virtual function keys that the AHK script hooks.

| Physical Action | Kanata Layer | Output (Virtual Key) | AHK Action | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Mouse Move Up** | `mouse` | `F13` | `StartMove()` | Starts the acceleration timer. |
| **Mouse Move Left** | `mouse` | `F14` | `StartMove()` | Starts the acceleration timer. |
| **Mouse Move Down** | `mouse` | `F15` | `StartMove()` | Starts the acceleration timer. |
| **Mouse Move Right** | `mouse` | `F16` | `StartMove()` | Starts the acceleration timer. |
| **Left Click** | `mouse` | `F17` | `Click "Down"` | Passthrough click. |
| **Right Click** | `mouse` | `F18` | `Click "Down Right"` | Passthrough right click. |
| **Scroll Up** | `mouse` | `F19` | `Click "WheelUp"` | Continuous scroll loop. |
| **Scroll Down** | `mouse` | `F20` | `Click "WheelDown"` | Continuous scroll loop. |
| **Nav Toggle** | `halmak` | `F24` | `NavMode := !NavMode` | Toggles on-screen notification state. |

## 3. Mouse Logic Implementation

### Why not use Kanata's built-in mouse keys?
Kanata supports basic mouse movement, but it typically relies on static speeds or simple stepping. To achieve a "buttery smooth" cursor feel that rivals a physical mouse, we need **Ease-Out Acceleration**.

### The AHK Acceleration Algorithm
The `ProcessMovement` function in `kanata_mouse_bridge.ahk` runs on a 10ms timer:

1.  **Poll State:** Checks `GetKeyState` for F13-F16.
2.  **Calculate Vector:** Determines the raw X/Y direction (-1, 0, 1).
3.  **Apply Acceleration:** 
    ```autohotkey
    CurrentSpeed += (MaxSpeed - CurrentSpeed) * AccelFactor
    ```
    This creates a smooth ramp-up to `MaxSpeed`.
4.  **Reset:** When keys are released, `CurrentSpeed` resets to `MinSpeed`.

## 4. Lifecycle Management

The system is orchestrated by `kanata/start_kanata.ps1`. This script ensures that both components run together and terminate together.

1.  **Start AHK:** Launches `kanata_mouse_bridge.ahk` in a hidden window.
2.  **Start Kanata:** Launches `kanata.exe` in blocking mode (waiting for exit).
3.  **Cleanup:** Wrapped in a `finally` block, the script searches for the AHK process and terminates it when Kanata closes.

**Usage:**
Always use `start_kanata.ps1` (or the `launch_kanata.bat` wrapper) to start the system. Running components individually will break the mouse functionality.
