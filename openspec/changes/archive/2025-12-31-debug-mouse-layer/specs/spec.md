# Kanata Mouse Bridge Specification (State Tracking)

## State Object
`MoveState := {up: 0, down: 0, left: 0, right: 0}`

## Key Handlers

### F13 (Kanata 'W')
-   **If MouseMode=1 (Mouse):**
    -   Down: `MoveState.up = 1`, `StartMove()`
    -   Up: `MoveState.up = 0`
-   **If MouseMode=0 (Keyboard):**
    -   Down: `SendInput {Blind}{Up}`
    -   Up: `SendInput {Blind}{Up Up}` (handled by auto-repeat usually, but explicit is safer? Standard `SendInput` usually suffices for taps, but for holding, blind pass-through is best).
    -   Actually, simple remapping `*F13::SendInput "{Blind}{Up}"` handles hold automatically in AHK? Yes.

### Up (Kanata 'Space+W')
-   **If MouseMode=1 (Mouse):**
    -   Down: `SendInput {Blind}{Up}`
-   **If MouseMode=0 (Keyboard):**
    -   Down: `MoveState.up = 1`, `StartMove()`
    -   Up: `MoveState.up = 0`

## ProcessMovement
-   Calculates vector based on `MoveState.up`, `MoveState.down`, etc.
-   Moves mouse if vector is non-zero.
-   Accelerates speed.
-   Stops timer if vector is zero.
