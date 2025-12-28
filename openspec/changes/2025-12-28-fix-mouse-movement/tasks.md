# Tasks: Fix Mouse Movement

- [ ] **Step 1: Define Mouse Aliases**
    - Add the following to `defalias`:
        - `mm-u`: `(movemouse-up 10 10)`
        - `mm-l`: `(movemouse-left 10 10)`
        - `mm-d`: `(movemouse-down 10 10)`
        - `mm-r`: `(movemouse-right 10 10)`

- [ ] **Step 2: Update Mouse Layer**
    - Replace inline actions with `@mm-u`, `@mm-l`, `@mm-d`, `@mm-r` on WASD.
    - Map `q` to `mwu` (Wheel Up).
    - Map `e` to `mwd` (Wheel Down).
