# Chord Reference

Chords allow you to press multiple keys simultaneously to trigger a different action. These are active in both the **Halmak Layer** and the **Mirror Layer**.

## Navigation & Editing Chords (Halmak Layer)

These chords provide access to navigation keys and common editing actions without leaving the home row area.

| Chord Keys (Physical) | Output / Action | Chord Name |
| :--- | :--- | :--- |
| `w` + `e` | `Up Arrow` | |
| `s` + `d` | `Down Arrow` | |
| `a` + `s` | `Left Arrow` | |
| `d` + `f` | `Right Arrow` | |
| `q` + `w` | `Home` | |
| `e` + `r` | `End` | |
| `z` + `x` | `Undo` (Ctrl + Z) | `ld` |
| `l` + `d` | `Undo` (Physical) | |
| `c` + `v` | `Redo` (Ctrl + Y) | `nm` |
| `n` + `m` | `Redo` (Physical) | |
| `a` + `r` | `Volume Up` | `ah` |
| `q` + `f` | `Volume Down` | `co` |
| `g` + `t` | `Play/Pause` | `ur` |
| `q` + `t` | `Screen Capture` | `cr` |
| `s` + `f` | `Backspace` | `ao` |
| `s` + `d` + `f` | `Ctrl + Backspace` | `aio` |
| `a` + `d` | `Delete` | `ei` |
| `x` + `c` | `Ctrl + J` (New Line) | `dn` |
| `z` + `x` + `c` + `v` | `Escape` | `ldnm` |
| `a` + `f` | `Ctrl + C` (Copy) | `eo` |
| `q` + `r` | `{` (Shift + [) | `ch` |
| `s` + `g` | `(` (Shift + 9) | `au` |
| `w` + `t` | `[` | `sr` |
| `w` + `e` + `r` | `.` | `sth` |
| `r` + `w` | `,` | `hs` |
| `f` + `e` | `;` | `ot` |
| `q` + `e` | `<` | `ct` |
| `e` + `t` | `>` | `tr` |
| `a` + `w` | `"` | `es` |
| `s` + `e` + `f` | `=` | `ato` |
| `f` + `g` | `_` | `ou` |

## Mirror Layer Chords (Hold Space)

These chords are active while holding the Spacebar.

| Chord Keys (Physical) | Output / Action | Mnemonic/Logic |
| :--- | :--- | :--- |
| `z` + `x` | `Alt + Ctrl + Z` | |
| `l` + `d` | `Undo` (Ctrl + Z) | |
| `c` + `v` | `Redo` (Ctrl + Y) | |
| `n` + `m` | `Redo` (Ctrl + Y) | |
| `a` + `r` | `Brightness Up` | `ah` |
| `q` + `f` | `Brightness Down` | `co` |
| `s` + `d` + `f` | `Ctrl + Alt + Backspace` | `space aio` |
| `a` + `f` | `Ctrl + V` (Paste) | `space eo` |
| `q` + `r` | `}` (Shift + ]) | `space ch` |
| `s` + `g` | `)` (Shift + 0) | `space au` |
| `w` + `t` | `]` | `space sr` |
| `f` + `e` | `:` | `space ot` |
| `a` + `w` | `'` (Single Quote) | `space es` |
| `s` + `e` + `f` | `+` (Shift + =) | `space ato` |
| `f` + `g` | `-` | `space ou` |

## Navigation Mode Chords (Dedicated Group)

These chords are active only when Navigation Mode is ON.

| Chord Keys (Physical) | Output / Action | Mode |
| :--- | :--- | :--- |
| `q` + `w` | `Home` | Keyboard Mode |
| `w` + `e` | `End` | Keyboard Mode |

## Single Key Fallbacks

Single key presses on chord-enabled keys are handled as fallback characters matching the layout.

### Halmak Fallbacks:
* `(q)` -> `c`, `(w)` -> `s`, `(e)` -> `t`, `(r)` -> `h`, `(t)` -> `n`
* `(a)` -> `e`, `(s)` -> `a`, `(d)` -> `i`, `(f)` -> `o`, `(g)` -> `r`
* `(z)` -> `z`, `(x)` -> `v`, `(c)` -> `d`, `(v)` -> `g`

### Mirror Fallbacks:
* `(q)` -> `b`, `(w)` -> `p`, `(e)` -> `w`, `(r)` -> `y`, `(t)` -> `q`
* `(a)` -> `k`, `(s)` -> `j`, `(d)` -> `g`, `(f)` -> `f`, `(g)` -> `v`
* `(z)` -> `c`, `(x)` -> `b`, `(c)` -> `x`, `(v)` -> `z`

