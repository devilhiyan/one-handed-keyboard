# Tasks: Deferred Chord Engine

- [ ] Implement `ChordBuffer` and `ChordWindowTimer` logic [id:1]
- [ ] Refactor `PerformChord` to buffer keys instead of executing immediately [id:2]
- [ ] Create `EvaluateChordBuffer` function to resolve buffered keys to an action [id:3]
- [ ] Ensure repeat logic (ChordMasterTick) respects the deferred start [id:4]
- [ ] Verify that 3-key chords (EAI/AIO) no longer trigger 2-key sub-chords [id:5]
