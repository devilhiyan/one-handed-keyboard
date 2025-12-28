# Proposal: Gentler Start Acceleration

## 1. Goal
Reduce the initial "jump" in mouse speed to provide smoother control at low speeds.

## 2. Changes
### AutoHotkey (`kanata_mouse_bridge.ahk`)
- Decrease `AccelFactor` from `0.05` to `0.02`.
    - This creates a much more gradual ramp-up from speed 1.

## 3. Impact
- **Files Modified**: `kanata_mouse_bridge.ahk`.
