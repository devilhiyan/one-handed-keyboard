# Change: Switch Between Middle Click Modes via Ctrl + B

## Why
Users have two distinct usage workflows for the middle mouse button in one-handed HYN and Navigation modes:
1. Fast Single-Click NVDA toggling (with Space + Middle Click for standard click).
2. Standard Single-Click middle mouse actions (with Double-Click for NVDA toggling).
Providing `Ctrl + B` as a mode switcher gives the user immediate control over both behaviors without compromise.

## What Changes
- Implement two middle mouse button modes in HYN and Navigation modes:
  - **Double-Click Mode (Default)**: Single middle click acts as normal middle click (and hold/drag for autoscroll); double clicking middle mouse toggles NVDA.
  - **Single-Click Mode**: Single middle click toggles NVDA; holding Space + middle clicking gives a simple middle click.
- `Ctrl + B` toggles between Double-Click Mode and Single-Click Mode with clear tooltip notifications and audio chimes.
- In QWERTY mode, middle click acts natively.
- Cheat sheet overlay zoom drag-panning remains preserved.
- Upgrade cheat sheet generator, documentation, and visual assets.

## Impact
- Affected specs: `hyn-layer`
- Affected code: `kanata/kanata_mouse_bridge.ahk`, `kanata/generate_cheatsheet.py`, `kanata/docs/LAYOUT.md`, `documents/One-Handed-Keyboard/02-Functionality.md`
