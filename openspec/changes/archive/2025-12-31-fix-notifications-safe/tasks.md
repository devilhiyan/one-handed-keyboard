# Tasks

- [ ] Update `kanata/kanata.kbd`: Modify `tog-qwer` alias to `(multi f23 f8 (layer-switch qwer))`.
- [ ] Update `kanata/kanata_mouse_bridge.ahk`: Implement debounced notification logic for `F23` and `F8`.
    - `F23`: Start timer `NotifyHalmak`.
    - `F8`: Cancel timer `NotifyHalmak`, call `Notify("Layout: QWERTY")`.
    - `NotifyHalmak`: Call `Notify("Layout: Halmak")`.
