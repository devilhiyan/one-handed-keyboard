# Tasks

- [ ] Modify `Mirrored keyboard one hand.ahk2` @critical
    - [ ] Locate the `GetRemappedKey` function (approx line 1251).
    - [ ] Update the `Dvorak` switch case to include missing keys (`w`, `e`, `a`, `q`) mapping to their Dvorak equivalents (`,`, `.`, `a`, `'`).
    - [ ] Locate the `MirrorStyle == "Halmak"` block (approx line 1188).
    - [ ] Insert the full set of Chord Hotkeys (`w & e`, `s & d`, `a & s`, `d & f`, `q & w`, `e & r` and their reverses) into this block.
    - [ ] Insert the full set of Restore Typing Hotkeys (`w::`, `e::`, `s::`, `d::`, `a::`, `f::`, `q::`, `r::`) into this block.
