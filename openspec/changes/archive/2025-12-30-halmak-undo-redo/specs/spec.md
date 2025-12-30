# Specification: Halmak Chords Expansion

## Key Mappings

### Halmak Chords (`halmak-chords`)
Active in the base Halmak layer (Left Hand).

| Chord (Physical) | Halmak logical | Action | Output |
| :--- | :--- | :--- | :--- |
| `(z x)` | `L` `D` | `C-z` | Undo |
| `(c v)` | `N` `M` | `C-y` | Redo |
| `(s e)` | `E` `T` | `/` | `/` |
| `(g r)` | `U` `H` | `S-/` | `?` |
| `(a g)` | `A` `U` | `S-2` | `@` |

### Mirror Chords (`mirror-chords`)
Active when Spacebar is held (Mirror Layer).

| Chord (Physical) | Action | Output |
| :--- | :--- | :--- |
| `(z x)` | `C-A-z` | Ctrl+Alt+Z |
| `(s e)` | `\` | `\` |
| `(g r)` | `S-\`` | `|` |

## Notes
-   **Physical Mapping Verification:**
    -   `E` (Halmak) -> `s` (Physical)
    -   `T` (Halmak) -> `e` (Physical)
    -   `U` (Halmak) -> `g` (Physical)
    -   `H` (Halmak) -> `r` (Physical)
    -   `A` (Halmak) -> `a` (Physical)
-   **Conflicts:**
    -   `(z x)` is a subset of `(z x c v)` (Esc). 50ms timeout handles this.
    -   `(s e)` is a subset of `(s e f)` (=/Shift-=). 50ms timeout handles this.
    -   `(g r)` has no obvious conflicts in current chords.
    -   `(a g)` has no obvious conflicts.