# Proposal: Fix Layout Notifications (Safe Method)

## Goal
Fix the notifications when switching between Halmak and QWERTY layers without breaking the `Ctrl+Esc` functionality.

## Strategy
We will maintain the `f23` signal for both transitions (ensuring `NavMode` is correctly disabled and the toggle works reliably), but we will add an **additional** signal (`f8`) specifically when switching to **QWERTY**.

## Implementation

### 1. Kanata (`kanata.kbd`)
*   **Switch to Halmak (`to-halmak`)**: `(multi f23 (layer-switch halmak))` (Unchanged).
*   **Switch to QWERTY (`tog-qwer`)**: `(multi f23 f8 (layer-switch qwer))` (Adds `f8` signal).

### 2. AutoHotkey (`kanata_mouse_bridge.ahk`)
*   **Variable**: Introduce `LayoutSwitchPending`.
*   **Handler `*F23`**:
    *   Set `NavMode := false`.
    *   Start a short timer (e.g., 50ms) to display "Layout: Halmak".
*   **Handler `*F8`**:
    *   Cancel the `F23` timer.
    *   Notify "Layout: QWERTY".

## Logic Flow
1.  **To Halmak**: Kanata sends `F23`. AHK starts timer. Timer expires -> "Layout: Halmak".
2.  **To QWERTY**: Kanata sends `F23` then `F8`. AHK starts timer (`F23`). AHK receives `F8` immediately -> Cancels timer -> "Layout: QWERTY".
