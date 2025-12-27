# Proposal: Halmak Refactor & Performance Optimization

## Goal
Refactor Mirror Keys to exclusively use the Halmak keyboard layout, remove all other legacy styles (Standard, Overlapping, Hybrid, Dvorak), fix the Space-key combo crash, and optimize script performance.

## Current State
- Multiple layout styles supported (Standard, Overlapping, Hybrid, Dvorak, Halmak).
- Complex `#HotIf` logic for switching styles.
- Reported crash when combining Space with other keys.
- Duplicate hotkey definitions for Halmak chords and base layers.

## Proposed Changes
1.  **Layout Consolidation**:
    - Remove all logic and hotkeys related to non-Halmak styles.
    - Set `MirrorStyle` to "Halmak" permanently.
2.  **Fix Space Combo Crash**:
    - Optimize the Space prefix handling.
    - Replace `SendEvent` with `SendInput` for faster, more reliable keystrokes.
    - Ensure `Space Up` does not conflict with active chords.
3.  **Performance Optimization**:
    - Eliminate conditional style checks (`#HotIf MirrorStyle == ...`).
    - Consolidate Global Chords and Halmak-specific hotkeys to prevent hook recursion and redundant evaluations.
    - Use `Critical` in time-sensitive chord logic.
4.  **UI Cleanup**:
    - Remove style-switching options from the Tray and Context menus.
    - Update the visual map to reflect the Halmak-only state (if applicable, though map is a static image, I'll update the menu).

## Expected Outcome
- A significantly leaner and faster script.
- Resolution of the "Space + Key" crash.
- Better responsiveness for Halmak chords and mirroring.
