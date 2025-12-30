# Spec: Mirror Mappings

## Mirror Chords (`mirror-chords`)
Update the single key fallbacks to:

```lisp
  ;; Single key fallbacks (Mirrored Layout)
  (q) b
  (w) p
  (e) w
  (r) y
  (t) q  ;; Implicit based on previous state, user didn't change
  (a) k
  (s) j
  (d) g
  (f) f
  (g) v
  (z) c
  (x) b
  (c) x
  (v) z
```

## Mirror Layer (`deflayer mirror`)
Update the layer visual reference to match the fallbacks (though `(chord ...)` logic takes precedence).
