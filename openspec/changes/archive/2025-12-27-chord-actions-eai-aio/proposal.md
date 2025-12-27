# Proposal: Assign e+a+i to Backspace and a+i+o to Delete

## Problem
The user wants to use 3-key chord combinations for frequent text editing actions (Backspace and Delete) in the Halmak layout.
- `e + a + i` (Physical `A + S + D`) -> `Backspace`
- `a + i + o` (Physical `S + D + F`) -> `Delete`

## Proposed Changes
1.  **Extend Chord Engine**: Update `PerformChord` and `ChordMasterTick` to support 3-key chords.
2.  **Define New Chords**: Add hotkeys for `A+S+D` and `S+D+F` combinations.
3.  **Conflict Resolution**: Ensure that pressing 3 keys doesn't trigger multiple 2-key chord actions.

## Implementation Details
-   In `Mirrored keyboard one hand.ahk2`, update the `Halmak Chords` section to include the new combinations.
-   Modify `PerformChord` to accept a `Key3` and `KeyAct3`.
-   Update `ChordMasterTick` to monitor the 3rd key if present.

## Verification Plan
-   Press `A+S+D` simultaneously: Verify `Backspace` is sent.
-   Press `S+D+F` simultaneously: Verify `Delete` is sent.
-   Verify that 2-key chords (like `A+S` for `Left`) still work correctly when pressed alone.
-   Verify that mirroring (holding Space) still works with these chords (though no specific mouse action is requested yet).
