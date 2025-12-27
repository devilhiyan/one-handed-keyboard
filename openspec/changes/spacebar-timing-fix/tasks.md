# Tasks: Spacebar Timing Fix

- [ ] Define `Global SpaceDownTime := 0` and `Global SpaceTapThreshold := 250` [id:1]
- [ ] Update `StateHook_KeyDown` to set `SpaceDownTime := A_TickCount` [id:2]
- [ ] Refactor `Space Up::` to include duration check and logic cleanup [id:3]
- [ ] Verify that a quick tap produces a space [id:4]
- [ ] Verify that holding for >250ms produces NO space on release [id:5]
