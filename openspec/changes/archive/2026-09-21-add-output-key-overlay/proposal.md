# Change: Add Key Output Overlay & Space + X Shortcut

## Why
When typing with chords and mirror layers on a one-handed layout, users need immediate visual confirmation of the final resolved keystrokes being delivered to Windows. This provides clarity and confidence without interrupting the typing flow.

## What Changes
- Reassigned `Space + X` in mirror chords to send bridge trigger `Ctrl + Alt + F8`.
- Added persistent `ShowOutputKeys` setting in `kanata/kanata_settings.ini`.
- Added system tray menu item `Show Output Keys (Space + X)` with checkmark.
- Created `OutputKeyGui`: a non-intrusive, click-through (`+E0x20`), focus-preserving dark popup above the system tray.
- Added transparent `InputHook("V")` in `kanata_mouse_bridge.ahk` to display final output keys and active modifiers.
- Updated `kanata/generate_cheatsheet.py` and regenerated `layout_cheatsheet.png` and `layout_cheatsheet.pdf`.
- Synchronized `kanata/docs/LAYOUT.md` and `documents/One-Handed-Keyboard/02-Functionality.md`.

## Impact
- Affected specs: `hyn-layer`
- Affected code: `kanata/kanata.kbd`, `kanata/kanata-windows-binaries-x64-v1.10.1/kanata.kbd`, `kanata/kanata_mouse_bridge.ahk`, `kanata/kanata_settings.ini`, `kanata/generate_cheatsheet.py`, `kanata/docs/LAYOUT.md`, `documents/One-Handed-Keyboard/02-Functionality.md`
