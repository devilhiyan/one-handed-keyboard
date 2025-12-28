# Spec: Mouse Layer Debugging

## Layer: Mouse
The `mouse` layer is intended to emulate mouse movement using the WASD cluster.

### Key Mappings (Updated)
- `w` -> Up
- `a` -> Left
- `s` -> Down
- `d` -> Right
- `f` -> `S-m` (Types "M")
    - **Purpose:** Immediate visual feedback that the layer is active.

### Configuration Changes
- **Disable:** `movemouse-smooth-diagonals`
    - **Reason:** Isolate potential movement calculation bugs.
- **Sensitivity:** `(movemouse-* 5 10)` (5 pixels every 10ms) for clear movement.

### Toggle Logic
- Current: `Hold LCTL` -> `Tap Spc` -> `Mouse Layer`.
- Backup: `LAlt` -> `Toggle Mouse Layer`.
