# Proposal: Update CapsLock and Space+CapsLock Mappings

## Goal
Swap the functionality of `CapsLock` and `Space + CapsLock` between **Keyboard Navigation Mode** and **Mouse Navigation Mode** to optimize for the primary action in each context.

## Mappings

### 1. Keyboard Navigation Mode (`MouseMode = 0`)
*Focus: Keyboard actions.*
*   **CapsLock** -> **Enter**
*   **Space + CapsLock** -> **Left Click**

### 2. Mouse Navigation Mode (`MouseMode = 1`)
*Focus: Mouse actions.*
*   **CapsLock** -> **Left Click**
*   **Space + CapsLock** -> **Enter**

## Implementation Plan
1.  **Kanata**:
    *   Ensure `caps` (in mouse layer) sends `f17`.
    *   Ensure `caps` (in mouse-spc-mod layer) sends a unique F-key (e.g., `f23`).
2.  **AutoHotkey**:
    *   Update `*F17` handler: Check `MouseMode`. If 1 -> Click, If 0 -> Enter.
    *   Add `*F23` handler: Check `MouseMode`. If 1 -> Enter, If 0 -> Click.

## Technical Details
*   `f17` is currently used for Left Click in AHK. It will now be conditional.
*   `f23` is currently used for "NavMode OFF" signal in Kanata (`to-halmak`). We need to check if `f23` is free to use for this mapping or if we need another key.
    *   *Correction*: `f23` is indeed used for `to-halmak`.
    *   *Alternative*: Use `f24` (NavMode ON)? No.
    *   *Alternative*: Use `f11`? Or verify if `f23` is strictly needed for the bridge toggle logic.
    *   *Decision*: Use `f11` for "Space + CapsLock" to avoid conflict with the mode toggles.
