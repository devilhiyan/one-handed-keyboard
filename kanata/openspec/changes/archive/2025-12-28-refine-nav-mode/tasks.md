# Tasks: Refine Navigation Mode

- [ ] **Step 1: Halve Acceleration in AHK**
    - Modify `kanata_mouse_bridge.ahk`.
    - Change `AccelFactor` to a lower value (e.g., `1.07`).

- [ ] **Step 2: Add Backspace Chord to Kanata**
    - Edit `kanata.kbd`.
    - Update the `mouse-chords` group to include `(tab spc) bspc`.
    - In `deflayer mouse`, ensure `tab` and `spc` are using the `chord` command.
