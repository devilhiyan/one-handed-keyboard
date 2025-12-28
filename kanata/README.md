# Kanata Mirror Keys

This directory contains the [Kanata](https://github.com/jtroo/kanata) configuration to replicate the "Mirror Keys" one-handed keyboard functionality.

## Features
- **Mirror Mode:** Hold **Spacebar** to access the mirrored half of the keyboard. The layout is optimized for Halmak but mirrors standard QWERTY keys in the configuration.
- **Chords:** Press two keys simultaneously to trigger navigation/editing actions (e.g., `w`+`e` = Up).
- **Navigation Mode:** Press the dedicated toggle key (default `lctl` or `lmet` based on config, currently mapped to `Nav Toggle`) to enter Navigation Layer (ESDF movement).

## Installation

1.  **Install Interception Driver:**
    - Run the following command in an Administrator PowerShell:
      ```powershell
      & "Interception\Interception\command line installer\install-interception.exe" /install
      ```
    - **Reboot your computer** after installation.

2.  **Verify Kanata:**
    - Ensure `kanata-windows-binaries-x64-v1.10.1` folder is present.

## Usage

To start the key remapper:

1.  Run the startup script:
    ```powershell
    .\start_kanata.ps1
    ```
2.  Keep the window open (or run in background) to maintain the remapping.

## Layouts

### Base Layer
Standard QWERTY.
- **Space:** Tap for Space, Hold for Mirror Layer.
- **Chords:**
  - `w` + `e`: Up
  - `s` + `d`: Down
  - `a` + `s`: Left
  - `d` + `f`: Right
  - `q` + `w`: Home
  - `e` + `r`: End
  - `a` + `d`: Backspace
  - `s` + `f`: Delete

### Mirror Layer (Hold Space)
Mirrors the left hand to the right hand (and vice versa).
- `q` -> `b`
- `w` -> `p`
- `e` -> `w`
- ... (See `kanata.kbd` for full mapping)

### Navigation Layer
Toggle via `lmet` (Windows Key) in the base layer (mapped to `@nav-tog`).
- `e`: Up
- `s`: Left
- `d`: Down
- `f`: Right
- `w`: Home
- `r`: End
- `Space`: Normal Space (does not trigger mirror).
