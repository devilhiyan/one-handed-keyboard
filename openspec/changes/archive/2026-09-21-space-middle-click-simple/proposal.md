# Change: Space + Middle Click for Simple Middle Click

## Why
In HYN and Navigation modes, the middle mouse click is mapped to toggle the NVDA screen reader (B-mode). Users require an intuitive and effortless way to produce a simple, normal Windows middle click without having to toggle B-mode off permanently via `Ctrl + B`. Mapping `Space + Middle Click` provides instant access to a standard middle click (for opening links in new tabs, closing tabs, and autoscrolling).

## What Changes
- In HYN and Navigation modes:
  - Clicking Middle Mouse alone toggles the NVDA screen reader.
  - Holding Space and clicking Middle Mouse sends a simple, standard middle click (`Click "Middle Down"` and `Click "Middle Up"`), supporting both single-click and hold-to-drag.
- `Ctrl + B` remains the master toggle button for Middle Click B-Mode.
- In QWERTY mode, or when B-Mode is toggled OFF, middle click acts natively.
- Upgrade layout cheat sheet (`generate_cheatsheet.py`), documentation (`LAYOUT.md` and `02-Functionality.md`), and regenerate visual assets.

## Impact
- Affected specs: `hyn-layer`
- Affected code: `kanata/kanata_mouse_bridge.ahk`, `kanata/generate_cheatsheet.py`, `kanata/docs/LAYOUT.md`, `documents/One-Handed-Keyboard/02-Functionality.md`
