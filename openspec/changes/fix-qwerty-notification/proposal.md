# Change: Fix QWERTY Notification

## Why
When switching to QWERTY mode from Navigation mode using the `Ctrl` key cycle, the system fails to display the "Layout: QWERTY" notification and doesn't play the associated sound. This occurs because the signal used for this transition (`F22`) is also mapped to the `End` keyboard action within the Navigation Mode's `kanata_mouse_bridge.ahk` logic. The navigation mapping intercepts the `F22` signal, preventing the mode-switch notification block from receiving it.

## What Changes
- Modify `kanata.kbd` to emit `Ctrl + Alt + F22` instead of just `F22` when switching to QWERTY mode via the `to-qwer` alias. This adds modifier keys to avoid colliding with `F22` which is separately mapped to `End` in Navigation Mode.
- Update `kanata_mouse_bridge.ahk` to listen for this modifier combination (`^!F22`) to trigger the QWERTY mode layout switch logic (notification and sound).

## Impact
- Affected specs: `layout-switching`
- Affected code: `kanata/kanata.kbd`, `kanata/kanata_mouse_bridge.ahk`
