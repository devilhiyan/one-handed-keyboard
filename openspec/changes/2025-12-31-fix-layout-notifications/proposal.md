# Proposal: Fix Layout Toggle Notifications

## Issue
Switching between Halmak and QWERTY layers (via Ctrl+Esc) currently triggers generic or incorrect notifications (e.g., "Navigation Mode: OFF") because both actions share the same signal (`f23`).

## Goal
Provide distinct visual feedback when switching layouts.

## Mappings
*   **Switch to Halmak**: Triggers `F23`. Notification: "Layout: Halmak".
*   **Switch to QWERTY**: Triggers `F9`. Notification: "Layout: QWERTY".

## Plan
1.  **Kanata (`kanata.kbd`)**:
    *   Update `tog-qwer` alias to send `f9` instead of `f23`.
    *   Keep `to-halmak` sending `f23`.
2.  **AutoHotkey (`kanata_mouse_bridge.ahk`)**:
    *   Update `*F23` handler to show "Layout: Halmak".
    *   Add `*F9` handler to set `NavMode := false` and show "Layout: QWERTY".

## Impact
Exiting Navigation Mode (Ctrl) currently maps to `to-halmak` (`f23`). This means exiting Nav Mode will also say "Layout: Halmak", which is accurate and acceptable.
