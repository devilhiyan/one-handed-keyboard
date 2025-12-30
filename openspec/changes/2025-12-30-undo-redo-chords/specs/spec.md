# Spec: Undo/Redo & Timeout

## Timeout Adjustment
Update both `defchords` definitions:
- `(defchords halmak-chords 50 ...)`
- `(defchords mirror-chords 50 ...)`

## Halmak Chords (`halmak-chords`)
Add:
```lisp
  (l d) C-z
  (n m) C-y
  
  ;; Fallbacks for new keys
  (l) l
  (n) n  ;; (t) -> n was defined, need to verify physical 'n' key mapping
  (m) m
```

*Verification:*
- Physical `l` is mapped to `l` in Halmak? 
- Physical `d` is mapped to `i` in Halmak (already enabled).
- Physical `n` is mapped to `n` in Halmak?
- Physical `m` is mapped to `m` in Halmak?

**Note:** `kanata.kbd` `defsrc` shows `l` at `j k l ;`. 
`deflayer halmak` shows `u h j k l ;`.
Wait, physical `l` maps to `l`?
`deflayer halmak` row 3: `... u h j k l ; ' ret`.
So physical `j`->`h`, `k`->`j`, `l`->`k`, `;`->`l`?
Let's check `kanata.kbd` `deflayer halmak` specifically.

Row 3: `(chord ... a) (chord ... s) (chord ... d) (chord ... f) (chord ... g) h j k l ; ' ret`
Physical keys: `a s d f g h j k l ; '`
So:
- Phys `l` -> `l`? No.
- Phys `h` -> `h`
- Phys `j` -> `j`
- Phys `k` -> `k`
- Phys `l` -> `l`
- Phys `;` -> `;`
(The config shows `h j k l ;` in the layer definition at those positions).

So I will enable chords for physical `l`, `n`, `m` (if not already).

## Mirror Chords (`mirror-chords`)
Add:
```lisp
  (l d) C-A-z  ;; Mirrored Undo? Or keep C-z? Assuming C-z for function.
  (n m) C-A-y  ;; Mirrored Redo?
```
*Decision:* Proposal says "map ld to ctrl z". I will map strictly `(l d)` -> `C-z` on Halmak. 
For Mirror, I will assume consistent behavior `(l d)` -> `C-z` unless otherwise specified, but usually chords follow a mirrored pattern.
*Wait:* In Mirror layer, `l` produces `;`. `d` produces `g`.
The user said "map ld to ctrl z". This likely refers to **Physical Keys** `l` and `d` regardless of layer, or specifically on the Halmak layer. I will apply to **Halmak Layer** primarily.
I will also apply to **Mirror Layer** for consistency if `l` and `d` are used there.
