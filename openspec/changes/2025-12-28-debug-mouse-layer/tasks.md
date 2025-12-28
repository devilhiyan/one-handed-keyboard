# Tasks: Debug Mouse Layer

- [ ] **Step 1: Layer Verification Setup**
    - Modify `kanata.kbd`:
        - In `mouse` layer, map the `f` key to output `m` (or a string "MOUSE_MODE").
        - This allows the user to press `f` to see if they are in the layer.

- [ ] **Step 2: Simplify Mouse Logic**
    - Use WASD for movement.
    - Remove `movemouse-smooth-diagonals yes` from `defcfg` (comment out).
    - Ensure `movemouse-*` actions use simple integer values (e.g., `(movemouse-up 5 10)`).

- [ ] **Step 3: Alternative Activation (Backup)**
    - Add a direct toggle key on the `halmak` layer (e.g., `lalt` or a specific unused key) to switch to `mouse` layer directly, bypassing the `lctl + spc` chord, to rule out chord issues.

- [ ] **Step 4: Testing & Cleanup**
    - Instruct user to test.
    - Once working, revert debug keys (`a` -> `m`).
