# Tasks: Fix Tab-Space via Layer Toggle

- [ ] **Step 1: Define Mouse Tab Layer**
    - Edit `kanata.kbd`.
    - Create `(deflayer mouse-tab ...)` where `spc` is `bspc` and everything else is `_`.

- [ ] **Step 2: Update Mouse Layer**
    - Change the `Tab` key mapping from `(chord mouse-chords tab)` to `(tap-hold 200 200 tab (layer-toggle mouse-tab))`.
    - Remove `(tab spc) bspc` and `(tab) tab` from `mouse-chords`.
