# Tasks

- [ ] Update `kanata/kanata.kbd` to ensure CapsLock is mapped to `f17` in the `mouse` layer (already done).
- [ ] Update `kanata/kanata.kbd` to ensure Space + CapsLock sends a distinct F-key (e.g., `f23`) in the `mouse-spc-mod` layer.
- [ ] Update `kanata/kanata_mouse_bridge.ahk` to handle `f17` (CapsLock) and `f23` (Space + CapsLock) based on `MouseMode`.
    - **Keyboard Mode (`!MouseMode`)**:
        - `f17` (CapsLock) -> Enter
        - `f23` (Space + CapsLock) -> Left Click
    - **Mouse Mode (`MouseMode`)**:
        - `f17` (CapsLock) -> Left Click
        - `f23` (Space + CapsLock) -> Enter
