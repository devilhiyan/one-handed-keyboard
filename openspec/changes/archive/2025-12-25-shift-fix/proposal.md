# Shift Key Behavior Update (Navigation Mode)

## 1. Problem
The current implementation of Shift key logic in Navigation Mode is restrictive:
1.  **Transient Mode**: `Shift` sends a `{Space}` character, preventing its use as a modifier (e.g., for text selection).
2.  **Permanent Mode**: `Space + Shift` sends a `{Space}` character, preventing text selection when using Space-modified navigation keys (e.g., `Space + Shift + E` for `Shift + Up`).

## 2. User Requirement
*   **Transient Mode**:
    *   `Shift` -> Standard Shift Modifier.
    *   `Space + Shift` -> Right Click.
*   **Permanent Mode**:
    *   `Shift` -> Right Click.
    *   `Space + Shift` -> Standard Shift Modifier.

## 3. Proposed Solution

### A. Permanent Mode (`NavMode && MouseMode`)
*   **Current**: `Space & LShift::SendEvent "{Space}"`
*   **New**: Remove this mapping?
    *   If we remove it, pressing `Space + Shift` might do nothing or trigger default Space behavior depending on AHK.
    *   To ensure it acts as a modifier *combined* with other Space hotkeys (like `Space & e`), we might need to rely on `{Blind}` in the other hotkeys.
    *   The hotkeys `Space & e::SendEvent "{Blind}{Up}"` already include `{Blind}`. This means if Shift is held, it should be sent.
    *   **However**, `Space` suppresses the native function of keys combined with it unless defined.
    *   But `Shift` is a modifier.
    *   If I simply **remove** the `Space & LShift` mapping, AHK should allow `Shift` to pass through if it's pressed?
    *   Actually, `Space & LShift` is a specific combination. If not defined, and `Space` is a prefix key, `Space` + `Shift` might just be `Space` held and `Shift` pressed.
    *   If `Space` is a custom modifier, `Space & ...` disable `Space`'s native function.
    *   Test theory: If I remove `Space & LShift`, and I press `Space` (held) + `Shift` (held) + `E` (tap).
    *   AHK sees `Space & e`. Does it see Shift? Yes, provided `Space & e` uses `{Blind}`.
    *   **Conclusion for Permanent Mode**: Remove the `Space & LShift/RShift` mapping.

### B. Transient Mode (`NavMode && !MouseMode`)
*   **Current**: `LShift::SendEvent "{Space}"`
*   **New**: Remove this mapping to restore native Shift behavior.
*   **Current**: `Space & LShift::Click "Right"` (Retain this).

## 4. Code Change

### Permanent Mode Block
```ahk
#HotIf NavMode && MouseMode
...
; Shift (Right Click)
LShift::Click "Right"
RShift::Click "Right"

; REMOVED: Space & LShift::SendEvent "{Space}"
; REMOVED: Space & RShift::SendEvent "{Space}"
...
#HotIf
```

### Transient Mode Block
```ahk
#HotIf NavMode && !MouseMode
...
; Shift (Restore standard modifier behavior)
; REMOVED: LShift::SendEvent "{Space}"
; REMOVED: RShift::SendEvent "{Space}"

; Space + Shift (Right Click)
Space & LShift::Click "Right"
Space & RShift::Click "Right"
...
#HotIf
```