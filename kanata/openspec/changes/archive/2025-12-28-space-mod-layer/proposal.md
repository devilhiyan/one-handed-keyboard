# Proposal: Space-Modifier Layer for Navigation

## 1. Goal
Implement "Hold Space + Tab = Backspace" and "Hold Space + Shift = Shift" reliably in Navigation Mode.

## 2. Solution
- Replace chords with a dedicated sub-layer activated by holding Space.
- **Mouse Layer**:
    - `lsft`: Right Click (`f18`).
    - `spc`: `(tap-hold 200 200 spc (layer-toggle mouse-spc-mod))`.
    - `tab`: `tab`.
- **Mouse Space-Mod Layer**:
    - `tab`: `bspc`.
    - `lsft`: `lsft` (Shift Modifier).

## 3. Impact
- **Files Modified**: `kanata.kbd`.
