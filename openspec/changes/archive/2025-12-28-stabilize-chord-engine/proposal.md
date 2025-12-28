# Proposal: Stabilize Chord Engine and Fix Crashes

## Problem
The user reports that the script crashes when pressing chords. Potential causes include:
1.  **Concurrency issues**: Multiple threads (hooks and timers) accessing global maps without sufficient synchronization.
2.  **Logic Errors**: Empty chord buffers or missing properties in chord data objects.
3.  **Recursion**: `SendInput` triggering hotkeys which then call `PerformChord`.
4.  **Syntax/Compatibility**: AutoHotkey v2 is strict about Map access and object properties.

## Proposed Changes
1.  **Enhanced Concurrency Control**:
    -   Ensure `Critical` is used consistently in all entry points.
    -   Use `Clone()` when iterating over maps.
2.  **Performance Optimization (Hold Speed)**:
    -   Increase `ChordMasterTick` frequency (e.g., to 30ms or 40ms) if 50ms feels too slow.
    -   **Skip `GetKeyVK` in loops**: Pre-calculate and store VK codes in the `ChordMap` and `ActiveChords` data to eliminate repetitive function calls during holding.
    -   Use `SendEvent` or optimize `SendInput` for faster repetition.
3.  **Robust Object Handling**:
    -   Add safety checks for all object property accesses.
4.  **Crash Prevention**:
    -   Avoid starting multiple timers for the same evaluation window.
    -   Prevent "timer pile-up" by ensuring the master tick finishes its work before the next one starts.

## Why
A stable chord engine is critical for the usability of a one-handed layout. These changes prioritize reliability and prevent the script from exiting silently.
