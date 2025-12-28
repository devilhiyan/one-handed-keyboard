# Tasks: Space-Modifier Layer for Navigation

- [ ] **Step 1: Define Mouse Space-Mod Layer**
    - Edit `kanata.kbd`.
    - Create `(deflayer mouse-spc-mod ...)` where `tab` is `bspc`, `lsft` is `lsft`, and everything else is `_`.

- [ ] **Step 2: Update Mouse Layer**
    - Remove `mouse-chords` from the `mouse` layer mappings.
    - Set `spc` to `@spc-nav-mod` alias.
    - Set `lsft` to `f18`.
    - Set `tab` to `tab`.

- [ ] **Step 3: Define Aliases**
    - `@spc-nav-mod`: `(tap-hold 200 200 spc (layer-toggle mouse-spc-mod))`.
