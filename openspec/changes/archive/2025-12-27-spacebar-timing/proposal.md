# Proposal: Spacebar Timing & Duration-Based Release

## Goal
Fix the issue where tapping the Spacebar fails to produce a space character and implement a "Hold Threshold" to distinguish between intentional spaces and unused modifier holds.

## Current State
- `Space Up` checks `!MirrorActionOccurred` and a 50ms cooldown against the last mirror action.
- Users report that tapping Space doesn't always work.
- There is no logic to suppress a space if the user holds the key for a long time (intending to use it as a modifier) but then changes their mind.

## Proposed Changes

### 1. Spacebar Press Timing
- Add a global variable `SpaceDownTime` to record the exact millisecond the Spacebar was pressed.
- Update `StateHook_KeyDown` to populate this variable.

### 2. Duration-Based Release Logic
- Implement a `SpaceTapThreshold` (default: 250ms).
- Refactor `Space Up` to:
    1. Calculate `Duration = A_TickCount - SpaceDownTime`.
    2. Only send `{Space}` if:
        - `!MirrorActionOccurred` (No chords or mirrored keys were used).
        - `Duration < SpaceTapThreshold` (The key was released quickly).
- This ensures that a long hold (e.g., holding Space for 1 second and then releasing) does NOT trigger a space character.

### 3. Reliability Enhancements
- Ensure `MirrorActionOccurred` is reset every time Space is pressed down, regardless of how it was triggered.
- Add a small buffer to the cooldown logic to prevent race conditions during high-speed typing.

## Expected Outcome
- Tapping the Spacebar will reliably produce a space.
- Holding the Spacebar for more than 250ms without pressing another key will correctly do nothing upon release.
- Improved typing rhythm and reduced accidental space insertion.
