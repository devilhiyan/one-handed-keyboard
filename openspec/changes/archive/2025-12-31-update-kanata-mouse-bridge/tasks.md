# Tasks

- [ ] Revert recent changes to `Mirrored keyboard one hand.ahk2` (restore `^Space` and WASD behavior to previous state).
- [ ] Update `kanata/kanata_mouse_bridge.ahk`:
    - [ ] Add/Update `NavMode` and `MouseMode` state variables.
    - [ ] Implement `^Space` to toggle `MouseMode` (Keyboard Nav vs Mouse Nav).
    - [ ] Implement WASD logic for Keyboard Nav Mode (`w/a/s/d`=Arrows, `Space+`=Mouse).
    - [ ] Implement WASD logic for Mouse Nav Mode (`w/a/s/d`=Mouse, `Space+`=Arrows).
    - [ ] Map chords `qw` -> Home, `we` -> End in Keyboard Nav Mode.
    - [ ] Ensure proper `SendInput` vs `MouseMove` calls.
