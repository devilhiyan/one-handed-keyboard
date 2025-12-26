# Chord Timeout

## 1. Goal
Implement a timing constraint for "Global Chords" (key combinations like `W+E`, `S+D`). Currently, pressing `W` and then `E` *at any time* triggers the chord. This proposal introduces a strict **50ms timeout**. If the second key is not pressed within 50ms of the first key, the input should be treated as separate key presses (standard typing), not a chord.

## 2. Approach
*   **Track Press Time**: Record the `A_TickCount` when the first key of a potential chord (the "prefix key") is pressed.
*   **Validate on Second Press**: When the second key is pressed, compare the current time against the stored press time of the prefix key.
    *   **If diff <= 50ms**: Execute the Chord Action.
    *   **If diff > 50ms**: Do *not* execute the chord. Instead, ensure the second key functions normally (this might require passthrough or explicit sending).
*   **Prevent "Stuck" Keys**: Ensure that if the chord is rejected, the prefix key still functions correctly (e.g., sends its character on release if it wasn't part of a valid chord).

## 3. User Experience
*   **Fast Typing (Rollover)**: Users typing quickly (e.g., "we", "as") with overlaps > 50ms will no longer accidentally trigger navigation actions.
*   **Intentional Chords**: To trigger a chord (e.g., `Up Arrow`), the user must press the two keys nearly simultaneously (simul-press style).

## 4. Technical Implementation
*   Modify `Mirrored keyboard one hand.ahk2`.
*   Update the `PerformChord` function or the hotkey definitions to include the time check.
*   Variables: `Key1_PressTime := A_TickCount` (needs to be stored per key or globally if only checking the primary chord keys).
