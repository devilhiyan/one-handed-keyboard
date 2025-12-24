# Mirror Keys

## Project Overview

**Mirror Keys** is an AutoHotkey v2 script designed to facilitate one-handed typing. It functions by mirroring the keyboard layout when the **Spacebar** is held down. This allows a user to access keys on the opposite side of the keyboard without moving their hand. For example, holding Space and pressing `F` (left hand home row) will output `J` (right hand home row).

This project includes both the raw source script (`.ahk2`) and a pre-compiled executable (`.exe`).

## Files

*   **`Mirror Keys.ahk2`**: The main source code written in AutoHotkey v2. It contains the logic for key remapping, the GUI for the layout map, and settings management.
*   **`Mirrored keyboard one hand.exe`**: A compiled version of the script that can be run without installing AutoHotkey.

## Usage Guide

### The "Mirror" Concept
The core mechanic relies on the **Spacebar**:
*   **Tap Space**: Types a normal space.
*   **Hold Space + Key**: Types the "mirrored" equivalent of that key.

### Key Mappings (Examples)
The mirroring generally follows the physical location of keys relative to the center of the keyboard.

**Middle Row (Home Row):**
*   `Space` + `A` -> `;`
*   `Space` + `S` -> `L`
*   `Space` + `D` -> `K`
*   `Space` + `F` -> `J`
*   `Space` + `G` -> `H`

**Other Mappings:**
*   **Capslock**: Replaced with `Enter`.
*   **Space + Capslock**: Types `'` (Single Quote).
*   **Space + Tab**: Types `Backspace`.

*Note: The script supports standard modifiers (Shift, Ctrl, Alt, Win) in combination with mirrored keys.*

## Features
*   **Visual Map**: A built-in GUI displays the keyboard map reference. It can be toggled via the system tray icon.
*   **Settings Persistence**: Window position and preferences are saved automatically (utilizing Alternate Data Streams or a local `.ini` file fallback).
*   **System Tray**: Right-click the tray icon to access:
    *   Reopen mirror map
    *   View project on GitHub
    *   Startup instructions
    *   Pause/Reload/Quit

## Development & Running

### Prerequisites
*   **AutoHotkey v2**: Required to run or edit the `.ahk2` file.

### Running the Project
1.  **From Source**: Double-click `Mirror Keys.ahk2` (requires AHK v2 installed).
2.  **Standalone**: Run `Mirrored keyboard one hand.exe`.

### Source Info
*   **Directives**: `#Requires Autohotkey v2.0+`, `#SingleInstance Force`, `#UseHook`.
*   **External Links**: The script references `https://github.com/Cordarian/Mirror-Keys`.
