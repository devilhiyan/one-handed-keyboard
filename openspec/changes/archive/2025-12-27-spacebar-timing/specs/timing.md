# Specification: Spacebar Timing

## 1. Timing Logic
The spacebar serves two roles: a character key and a modifier. To prevent ambiguity, we use a time-based window.

```autohotkey
Global SpaceTapThreshold := 250 ; ms
Global SpaceDownTime := 0

StateHook_KeyDown(ih, vk, sc) {
    Critical()
    KeyTracker[vk] := 1
    if (vk == 0x20) { ; Spacebar
        Global MirrorActionOccurred := False
        Global SpaceDownTime := A_TickCount
    }
}

Space Up:: {
    Duration := A_TickCount - SpaceDownTime
    if (!MirrorActionOccurred && Duration < SpaceTapThreshold && A_TickCount - LastMirrorActionTime > 50) {
        SendInput("{Space}")
    }
}
```

## 2. Benefits
- **Intent Detection**: If a user holds Space for 500ms, they likely intended to use it as a modifier. If they release it without pressing another key, they might have made a mistake or changed their mind. Sending a space in this context is often unwanted.
- **Race Condition Prevention**: Combined with the `LastMirrorActionTime` cooldown, this ensures that rapid interleaved release events (e.g., releasing a mirrored key and the spacebar almost simultaneously) are handled gracefully.
