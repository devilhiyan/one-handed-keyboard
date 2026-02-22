# Change: Update Mode Switch Beeps

## Why
The auditory feedback when switching modes currently uses different pitch tones to distinguish between Halmak, Navigation, and QWERTY. The user requested a more intuitive auditory signal: 1 beep for Halmak, 2 beeps for Navigation, and 3 beeps for QWERTY.

## What Changes
- Update the audio feedback logic in `kanata_mouse_bridge.ahk` to play a specific number of beeps corresponding to the selected mode while maintaining distinct pitch tones for each mode.
  - Switching to Halmak (via F23) plays 1 beep at a medium pitch (e.g., 750Hz).
  - Switching to Navigation (via F24) plays 2 beeps at a high pitch (e.g., 1200Hz).
  - Switching to QWERTY (via Ctrl+Alt+F22) plays 3 beeps at a low pitch (e.g., 400Hz).
- Use a short sleep or loop in Autohotkey to separate the beeps clearly.

## Impact
- Affected specs: `layout-switching`
- Affected code: `kanata/kanata_mouse_bridge.ahk`
