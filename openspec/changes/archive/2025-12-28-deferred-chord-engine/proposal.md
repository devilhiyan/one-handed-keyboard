# Proposal: Deferred Chord Engine (200ms Window)

## Problem
Currently, chords trigger an action as soon as the minimal required keys are pressed. This makes 3-key chords (like `e+a+i`) difficult to trigger without accidentally firing a 2-key chord (like `a+s`) first.

## Proposed Changes
1.  **Implement a Deferred Execution Window**: When any chord key is pressed, start a 200ms timer.
2.  **Collect Keys**: During this 200ms window, track all keys that are pressed.
3.  **Release Handling (Short Press)**: If keys are released *before* the 200ms timer expires, the script evaluates the *maximum* number of keys that were held simultaneously during that window and performs the corresponding action once.
4.  **Hold Handling (Long Press)**: If keys are held *longer* than 200ms, the script performs the action continuously (repetition) as long as the chord is held.
5.  **Evaluate at Timeout/Release**: Determine the "best" action based on the most complex combination achieved.

## Implementation Details
-   Replace the immediate `PerformChord` logic with a `ChordBuffer` system.
-   When a chord hotkey fires, add the keys to `ChordBuffer`. **Every key in the buffer must be unique.**
-   Set a timer for 200ms (if not already running).
-   The timer callback will check the accumulated keys and map them to the most complex valid chord (prioritizing 3-key over 2-key).
-   Reset the buffer after execution.

## Why
This "Chord Collection" approach eliminates the race condition between different chord lengths and provides a more consistent user experience for intentional simultaneous presses.
