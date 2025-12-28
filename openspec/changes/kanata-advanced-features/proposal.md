# Kanata Advanced Features Proposal

## Goal
Enhance the Kanata configuration with CapsLock behavior, layout toggling, mouse mode, and improved repeat rates.

## Changes

1.  **CapsLock to Enter:**
    *   In `halmak` layer, map `caps` to `ret`.
2.  **Layout Toggle (FN + Space):**
    *   Map `lmet` (Function key) + `spc` to toggle between `halmak` and `qwer` modes.
    *   Since `lmet` is currently used as a layer switch, I will adjust it to a `tap-hold` or similar if needed, or use it as a modifier for the space combo.
3.  **Mouse Mode Toggle (LCTL + Space):**
    *   Map `lctl` + `spc` to toggle between `keyboard` and `mouse` modes.
    *   This requires creating a `mouse` layer with mouse movement/click actions.
4.  **Improved Key Repeat:**
    *   Add `defcfg` options to tune the `key-repeat-delay` and `key-repeat-interval` to make them feel more responsive.
5.  **Chord Cleanup:**
    *   Ensure chords don't interfere with the new toggles.

## Why
- Match the flexibility of the original AHK script.
- Provide faster feedback for held keys.
- Enable full mouse control without leaving the home row.
