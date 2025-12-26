- [x] **Implement Timing Logic**
    - [x] Create a mechanism to track `DownTime` for prefix keys (`w`, `e`, `s`, `d`, `a`, `f`, `q`, `r`).
    - [x] Define the `ChordTimeout := 50` constant.

- [x] **Update Chord Hotkeys**
    - [x] Modify `w & e`, `e & w`, etc., to check `(A_TickCount - PrefixDownTime) <= ChordTimeout`.
    - [x] If the check fails (timeout exceeded), send the second key's native function immediately (and let the prefix key resolve naturally on up).

- [x] **Refine "Restore Typing"**
    - [x] Ensure that existing "Restore Typing" logic (sending the key on release) remains compatible with this new timeout check.
    - [x] The prefix key logic (`$w::` etc.) needs to capture `A_TickCount`.

- [x] **Verify Halmak Compatibility**
    - [x] Ensure the fallback keys sent on timeout match the current `MirrorStyle` (Halmak/Dvorak/Standard).
