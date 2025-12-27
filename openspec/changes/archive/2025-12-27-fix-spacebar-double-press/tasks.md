# Tasks: Fix Spacebar Double Press

- [x] Update `StateHook_KeyDown` to reset `MirrorActionOccurred` on any spacebar down event. <!-- id: 0 -->
- [x] Update `MirrorSend` to check `KeyTracker[0x20]` instead of `GetKeyState`. <!-- id: 1 -->
- [x] Update `ChordAction` to check `KeyTracker[0x20]` instead of `GetKeyState`. <!-- id: 2 -->
- [x] Add `ActiveChords.Clear()` to `Space Up` hotkey. <!-- id: 3 -->
- [x] Verify that the first tap after a layer switch (Space+Key) produces a space. <!-- id: 4 -->
- [x] Verify that chords still work correctly when Space is held. <!-- id: 5 -->
