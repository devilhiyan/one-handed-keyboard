# Proposal: Remove Mouse Speed Cap

## 1. Goal
Allow mouse speed to accelerate indefinitely as long as a movement key is held.

## 2. Changes
### AutoHotkey (`kanata_mouse_bridge.ahk`)
- Remove the `MaxSpeed` constant and the logic that caps `CurrentSpeed` at `MaxSpeed`.
- `CurrentSpeed` will continue to be multiplied by `AccelFactor` (1.07) every 10ms for as long as a direction key is held.

## 3. Impact
- **Files Modified**: `kanata_mouse_bridge.ahk`.
