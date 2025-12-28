# Proposal: Refine Navigation Mode

## 1. Goal
Slow down mouse acceleration for better control and add a backspace shortcut to Navigation Mode.

## 2. Changes
### AutoHotkey (`kanata_mouse_bridge.ahk`)
- **Acceleration**: Reduce the `AccelFactor` to halve the acceleration rate (e.g., from `1.15` to `1.07`).

### Kanata (`kanata.kbd`)
- **Mouse Layer Updates**:
    - **Tab + Space** -> **Backspace** (`bspc`).
    - This will be implemented as a chord within the `mouse` layer.

## 3. Impact
- **Files Modified**: `kanata.kbd`, `kanata_mouse_bridge.ahk`.
