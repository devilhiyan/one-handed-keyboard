# Proposal: Fix Spacebar Double Press Requirement

## Problem
After using the spacebar as a modifier (holding it for mirroring or chords), the user must press the spacebar twice before it begins working as a normal spacebar again. This indicates that the `MirrorActionOccurred` flag is not being cleared early enough in the next interaction, or it is being set back to `True` during the first tap due to out-of-sync state checks (`GetKeyState`).

## Proposed Solution
1. **Reset on Down:** Ensure `MirrorActionOccurred` is set to `False` at the beginning of the `KeyDown` event for the spacebar, rather than just on the `KeyUp` event.
2. **Logical State Tracking:** Change all modifier checks from `GetKeyState("Space", "P")` to use the script's internal `KeyTracker[0x20]`. This ensures that if the script thinks the spacebar is up (because it just processed a reset), it won't accidentally set `MirrorActionOccurred` back to `True`.
3. **Chord Cleanup:** Clear active chords upon spacebar release to ensure no background timers are active.

## Impact
- **Instant Recovery:** The spacebar will work as a normal spacebar on the very first tap after a layer switch.
- **Consistency:** Modifiers will only trigger if the script's logical state confirms the spacebar is held.
