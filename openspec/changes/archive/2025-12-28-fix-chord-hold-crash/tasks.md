# Tasks: Fix Chord Hold Crash

- [ ] Remove `Critical()` from chord hotkeys in `Mirrored keyboard one hand.ahk2` to reduce thread contention [id:1]
- [ ] Refactor `PerformChord` with enhanced auto-repeat suppression and atomic timer starting [id:2]
- [ ] Update `EvaluateChordBuffer` with `try...catch` and guaranteed state cleanup [id:3]
- [ ] Update `ChordMasterTick` to use a safer `Critical` exit and more robust state checks [id:4]
- [ ] Add a `ProcessingChord` flag to explicitly prevent re-entrancy during evaluation [id:5]
- [ ] Verify that holding any chord for >30 seconds does not cause a crash or script exit [id:6]
