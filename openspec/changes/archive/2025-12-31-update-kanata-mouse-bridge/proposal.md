# Update Kanata Mouse Bridge for Navigation Modes

## Goal
Update `kanata/kanata_mouse_bridge.ahk` to support toggling between "Keyboard Navigation Mode" and "Mouse Navigation Mode" using `Ctrl + Space`.
This replicates the logic recently (mistakenly) applied to `Mirrored keyboard one hand.ahk2`, but targets the correct script used by the Kanata setup.

## Context
The user uses `kanata/launch_kanata.bat`, which calls `kanata/start_kanata.ps1`, which in turn launches `kanata/kanata_mouse_bridge.ahk`.
The previous changes were applied to `Mirrored keyboard one hand.ahk2`, which is the standalone version, not the one integrated with Kanata.

## Changes
1.  **Modify `kanata/kanata_mouse_bridge.ahk`**:
    -   Implement `NavMode` toggling via `LWin` (similar to existing logic if present, or add it).
    -   Implement `MouseMode` toggling via `Ctrl + Space`.
    -   **Keyboard Navigation Mode (WASD)**:
        -   `w/a/s/d` -> Arrow Keys.
        -   `q` + `w` -> Home.
        -   `w` + `e` -> End.
        -   `Space + w/a/s/d` -> Mouse Movement.
    -   **Mouse Navigation Mode (WASD)**:
        -   `w/a/s/d` -> Mouse Movement.
        -   `Space + w/a/s/d` -> Arrow Keys.
    -   Ensure `NavStyle` defaults to "Old" (WASD).

2.  **Revert Changes in `Mirrored keyboard one hand.ahk2`** (Optional but recommended to keep the standalone version clean if the user strictly uses Kanata now, or keep them synced. The user said "we updated the wrong script", implying the previous action was incorrect for their current usage). *Decision: I will revert the changes in `Mirrored keyboard one hand.ahk2` as part of this proposal to correct the "wrong script" error.*

## Plan
1.  Revert changes in `Mirrored keyboard one hand.ahk2`.
2.  Apply the Navigation Mode logic to `kanata/kanata_mouse_bridge.ahk`.
