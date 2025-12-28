# Halmak Refactor Proposal

## Goal
Update the Base (Halmak) Layer to match the custom key mapping defined in the original AutoHotkey script, instead of using standard QWERTY.

## Context
The user's AutoHotkey script remapped the left-hand keys to a custom layout (Halmak-based) on the base layer, in addition to the mirroring functionality. The current Kanata config uses QWERTY on the base layer, which is incorrect.

## Changes
1.  **Remap Base Keys:** Update the `halmak` layer to output the custom characters.
    *   **Source `q`** -> Output `c`
    *   **Source `w`** -> Output `s`
    *   **Source `e`** -> Output `t`
    *   **Source `r`** -> Output `h`
    *   **Source `t`** -> Output `r`
    *   **Source `a`** -> Output `e`
    *   **Source `s`** -> Output `a`
    *   **Source `d`** -> Output `i`
    *   **Source `f`** -> Output `o`
    *   **Source `g`** -> Output `u`
    *   **Source `z`** -> Output `l`
    *   **Source `x`** -> Output `d`
    *   **Source `c`** -> Output `n`
    *   **Source `v`** -> Output `m`
2.  **Update Chords:** The chords (e.g., `w+e` = `Up`) will still trigger on the *physical* keys, but the **single-key fallbacks** inside the chord definition must now output the *new* mapped characters (e.g., pressing `w` alone outputs `s`).

## Risk
- **Confusion:** The user must be aware that the physical labels on their keyboard will no longer match the output on the base layer (which is the intended behavior).
- **Chord Conflicts:** We must ensure that the remapped outputs don't interfere with the chord detection logic (Kanata handles this by separating source triggers from outputs).