# Change: Cycle Modes with Ctrl

## Why
Currently, switching between the Halmak, Navigation, and QWERTY modes requires different key combinations or tapping Ctrl only toggles between two modes depending on the current state. The user wants to streamline this so that tapping the `Ctrl` key cycles through all three modes predictably.

## What Changes
- Modify the `lctl` tap behavior in `kanata.kbd` for all three main layers (Halmak, Mouse/Navigation, QWERTY).
- `lctl` in Halmak will switch to Navigation (Mouse) mode and send a signal (e.g., F24) for a specific sound.
- `lctl` in Navigation (Mouse) will switch to QWERTY mode and send a signal (e.g., F22) for a specific sound.
- `lctl` in QWERTY will switch to Halmak mode and send a signal (e.g., F23) for a specific sound.
- Update `kanata/kanata_mouse_bridge.ahk` to listen for these signals and play distinct sounds for each mode to provide clear auditory feedback.
- Remove the outdated `Mirrored keyboard one hand.ahk2` script from the project.

## Impact
- Affected specs: `layout-switching`
- Affected code: `kanata/kanata.kbd`, `kanata/kanata_mouse_bridge.ahk`
- Removed code: `Mirrored keyboard one hand.ahk2`
