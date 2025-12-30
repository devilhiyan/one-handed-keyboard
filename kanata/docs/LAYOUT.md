# Keyboard Layout Reference

This document describes the logical layers defined in `kanata.kbd`.

## 1. Halmak Layer (Base)

This is the default layer, optimized for one-handed typing using the Halmak layout principles.

*   **Left Hand Side:** Maps to standard QWERTY keys but outputs Halmak characters.
*   **Chords:** Extensive use of 2-key chords for navigation and editing (see [CHORDS.md](CHORDS.md)).

**Key Behaviors:**
*   `Space`: Taps for `Space`, **Holds** to activate the **Mirror Layer**.
*   `L-Ctrl`: Taps for `L-Ctrl`, **Holds** to activate `ctrl-layer` (helper).
*   `L-Win`: Taps for `L-Win`, **Holds** to activate `fn-layer`.
*   `L-Ctrl` (Tap-Hold special): Used to toggle **Navigation/Mouse Mode**.

## 2. Mirror Layer

**Activation:** Hold `Space` while in the Halmak layer.

This layer "mirrors" the keyboard, allowing the left hand to type keys normally found on the right side of the keyboard.

| Physical Key (Left) | Mirrored Output (Right) |
| :--- | :--- |
| `q` | `b` |
| `w` | `p` |
| `e` | `w` |
| `r` | `y` |
| `a` | `k` |
| `s` | `j` |
| `d` | `g` |
| `f` | `f` |
| `z` | `c` |
| `x` | `b` |
| `c` | `x` |
| `v` | `z` |
| `g` | `v` |

*(Note: The exact mapping is defined in the `deflayer mirror` section of `kanata.kbd`)*

## 3. Mouse / Navigation Layer

**Activation:** Toggle by tapping `L-Ctrl` (configured as `@lctl-enter-nav`).
**Indication:** A tooltip "Navigation Mode: ON" appears (via AHK).

This layer transforms the keyboard into a navigation cluster.

| Key | Action |
| :--- | :--- |
| `e` (Middle Finger Top) | Move Mouse Up |
| `s` (Ring Finger Home) | Move Mouse Left |
| `d` (Middle Finger Home) | Move Mouse Down |
| `f` (Index Finger Home) | Move Mouse Right |
| `q` | Left Click |
| `w` | Right Click |
| `r` | Scroll Up |
| `a` | Scroll Down |

**Exiting:** Tap `L-Ctrl` again to return to Halmak layer.

## 4. QWERTY Layer

**Activation:** Toggle via the `fn-layer` (Hold `L-Win` + press toggle key).

A standard passthrough layer for gaming or when others use the keyboard.
