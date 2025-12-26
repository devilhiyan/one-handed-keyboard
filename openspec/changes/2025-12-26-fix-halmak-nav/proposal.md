# Fix Halmak Navigation Proposal

## Goal
Restore navigation functionality (Up, Down, Left, Right chords) in Halmak mode.

## Issue
The user reports that navigation actions (Global Chords like `w & e` for Up) do not work in Halmak style ("does not do anything"). This suggests the Global Chords defined in the generic block are not firing or are being overridden/ignored when the specific Halmak `#HotIf` block is active, or there is a precedence issue.

## Plan
To strictly ensure navigation chords work in Halmak mode, we will:
1.  **Explicitly define** the navigation chords (`w & e`, `s & d`, etc.) inside the `Halmak` `#HotIf` block.
2.  **Explicitly define** the "Restore Typing" hotkeys (`w::`, `e::`, etc.) inside the `Halmak` block.
3.  **Fix Dvorak Support:** While reviewing `GetRemappedKey`, I noticed incomplete key mappings for Dvorak (missing `w, e, a, q`). I will fix this to prevent similar issues in Dvorak mode.

## Changes
1.  **`Mirrored keyboard one hand.ahk2`**:
    *   In the `MirrorStyle == "Halmak"` block: Add chord hotkeys (`w & e`, etc.) and single-key release hotkeys (`w::`, etc.).
    *   In `GetRemappedKey` function: Add missing Dvorak keys (`w`, `e`, `a`, `q`) to the switch statement.
