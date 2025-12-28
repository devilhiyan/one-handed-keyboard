(defcfg
  process-unmapped-keys yes
  ;; Tuning repeat rates
  movemouse-inherit-remote-settings yes
  movemouse-smooth yes
)

(defalias
  ;; Tap for Space, Hold for Mirror Layer
  spc-mir (tap-hold 200 200 spc (layer-toggle mirror))

  ;; Layer Switchers
  to-nav    (layer-switch navigation)
  to-halmak (layer-switch halmak)
  to-qwer   (layer-switch qwer)
  to-mouse  (layer-switch mouse)

  ;; Logic for LCTL + Space (Mouse Toggle)
  ;; We will use 'fork' for conditional actions
  ;; If LCTL is held, and Space is pressed, go to mouse.
  lctl-mod (tap-hold 200 200 lctl (layer-toggle ctrl-held))
  lmet-mod (tap-hold 200 200 lmet (layer-toggle fn-held))
)

;; Helper layer to catch Space while Ctrl is held
(deflayer ctrl-held
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _              @to-mouse      _    _    _
)

;; Helper layer to catch Space while FN (LMet) is held
(deflayer fn-held
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _              @to-qwer       _    _    _
)

(deflayer mouse
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    mswu msup mswd _    _    _    _    _    _    _    _    _
  _    _    mslt msdn msrt _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _
  @to-halmak _    _        _              _    _    _
)
