## 1. Implementation
- [ ] 1.1 In `kanata.kbd`, change the `to-qwer` alias to emit `lctl lalt f22` instead of just `f22`.
- [ ] 1.2 In `kanata_mouse_bridge.ahk`, change the `*F22::` hotkey definition to `^!F22::` so it correctly intercepts the new QWERTY mode switch signal with modifiers.
