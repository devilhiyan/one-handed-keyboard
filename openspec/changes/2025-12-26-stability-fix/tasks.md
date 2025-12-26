# Tasks

- [ ] Modify `Mirrored keyboard one hand.ahk2` @critical
    - [ ] Change `A_MaxHotkeysPerInterval := 200` to `1000`.
    - [ ] Update `RecordChordKeyDown` to filter for `ChordKeys`.
    - [ ] Update `MirrorSend` to use `Send`.
    - [ ] Find all occurrences of `w::SendEvent "{Blind}" . GetRemappedKey("w")` (and other keys) and change to `Send`.
