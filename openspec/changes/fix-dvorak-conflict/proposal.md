# Fix Dvorak & Chords Conflict

## 1. Problem
The "Global Chords" feature uses keys `W, E, R, A, S, D, F, Q` as "prefix keys" to detect combinations like `W+E` or `S+D`. To preserve typing functionality, release handlers (e.g., `s::Send "s"`) were added.

However, these release handlers are defined at the bottom of the script inside a `#HotIf !NavMode` block. In AutoHotkey, this overrides the earlier `#HotIf MirrorStyle == "Dvorak"` block for the same keys. As a result, when "Dvorak" style is active, pressing `S` sends `s` (via the chord handler) instead of `o` (the Dvorak mapping).

## 2. Proposed Solution
Modify the "Restore Typing" release handlers in the Global Chords block to explicitly check for the "Dvorak" Mirror Style and send the correct character if active.

### Keys Requiring Updates
Only keys that are **both** used in Chords **and** remapped in the Dvorak Alpha-Only layout need updates:
*   **S** (Dvorak `o`)
*   **D** (Dvorak `e`)
*   **F** (Dvorak `u`)
*   **R** (Dvorak `p`)

*Note: `W, E, Q` map to symbols in Dvorak and are kept as standard keys in the Alpha-Only mode, so they do not need changes. `A` maps to `a`, so no change.*

## 3. Implementation Details
```ahk
; --- Restore Typing (Prefix Release) ---
; ...
s:: {
    if (MirrorStyle == "Dvorak")
        SendEvent "o"
    else
        SendEvent "s"
}
d:: {
    if (MirrorStyle == "Dvorak")
        SendEvent "e"
    else
        SendEvent "d"
}
f:: {
    if (MirrorStyle == "Dvorak")
        SendEvent "u"
    else
        SendEvent "f"
}
r:: {
    if (MirrorStyle == "Dvorak")
        SendEvent "p"
    else
        SendEvent "r"
}
; ... (Others remain simple one-liners)
```
