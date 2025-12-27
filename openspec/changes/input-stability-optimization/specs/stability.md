# Specification: Input Stability

## 1. Hotkey Directives
To prevent input bleeding, the script must ensure that the AHK hook is never bypassed.
- **`#MaxThreadsBuffer On`**: This is critical. It forces AHK to buffer a second press of a hotkey if it's already running, instead of letting it "bleed" through to the OS.
- **`#MaxThreadsPerHotkey 2`**: Allow some overlap for rapid repeats, but manage with `Critical`.

## 2. Atomic Key State Tracking
The `StateHook` must be the absolute source of truth.
```autohotkey
StateHook.OnKeyDown := (ih, vk, sc) => (Critical(), KeyTracker[vk] := 1)
StateHook.OnKeyUp := (ih, vk, sc) => (Critical(), KeyTracker[vk] := 0)
```
Using `Critical()` inside the callback ensures that the map update isn't interrupted by a hotkey that might check that same map.

## 3. Wildcard Suppression
All Halmak keys (q, w, e, r, a, s, d, f) will be changed to `$*q::`, `$*w::`, etc.
- The `*` ensures that `Shift + Q` or `Ctrl + Q` are also captured by the script, preventing the native key from firing if the script logic doesn't explicitly allow it.

## 4. Chord Engine Stability
The `ChordMasterTick` currently clones the `ActiveChords` map. This is good for safety. Adding `Critical` will further stabilize it.
- **Logic**: If any key involved in a chord is released, the chord must be removed immediately from `ActiveChords`.

## 5. Space Prefix Refinement
Current `Space Up` logic:
```autohotkey
Space Up:: {
    if (A_PriorKey = "Space") {
        SendInput("{Space}")
    }
}
```
Refinement: Use a script-level variable `Global MirrorActionOccurred := False`.
- Set `MirrorActionOccurred := True` whenever a mirrored key or chord is fired.
- Reset it on `Space Down`.
- Only send `{Space}` if `!MirrorActionOccurred`.
This is more reliable than `A_PriorKey` in high-speed scenarios.
