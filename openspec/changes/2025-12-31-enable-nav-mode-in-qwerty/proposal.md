# Proposal: Enable Navigation Mode in QWERTY Layer

## Issue
Currently, tapping Left Ctrl toggles Navigation Mode only when in the Halmak layer. In the QWERTY layer, Left Ctrl behaves as a standard modifier (tap for Ctrl, hold for Ctrl Layer).

## Goal
Enable the same Navigation Mode toggle behavior (Tap to Toggle) in the QWERTY layer, ensuring consistent functionality across both base layouts.

## Implementation
Update the `lctl-mod-qwer` alias in `kanata/kanata.kbd` to match the logic of `lctl-mod-halmak`.

*   **Current:** `(tap-hold 150 150 lctl (multi lctl (layer-toggle ctrl-layer-qwer)))`
*   **New:** `(tap-hold 150 150 (multi f24 (layer-switch mouse)) (multi lctl (layer-toggle ctrl-layer-qwer)))`

## Impact
*   **Tap L-Ctrl (QWERTY):** Enters Mouse Navigation Mode.
*   **Hold L-Ctrl (QWERTY):** Access `ctrl-layer-qwer` (for `Ctrl+Esc` layout toggle) AND sends `L-Ctrl` modifier.
