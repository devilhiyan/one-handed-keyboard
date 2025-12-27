# Proposal: Fix Spacebar State Sticking

## Problem
After using the spacebar as a modifier (holding it while pressing another key to mirror or navigate), the spacebar sometimes fails to return to its normal "Space" function on subsequent taps. This suggests that the `MirrorActionOccurred` flag or the `KeyTracker` state for the spacebar is not being reset correctly, causing the script to believe a modifier action is still active or that the key was never released.

## Proposed Solution
Implement an explicit safety reset within the `Space Up` hotkey. Since the `Space Up` hotkey fires specifically when the physical spacebar is released, it is the most reliable place to ensure that:
1. `MirrorActionOccurred` is set to `False`.
2. `KeyTracker[0x20]` (Spacebar) is set to `0`.

This "cleans" the state for the next time the spacebar is pressed, regardless of whether previous events were missed by the background `InputHook`.

## Impact
- **Increased Reliability:** Eliminates the "stuck modifier" bug reported by the user.
- **Typing Fluidity:** Restores confidence that a tap will result in a space character after layer switching.
- **Robustness:** Compensates for potential missed events in the high-speed input hook.
