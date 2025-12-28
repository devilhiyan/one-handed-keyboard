# Kanata Configuration Spec

## Source Keys (`defsrc`)
We need to capture the standard QWERTY keyboard input.

```lisp
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
```

## Layers

### 1. Default Layer (`base`)
- **Spacebar:** Acts as `spc` when tapped, but activates `mirror` layer when held.
- **Chords:** Specific key combinations (e.g., `w`+`e`) trigger navigation or editing keys immediately.
- **Nav Toggle:** A key (e.g., `lmet` or `lctl` as per AHK) to toggle the `navigation` layer.

### 2. Mirror Layer (`mirror`)
Activated by holding Spacebar. Maps left-hand keys to right-hand keys (and vice versa, though primarily One-Handed Left is the goal).

**Mapping (based on AHK `Mirror Keys.ahk2`):**
- `q` -> `b`
- `w` -> `p`
- `e` -> `w`
- `r` -> `y`
- `t` -> `q`
- `a` -> `k`
- `s` -> `j`
- `d` -> `x`
- `f` -> `f`
- `g` -> `z`
- `z` -> `c`
- `x` -> `b` (Wait, AHK says `Space & x:: MirrorSend("b")`) - *Correction: AHK line 1184 `Space & x:: MirrorSend("b")`*
- `c` -> `g`
- `v` -> `v`
- `b` -> `c`
- Numbers row is mirrored to `0`-`6`.
- `Tab` -> `Backspace`
- `Caps` -> `'`

### 3. Navigation Layer (`nav`)
- **Activation:** Toggle via `lmet` (Windows key) or `lctl`.
- **ESDF Mode (default):**
    - `e` -> `Up`
    - `s` -> `Left`
    - `d` -> `Down`
    - `f` -> `Right`
    - `w` -> `Home` / `WheelUp` (Mouse mode)
    - `r` -> `End` / `WheelDown` (Mouse mode)
- **Mouse Control:** Use `kanata` mouse actions (`msov`, `mkdn`, `mkup`) if possible, or mapping to mouse keys.

## Chords (`defchords`)
Based on AHK `ChordMap`:
- `w` + `e` -> `Up`
- `s` + `d` -> `Down`
- `a` + `s` -> `Left`
- `d` + `f` -> `Right`
- `q` + `w` -> `Home` / `WheelUp`
- `e` + `r` -> `End` / `WheelDown`
- `a` + `d` -> `Backspace`
- `s` + `f` -> `Delete`

## Aliases
- `spc-mir`: `(tap-hold 200 200 spc (layer-toggle mirror))`
- `nav-tog`: `(layer-switch navigation)`


