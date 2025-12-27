# Tasks: Input Stability Optimization

- [ ] Enable `#MaxThreadsBuffer On` and increase `A_MaxHotkeysPerInterval` further if needed [id:1]
- [ ] Refactor `PerformChord` and `ChordMasterTick` with `Critical` for atomic evaluation [id:2]
- [ ] Add wildcard `*` to all Halmak layer hotkeys to ensure complete suppression [id:3]
- [ ] Update `StateHook.OnKeyDown` and `OnKeyUp` to use `Critical` to prevent state desync [id:4]
- [ ] Implement a `LastActionTime` check to further guard `Space Up` against accidental space insertion [id:5]
- [ ] Verify fix for "input bleeding" by testing rapid chord combinations [id:6]
