# Debug Plan Specifications

## 1. AutoHotkey Logging (`kanata/kanata_mouse_bridge.ahk`)

Add a `LogDebug` function and instrument key handlers:

```autohotkey
LogDebug(Message) {
    FileAppend(A_Now . " - " . Message . "`n", "debug_mouse.log")
}

*F24:: {
    LogDebug("F24 Received - NavMode ON")
    global NavMode := true
    ; ... existing logic ...
}

*F13:: {
    LogDebug("F13 (UP) Received")
    ; ... existing logic ...
}
```

## 2. Kanata Simplification (`kanata/kanata.kbd`)

Define a `mouse-debug` layer that removes chords:

```lisp
(deflayer mouse-debug
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  tab  f19  f13  f20  _    _    _    _    _    _    _    _    _    _
  f17  f14  f15  f16  _    _    _    _    _    _    _    _    _
  f18  _    _    _    _    _    _    _    _    _    _
  @lctl-exit-nav  @lmet-mod @to-halmak @spc-nav-mod           _    _    _
)
```

Update the toggle alias to switch to this layer instead:

```lisp
(defalias
  to-mouse (multi f24 (layer-switch mouse-debug))
)
```
