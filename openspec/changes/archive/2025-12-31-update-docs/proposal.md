# Proposal: Comprehensive Documentation Update

## Goal
Update all project documentation to reflect the recent significant changes in architecture, layout, and functionality.

## Changes

### 1. Root README.md
*   Update `Features` to mention the new Mouse Navigation Mode capabilities (Wheel, Clicks).
*   Update `Installation` if necessary (AutoHotkey v2 + Kanata).
*   Add a section about the `Mouse Bridge` architecture.

### 2. kanata/README.md
*   Update `Layouts` section to reflect the current `mouse` layer (F-keys mapping).
*   Mention the new `mouse-spc-mod` layer and the `Shift`/`Space+Shift` behavior.

### 3. kanata/docs/LAYOUT.md
*   **Mouse Layer:** Update key mappings table (Q/E for Wheel, W/A/S/D for Move, CapsLock/Shift for Clicks).
*   **Helper Layers:** Document `mouse-ctrl-layer` and `mouse-spc-mod`.
*   **Navigation Mode:** Explain the distinction between Keyboard Nav (`MouseMode=0`) and Mouse Nav (`MouseMode=1`) and how they toggle/interact.

### 4. kanata/docs/CHORDS.md
*   Update **Halmak Layer** table:
    *   Add Undo (`l+d`) and Redo (`n+m`).
    *   Add Volume Up (`a+r`) and Volume Down (`q+f`).
    *   Remove `up` mapping for `w+e` if it was removed/changed (wait, `w+e` is End in Nav mode, but `w+e` is Up in Halmak mode? Need to clarify).
        *   *Correction*: `w+e` is `Up` in `halmak-chords` (Base). It is `End` in `mouse-nav-chords` (Nav Mode).
*   Update **Mirror Layer** table:
    *   Add Brightness Up (`a+r`) and Brightness Down (`q+f`).
    *   Add Undo/Redo mirrored mappings.

### 5. CHORDS.md (Root)
*   Sync with `kanata/docs/CHORDS.md` or deprecate/link to it to avoid duplication. (Prefer sync for now as it seems to be a high-level tracking doc).

## Verification
*   Ensure all keys mentioned in `kanata.kbd` are documented.
*   Ensure `kanata_mouse_bridge.ahk` logic is explained in `ARCHITECTURE.md` (or a new doc if needed).
