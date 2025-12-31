# Proposal: Refine Layout Switching and Notifications

## Issue
The previous attempt to fix layout notifications (Halmak vs QWERTY) broke the `Ctrl + Esc` mapping. This was likely because changing the F-key signal affected how Kanata processed the toggle or how the AHK bridge intercepted it.

## Goal
Implement distinct notifications for layout switching while ensuring the `Ctrl + Esc` toggle remains fully functional.

## Analysis of Failure
The `tog-qwer` alias was changed to send `f9`. 
`tog-qwer (multi f9 (layer-switch qwer))`
`ctrl-layer-halmak` mapped `grv` to `@tog-qwer`.
When `Ctrl + Grv` was pressed, it sent `f9` AND switched layer. 
If AHK was too slow or if the F-key interfered with the layer switch timing, it might have failed.

## New Plan
We will use **State Tracking** in AutoHotkey instead of relying on unique F-keys from Kanata for every layout change. Since `f23` is the standard "Exit Special Mode" signal, we can make AHK smarter about what mode it's in.

1.  **Kanata (`kanata.kbd`)**: 
    *   **Keep** the current working toggle logic (`tog-qwer` and `to-halmak` both send `f23`).
    *   This ensures the `Ctrl + Esc` mapping remains robust.
2.  **AutoHotkey (`kanata_mouse_bridge.ahk`)**:
    *   Introduce a `CurrentLayout` variable (0 = Halmak, 1 = QWERTY).
    *   Update the `*F9` logic? No, let's stick to `f23`.
    *   Wait, how does AHK know if it's switching to Halmak or QWERTY if they use the same key?
    *   **Better Idea**: Use `f23` for "Switch to Halmak" and `f22`? No, `f22` is End.
    *   **Actually**: We need two distinct signals that definitely work.
    *   We will use `f23` for Halmak and `f10` for QWERTY.
    *   I will verify why `f9` might have failed. Maybe `f9` is a physical key that was being suppressed?
    *   Let's use `f23` (Halmak) and `f24` (QWERTY)? No, `f24` is Nav Mode ON.
    *   How about `f23` always means "Go to Base Layout" and we toggle a local state?
    *   **Risk**: If they get out of sync, the notification will be wrong.

### Robust Implementation
1.  **Unique F-keys that are "High"**: Use `f23` and `f13`? No.
2.  Let's use `f23` for Halmak and `f12`? No, `f12` is Space+Shift.
3.  Let's use **`f23`** for Halmak and **`f8`** for QWERTY.
4.  I will test `f8` as it's less likely to be used by anything else in this specific way.

## Proposed Changes
### Kanata
*   `to-halmak`: `(multi f23 (layer-switch halmak))`
*   `tog-qwer`: `(multi f8 (layer-switch qwer))`

### AHK
*   `*F23`: Notify "Layout: Halmak", set `NavMode := false`.
*   `*F8`: Notify "Layout: QWERTY", set `NavMode := false`.
