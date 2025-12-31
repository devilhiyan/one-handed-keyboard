# Tasks: Debug Mouse Layer

- [ ] Add debug logging to `kanata_mouse_bridge.ahk` to trace key events (F24, F23, F13-F16). <!-- id: 0 -->
- [ ] Create a simplified Kanata layer `mouse-debug` that maps WASD directly to F13-F16 (bypassing chords) to isolate the issue. <!-- id: 1 -->
- [ ] Update `kanata.kbd` to use the `mouse-debug` layer for testing. <!-- id: 2 -->
- [ ] Verify if AHK receives events using the log file. <!-- id: 3 -->
- [ ] If direct mapping works, re-enable chords and investigate chord timing/conflicts. <!-- id: 4 -->
