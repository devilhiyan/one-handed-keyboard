# Specification: Spacebar Logic

## Current Implementation
The `Space Up` hotkey checks:
1. `!MirrorActionOccurred`: Ensures no other key was pressed while Space was down.
2. `Duration < SpaceTapThreshold`: Ensures the key was released within 300ms.

```autohotkey
#HotIf MirrorMode || NavMode
Space Up:: {
    Duration := A_TickCount - SpaceDownTime
    if (!MirrorActionOccurred && Duration < SpaceTapThreshold) {
        SendInput("{Space}")
    }
}
#HotIf
```

## Required Change
Remove the `Duration < SpaceTapThreshold` condition. The `!MirrorActionOccurred` flag is sufficient to determine if the spacebar should act as a normal spacebar upon release.

## Revised Logic
```autohotkey
#HotIf MirrorMode || NavMode
Space Up:: {
    if (!MirrorActionOccurred) {
        SendInput("{Space}")
    }
}
#HotIf
```

## Constants
- `SpaceTapThreshold` (300ms) can be kept if needed for other logic, but should be removed from the release character generation.
