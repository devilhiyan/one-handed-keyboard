(defchords halmak-chords 100
  (w e) up
  (s d) down
  (a s) left
  (d f) right
  (q w) home
  (e r) end
  (a d) bspc
  (s f) del
  
  ;; Single key fallbacks (Remapped to Custom/Halmak)
  (q) c
  (w) s
  (e) t
  (r) h
  (a) e
  (s) a
  (d) i
  (f) o
)

(deflayer halmak
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  (chord halmak-chords q) (chord halmak-chords w) (chord halmak-chords e) (chord halmak-chords r) r    y    u    i    o    p    [    ]    \
  caps (chord halmak-chords a) (chord halmak-chords s) (chord halmak-chords d) (chord halmak-chords f) u    h    j    k    l    ;    '    ret
  lsft l    d    n    m    b    n    m    ,    .    /    rsft
  @to-nav    lmet lalt     @spc-mir       ralt rmet rctl
)

