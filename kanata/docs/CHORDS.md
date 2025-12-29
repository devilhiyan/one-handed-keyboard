# Chord Reference

Chords allow you to press two adjacent keys simultaneously to trigger a different action. These are active primarily in the **Halmak Layer**.

## Navigation & Editing Chords

These chords provide access to navigation keys without leaving the home row area.

| Chord Keys | Action | Mnemonic/Logic |
| :--- | :--- | :--- |
| `w` + `e` | `Up Arrow` | Top row, center |
| `s` + `d` | `Down Arrow` | Home row, center |
| `a` + `s` | `Left Arrow` | Home row, left |
| `d` + `f` | `Right Arrow` | Home row, right |
| `q` + `w` | `Home` | Top row, far left |
| `e` + `r` | `End` | Top row, far right |
| `a` + `d` | `Backspace` | Index + Ring (Home) |
| `s` + `f` | `Delete` | Middle + Index (Home) |

## Single Key Fallbacks

Because Kanata waits to see if you are pressing a second key for a chord, single key presses on chord-enabled keys (`q`, `w`, `e`, `r`, `a`, `s`, `d`, `f`) are handled as "tap-hold" or special chord fallbacks.

In the configuration `(defchords halmak-chords ...)`:

*   `(q)` -> `c`
*   `(w)` -> `s`
*   `(e)` -> `t`
*   `(r)` -> `h`
*   `(a)` -> `e`
*   `(s)` -> `a`
*   `(d)` -> `i`
*   `(f)` -> `o`

This ensures that if you type quickly and don't complete a chord, the intended single character is output (remapped for the Halmak layout).
