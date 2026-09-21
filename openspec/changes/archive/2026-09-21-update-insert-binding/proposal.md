# Change: Change Insert Key Binding to Tab + Grave in HYN Mode

## Why
The previous chord for Insert was `Space + A + D`, which required activating the mirror layer with the Spacebar and pressing a two-key chord. Binding Insert to `Tab + \`` directly in HYN mode provides faster and more direct access with the left hand.

## What Changes
- Replaced `Space + A + D` with `Tab + \`` (`grv`) in HYN mode chords.
- Enabled `grv` key for chord processing in the HYN layer.
- Preserved single-key fallback for `` ` `` and `Tab`.
- Removed `(a d) ins` from mirror chords.
- Updated cheat sheet generator and regenerated layout cheatsheet assets (`layout_cheatsheet.png` and `layout_cheatsheet.pdf`).
- Updated `kanata/docs/LAYOUT.md` and `documents/One-Handed-Keyboard/02-Functionality.md`.

## Impact
- Affected specs: `hyn-layer`
- Affected code: `kanata/kanata.kbd`, `kanata/kanata-windows-binaries-x64-v1.10.1/kanata.kbd`, `kanata/generate_cheatsheet.py`, `kanata/docs/LAYOUT.md`, `documents/One-Handed-Keyboard/02-Functionality.md`
