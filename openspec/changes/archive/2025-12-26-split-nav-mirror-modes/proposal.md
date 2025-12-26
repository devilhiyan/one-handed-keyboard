# Split Nav and Mirror Modes

## 1. Goal
Decouple the "Mirroring" functionality from the script's global running state. Currently, the only way to disable mirroring is to enable Navigation Mode or suspend the script. This change will allow users to toggle Mirror Mode on and off independently, enabling standard keyboard usage without suspending the script or entering Navigation Mode.

## 2. Approach
*   Introduce a global variable `MirrorMode` (default: `False`).
*   Update all Mirror Key `#HotIf` directives to check for `MirrorMode`.
*   Add a Tray Menu item and/or hotkey to toggle `MirrorMode`.
*   Maintain `NavMode` priority (Navigation overrides Mirroring if both are effectively "on", but `MirrorMode` must be true for mirroring to work at all).

## 3. User Experience
*   **Startup State**: Both Navigation Mode and Mirror Mode are **OFF**. Spacebar works normally.
*   **New Menu Item**: "Enable Mirroring" (Checked/Unchecked).
*   **Behavior**:
    *   Mirror Mode ON, Nav Mode OFF: Standard Mirror Keys behavior.
    *   Mirror Mode OFF, Nav Mode OFF: Normal Keyboard behavior (Space is just Space).
    *   Mirror Mode ON/OFF, Nav Mode ON: Navigation Mode behavior (Nav overrides).

## 4. Technical Details
*   Modify `Mirrored keyboard one hand.ahk2`.
*   Wrap Mirror mapping sections with `MirrorMode` check.
