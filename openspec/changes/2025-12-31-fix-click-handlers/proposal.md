# Proposal: Fix Left and Right Click in Mouse Mode

## Issue
Users report that while mouse movement works, left and right clicks (mapped to CapsLock and Shift respectively) are not functioning correctly in Mouse Navigation Mode.

## Diagnosis
The current implementation logic for clicks relies on `#HotIf NavMode`.
*   **Left Click**: Mapped to `Capslock`.
*   **Right Click**: Mapped to `LShift` / `RShift`.

Potential causes:
1.  **State Conflict**: `NavMode` might not be detected correctly in the HotIf block.
2.  **Key Hook**: The `Capslock` or `Shift` keys might be intercepted by Kanata or handled differently.
3.  **Click Syntax**: The `Click` command might be failing or sent too quickly.

## Plan
1.  **Debug Click Events**: Add visual feedback (Tooltips) to the CapsLock and Shift handlers to verify they are firing.
2.  **Verify Kanata Config**: Ensure Kanata passes CapsLock and Shift through or maps them to something AHK can intercept reliably.
3.  **Alternative Mapping**: If standard keys fail, map dedicated F-keys (e.g., F17, F18) from Kanata to Left/Right click actions in AHK, similar to how movement is handled.

## Goals
- Reliable Left Click (Holdable for drag).
- Reliable Right Click.
