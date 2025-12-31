# Add Ctrl Toggle Logic to Kanata Mouse Bridge

## Goal
Add the `Ctrl` key as a toggle for `NavMode` in `kanata/kanata_mouse_bridge.ahk`. The user reported that pressing `Ctrl` does nothing, which indicates they expect it to function as the navigation mode toggle.

## Context
The current `kanata/kanata_mouse_bridge.ahk` only has logic for `LWin` as the toggle key. The previous standalone script supported both `LWin` and `Ctrl`.

## Changes
1.  **Modify `kanata/kanata_mouse_bridge.ahk`**:
    -   Add a `#HotIf NavToggleKey == "Ctrl"` block with `~Ctrl Up` logic to toggle `NavMode`.
    -   Optionally change the default `NavToggleKey` to `"Ctrl"` if that's what the user prefers, or keep it flexible. I'll set it to `"Ctrl"` as the default for now since the user explicitly mentioned it.
