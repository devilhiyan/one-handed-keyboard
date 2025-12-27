# Change: Fix Chord Crash and Stabilize Logic

## Why
The script crashes when a chord key and a non-chord key are pressed in combination. This is likely due to redundant hotkey definitions and initialization order issues.

## What Changes
- Unified initialization of global variables at the top of the script.
- Consolidated `#HotIf` blocks for mirroring and chords.
- Removed redundant hotkey definitions.
- Refactored `PerformChord` and `ChordMasterTick` for better stability.

## Impact
- All chord-related files: `Mirrored keyboard one hand.ahk2`.
- Corrects behavior for Halmak chords and typing.
