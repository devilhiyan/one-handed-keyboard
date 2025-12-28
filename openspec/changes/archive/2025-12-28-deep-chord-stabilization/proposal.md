# Proposal: Deep Chord Stabilization and Performance Fix

## Problem
The script crashes during sustained chord holding and performs actions slowly. This is likely due to:
1.  **Timer Overlap**: `ChordMasterTick` (repeating timer) and `EvaluateChordBuffer` (one-shot timer) may be competing for resources or causing re-entrancy issues.
2.  **Iteration Overhead**: Iterating and cloning a Map (`ActiveChords`) 33 times per second (30ms rate) adds unnecessary CPU pressure and memory churn.
3.  **Hook Competition**: Rapid `SendInput` and `MouseMove` calls inside a `Critical` loop can starve the keyboard hook, leading to a hang or crash.

## Proposed Changes
1.  **Single Active Chord Architecture**:
    -   Replace the `ActiveChords` Map with a single `CurrentChord` object. Since it's a one-handed layout, the user can only physically hold one chord combination at a time.
    -   This removes the need for `Map.Clone()` and loops during the repetition phase.
2.  **Strict Re-entrancy Guard**:
    -   Implement a `ProcessingChords` boolean flag to ensure that evaluation and repetition never overlap or interrupt each other.
3.  **Optimized Repeat Loop**:
    -   Streamline `ChordMasterTick` to only check the VK codes of the `CurrentChord`.
    -   Increase the repeat interval slightly to 40ms to ensure the Windows event queue isn't overwhelmed while maintaining a "fast" feel.
4.  **Buffer Safety**:
    -   Clear all buffers and stop all timers immediately if a crash-prone state is detected (e.g., mismatched object properties).

## Why
Simplifying the data structure from a Map to a single object reduces the complexity of the repetition logic by an order of magnitude, making it much harder for the script to crash under load.
