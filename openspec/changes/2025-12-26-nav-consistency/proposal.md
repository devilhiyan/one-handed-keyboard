# Fix Navigation Consistency Proposal

## Goal
Improve the consistency of navigation chords (e.g., Up/Down/Left/Right) in Halmak and other styles.

## Issue
The user reports that navigation chords work inconsistently, sometimes failing or requiring a specific order.
Analysis suggests the **50ms timeout** for chord detection is too strict. If the user presses the second key 60ms after the first, the script interprets it as typing (sending the remapped characters) instead of navigation. This creates the perception of inconsistency or order-dependency (due to natural variances in finger timing).

## Plan
1.  **Increase Chord Timeout:** Raise the threshold from `50ms` to `90ms`. This provides a larger window for "simultaneous" presses, making navigation much more reliable for average typing speeds, with a minor trade-off for very fast rollover typing of specific digraphs.
2.  **Verify Chord Definitions:** Double-check that all bidirectional chords (`w & e` AND `e & w`) are correctly defined (already done in previous step, but worth ensuring in the final file).

## Changes
1.  **`Mirrored keyboard one hand.ahk2`**:
    *   Update `PerformChord` function: Change `if (timeDiff > 50)` to `if (timeDiff > 90)`.
