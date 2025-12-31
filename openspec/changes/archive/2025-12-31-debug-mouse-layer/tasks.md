# Tasks

- [ ] Modify `kanata/kanata_mouse_bridge.ahk`:
    - [ ] Add `Global MoveState := {up: 0, down: 0, left: 0, right: 0}`.
    - [ ] Update `ProcessMovement` to use `MoveState`.
    - [ ] Refactor Hotkeys to update `MoveState` on KeyDown/KeyUp events.
        -   Handle `F13-F16` (Up/Left/Down/Right).
        -   Handle `Up/Left/Down/Right` keys.
    -   Ensure `*Key Up` hotkeys are defined to clear state.
