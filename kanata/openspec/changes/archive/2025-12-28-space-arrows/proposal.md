# Proposal: Space + WASD = Arrow Keys

## 1. Goal
Enable Arrow Key navigation (Up, Left, Down, Right) while in Navigation Mode by holding the Space key.

## 2. Solution
- Update the `mouse-spc-mod` layer in `kanata.kbd`.
- Map the movement keys (WASD positions) to keyboard arrow keys `up`, `left`, `down`, `right` within this layer.
- **Behavior**:
    - **Space (Held) + W**: `Up` Arrow
    - **Space (Held) + A**: `Left` Arrow
    - **Space (Held) + S**: `Down` Arrow
    - **Space (Held) + D**: `Right` Arrow
    - **Space (Released)**: Mouse Movement (WASD).

## 3. Impact
- **Files Modified**: `kanata.kbd`.
