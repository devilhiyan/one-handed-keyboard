# Proposal: Cleanup and Remap Navigation Mode

## Issue
1.  Diagnostic tooltips ("Move: ...") are still visible during mouse movement, which is distracting.
2.  In Keyboard Navigation Mode (Transient Mode), `Shift` functionality is missing or incorrect.

## Requirements
1.  **Remove Tooltips**: Clean up `ProcessMovement` to remove debug text.
2.  **Keyboard Nav Mode Mapping**:
    *   `Shift` -> `Shift` (Standard behavior).
    *   `Space + Shift` -> `Right Click`.

## Plan
1.  Modify `kanata/kanata_mouse_bridge.ahk`.
2.  Remove `ToolTip` calls in `ProcessMovement`.
3.  Update the `#HotIf NavMode && !MouseMode` block to handle Shift logic correctly.
