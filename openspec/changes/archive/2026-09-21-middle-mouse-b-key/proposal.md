# Change: Map Middle Mouse Click to B Key in HYN and Navigation Modes

## Why
Users operating the one-handed keyboard benefit from triggering the NVDA screen reader toggle and speech dictation without taking their hand off the mouse. Adding B-key functionality to the middle mouse button in both HYN and Navigation modes—with an instant `Ctrl + B` toggle button—makes screen reading and dictation accessible while preserving native middle-click behavior in QWERTY mode or when toggled off.

## What Changes
- Add Middle Mouse Button B-Mode enabled by default in HYN and Navigation modes.
- Middle click toggles NVDA screen reader (`ToggleNVDA()`).
- Space + Middle click triggers Windows Voice Typing (`Win + H`).
- Pressing `Ctrl + B` toggles Middle Click B-Mode ON and OFF with on-screen tooltip and audio beeps.
- In QWERTY mode, or when toggled OFF, middle click acts as normal Windows middle click.
- Cheat sheet zoom drag-panning with middle mouse button remains preserved.
- Update layout cheat sheet image generator (`generate_cheatsheet.py`), documentation (`LAYOUT.md` and `02-Functionality.md`), and re-render visual cheatsheet artifacts.

## Impact
- Affected specs: `hyn-layer`
- Affected code: `kanata/kanata.kbd`, `kanata/kanata_mouse_bridge.ahk`, `kanata/generate_cheatsheet.py`, `kanata/docs/LAYOUT.md`, `documents/One-Handed-Keyboard/02-Functionality.md`
