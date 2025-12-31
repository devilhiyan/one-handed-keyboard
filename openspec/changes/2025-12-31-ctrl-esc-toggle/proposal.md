# Proposal: Toggle Halmak/QWERTY Mode via Ctrl+Esc

## Goal
Add a global toggle to switch between the specialized one-handed Halmak layout and the standard QWERTY layout using the shortcut `Ctrl` + `Escape`.

## Implementation

### 1. Alias Definition
Define a new alias `tog-halmak-qwer` that switches to the `qwer` layer when in `halmak`, and back to `halmak` when in `qwer`.

### 2. Layer Updates
*   **Halmak Layer:** Map `lctl` to a tap-hold action that triggers `lctl` on tap but acts as a modifier for `esc`. Wait, Kanata handles chords or specific key combos.
*   **Alternative:** Map `(lctl esc)` chord? No, modifiers are usually handled via layers or tap-hold.
*   **Preferred Method:**
    *   The `lctl` key is already mapped to `@lctl-mod`.
    *   The `ctrl-layer` (activated by holding `lctl`) currently has `_` (transparent) entries.
    *   We will map `esc` in the `ctrl-layer` to `@tog-qwer`.
    *   In the `qwer` layer, `lctl` is mapped to `@lctl-mod`.
    *   We need to ensure `ctrl-layer` has a way to switch back.

### 3. Logic Refinement
*   Current `ctrl-layer` alias:
    ```lisp
    lctl-mod   (tap-hold 150 150 lctl (layer-toggle ctrl-layer))
    ```
*   In `ctrl-layer`:
    *   Map `esc` (which is `q` position physically? No, `tab` is top left. `esc` is usually top left or `caps`).
    *   Kanata `defsrc` has `grv` at top left.
    *   The physical `Esc` key is not in `defsrc`?
    *   `defsrc`: `grv 1 2 ...`
    *   If the user's keyboard has a physical Esc, it needs to be in `defsrc`.
    *   If not, `grv` might be the physical key used for Esc?
    *   Halmak chords use `z x c v` for `esc`.
    *   **Assumption:** The user means "Physical Ctrl + Physical Esc".
    *   Let's check `defsrc` for `esc`. It is NOT present.
    *   **Hypothesis:** `grv` (Grave/Tilde) is the key next to 1.
    *   **Clarification:** Where is physical Esc? Often it's `grv` or `caps`.
    *   If physical Esc exists but isn't in `defsrc`, Kanata passes it through unmodified.
    *   To intercept `Ctrl + Esc`, we must add `esc` to `defsrc`.

## Plan
1.  Add `esc` to `defsrc` (replace `grv`? or add it if it's separate).
    *   Standard 60%: `Esc` is usually `grv` position.
    *   Let's assume `grv` IS the key the user calls Esc, or they have a dedicated Esc.
    *   I'll try to add `esc` to `defsrc`.
2.  Update `ctrl-layer` to map `esc` (or `grv`) to a toggle action.
3.  The toggle action:
    *   If in `halmak`: Switch to `qwer`.
    *   If in `qwer`: Switch to `halmak`.
    *   Since `qwer` layer is "standard", it might not have the complex `lctl-mod`?
    *   `qwer` layer definition:
        ```lisp
        @lctl-mod  @lmet-mod lalt     spc ...
        ```
    *   It *does* use `@lctl-mod`. So `ctrl-layer` is shared.

## Action
*   In `ctrl-layer`, map the key at `grv` position (or `esc` if I add it) to `@tog-qwer`.
*   Alias `@tog-qwer` handles the switching.
    *   Wait, `tog-qwer` currently is `(multi f23 (layer-switch qwer))`. It only switches TO `qwer`.
    *   We need a toggle behavior. `(layer-switch halmak)` vs `(layer-switch qwer)`.
    *   Since `ctrl-layer` is shared, we can't easily make one key do opposite things depending on the *base* layer unless we have two ctrl layers (one for halmak, one for qwer) or use a conditional macro (not supported cleanly in Kanata yet?).
    *   **Solution:** Create `ctrl-layer-halmak` and `ctrl-layer-qwer`.
    *   Update `halmak` layer to use `@lctl-mod-halmak`.
    *   Update `qwer` layer to use `@lctl-mod-qwer`.
    *   `ctrl-layer-halmak`: Map `esc` to `(layer-switch qwer)`.
    *   `ctrl-layer-qwer`: Map `esc` to `(layer-switch halmak)`.

## Revised Plan
1.  Duplicate `ctrl-layer` into `ctrl-halmak` and `ctrl-qwer`.
2.  In `halmak` layer, change `lctl` to trigger `ctrl-halmak`.
3.  In `qwer` layer, change `lctl` to trigger `ctrl-qwer`.
4.  In `ctrl-halmak`, map `grv` (assuming it's the top-left key) to `@to-qwer`.
5.  In `ctrl-qwer`, map `grv` to `@to-halmak`.
