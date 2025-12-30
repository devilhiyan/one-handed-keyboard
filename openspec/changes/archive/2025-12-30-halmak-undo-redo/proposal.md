# Proposal: Halmak Chords Expansion (Undo/Redo + Symbols)

## Goal
Expand the `halmak` and `mirror` layer chords to include Undo/Redo actions and common symbols (`/`, `\`, `?`, `|`, `@`), mapped to intuitive key combinations based on the user's Halmak layout.

## Context
The user requested the following mappings based on the **Halmak** letter positions:
1.  `ld` -> Undo (`Ctrl+z`)
2.  `nm` -> Redo (`Ctrl+y`)
3.  `Space + ld` -> `Ctrl+Alt+z`
4.  `et` -> `/`
5.  `Space + et` -> `\`
6.  `uh` -> `?`
7.  `Space + uh` -> `|`
8.  `au` -> `@`

### Physical Key Mapping
Based on the `kanata.kbd` configuration, the physical keys corresponding to these Halmak letters are:

| Halmak Key | Physical Key (QWERTY) |
| :--- | :--- |
| **L** | `z` |
| **D** | `x` |
| **N** | `c` |
| **M** | `v` |
| **E** | `s` |
| **T** | `e` |
| **U** | `g` |
| **H** | `r` |
| **A** | `a` |

## Changes

### 1. Halmak Layer (`halmak-chords`)
| Chord (Physical) | Halmak Letters | Action |
| :--- | :--- | :--- |
| `(z x)` | `l` `d` | `C-z` (Undo) |
| `(c v)` | `n` `m` | `C-y` (Redo) |
| `(s e)` | `e` `t` | `/` |
| `(g r)` | `u` `h` | `S-/` (?) |
| `(a g)` | `a` `u` | `S-2` (@) |

### 2. Mirror Layer (`mirror-chords`)
| Chord (Physical) | Action |
| :--- | :--- |
| `(z x)` | `C-A-z` |
| `(s e)` | `\` |
| `(g r)` | `S-\` (\|) |

## Impact
-   Significantly improves coding and editing speed by bringing symbols and undo/redo to the home/near-home rows.
-   Utilizes 2-key chords for efficiency.