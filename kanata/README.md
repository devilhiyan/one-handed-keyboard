# Kanata Mirror Keys

This directory contains the [Kanata](https://github.com/jtroo/kanata) configuration to replicate the "Mirror Keys" one-handed keyboard functionality.

## Features
- **Mirror Mode:** Hold **Spacebar** to access the mirrored half of the keyboard. The layout is optimized for Halmak.
- **Advanced Chords:** Extensive multi-key chords for navigation, editing, system volume, and brightness.
- **Dual Navigation Mode:** Toggle via **Left Ctrl** to enter a powerful navigation layer.
    - **Keyboard Navigation (Transient):** Fast arrow keys, Home/End, and Enter.
    - **Mouse Navigation (Permanent):** Accelerating mouse movement, clicking, and scrolling.

## Installation

1.  **Install Interception Driver:**
    - Run the following command in an Administrator PowerShell:
      ```powershell
      & "Interception\Interception\command line installer\install-interception.exe" /install
      ```
    - **Reboot your computer** after installation.

2.  **Verify Files:**
    - Ensure `kanata.exe`, `interception.dll`, and `kanata.kbd` are in the same folder.

## Usage

To start the system:

1.  **Launch:** Run `start_kanata.ps1` (or use the `launch_kanata.bat` shortcut). This starts both Kanata and the AutoHotkey mouse bridge.

## Documentation

Detailed documentation for the configuration and architecture can be found in the `docs/` directory:

- [**Architecture & Bridge**](docs/ARCHITECTURE.md): The technical protocol between Kanata and AHK.
- [**Layout Reference**](docs/LAYOUT.md): Details the Halmak, Mirror, and Mouse layers.
- [**Chord Reference**](docs/CHORDS.md): Lists all chord combinations and their actions.

## Layouts

### Base Layer (Halmak One-Handed)
- **Space:** Tap for Space, Hold for Mirror Layer.
- **Key Chords (Examples):**
  - `w` + `e`: Up
  - `s` + `d`: Down
  - `a` + `r`: Volume Up
  - `q` + `f`: Volume Down

### Navigation Layer
Toggled via **Left Ctrl**. Supports two sub-modes (switched via `Ctrl+Space`):

**1. Mouse Navigation (Default):**
- `w/a/s/d`: Mouse Movement.
- `q/e`: Mouse Wheel Up/Down.
- `Capslock`: Left Click.
- `Shift`: Right Click.
- `Space + Capslock`: Enter.

**2. Keyboard Navigation:**
- `w/a/s/d`: Up/Left/Down/Right Arrows.
- `q + w`: Home.
- `w + e`: End.
- `Capslock`: Enter.
- `Space + Capslock`: Left Click.
- `Shift`: Shift.
- `Space + Shift`: Right Click.
