# Spec: Extended Chords v3

## Halmak Layer Chords (`halmak-chords`)
-   `(s f)`: `bspc` (ao)
-   `(s d f)`: `C-bspc` (aio)
-   `(a d)`: `del` (ei)
-   `(x c)`: `C-j` (dn)
-   `(z x c v)`: `esc` (ldnm)
-   `(a f)`: `C-c` (eo)
-   `(q r)`: `S-[` (ch)
-   `(s g)`: `S-9` (au)
-   `(w t)`: `[` (sr)
-   `(w e r)`: `.` (sth)
-   `(r w)`: `,` (hs)
-   `(f e)`: `;` (ot)
-   `(q e)`: `S-,` (ct)
-   `(e t)`: `S-.` (tr)
-   `(a w)`: `S-'` (es)
-   `(s e f)`: `=` (ato)
-   `(f g)`: `S--` (ou)

## Mirror Layer Chords (`mirror-chords`)
-   `(s d f)`: `C-A-bspc` (space aio)
-   `(a f)`: `C-v` (space eo)
-   `(q r)`: `S-]` (space ch)
-   `(s g)`: `S-0` (space au)
-   `(w t)`: `]` (space sr)
-   `(f e)`: `S-;` (space ot)
-   `(a w)`: `'` (space es)
-   `(s e f)`: `S-=` (space ato)
-   `(f g)`: `-` (space ou)

## Integration Details
-   Update `halmak-chords` and `mirror-chords` definitions.
-   Ensure keys `q w e r t a s d f g z x c v` use the chord engine in both layers.
-   Single key fallbacks in `mirror-chords` must match the mirrored layout:
    - `q`: `b`
    - `w`: `p`
    - `e`: `w`
    - `r`: `y`
    - `t`: `q`
    - `a`: `'`
    - `s`: `k`
    - `d`: `j`
    - `f`: `g`
    - `g`: `f`
    - `z`: `c`
    - `x`: `b`
    - `c`: `x`
    - `v`: `v`