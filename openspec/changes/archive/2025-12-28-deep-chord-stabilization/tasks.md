# Tasks: Deep Chord Stabilization

- [ ] Replace `ActiveChords` Map with a single `CurrentChord` object in `Mirrored keyboard one hand.ahk2` [id:1]
- [ ] Refactor `PerformChord` to use the single object for repeat checks [id:2]
- [ ] Refactor `EvaluateChordBuffer` to assign to `CurrentChord` and manage timers safely [id:3]
- [ ] Simplify `ChordMasterTick` to monitor only the `CurrentChord` [id:4]
- [ ] Adjust `ChordRepeatRate` to 40ms for better stability [id:5]
- [ ] Verify that holding chords for >10 seconds does not crash the script [id:6]
