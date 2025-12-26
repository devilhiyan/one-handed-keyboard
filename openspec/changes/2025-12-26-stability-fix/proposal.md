# Performance and Stability Proposal

## Goal
Prevent script crashes and improve responsiveness during high-frequency key input (mashing).

## Issue
The user reports that the script crashes when pressing the same key multiple times at high frequency. This is likely due to hitting AutoHotkey's default hotkey limit (`A_MaxHotkeysPerInterval`) or a recursion/stack issue caused by the combination of `SendEvent` and multiple remapping layers.

## Plan
1.  **Increase Hotkey Limits:** Raise `A_MaxHotkeysPerInterval` from 200 to 1000 to handle rapid input without triggering AHK's safety suspension.
2.  **Optimize Chord Hook:** Update the `RecordChordKeyDown` function to only process keys relevant to chords. This reduces the number of Map updates and CPU overhead during rapid typing of non-chord keys.
3.  **Switch to Faster Send Mode:** Change the "Restore Typing" and "Mirror" send commands to use `Send` (which defaults to `SendInput`) instead of `SendEvent`. `SendInput` is significantly faster and less likely to cause buffer overflows or timing issues during rapid input.
4.  **Prevent Recursion:** Ensure all "Restore Typing" hotkeys use the `$` prefix (already partially covered by `#UseHook`, but explicit is better for stability) and faster send logic.

## Changes
1.  **`Mirrored keyboard one hand.ahk2`**:
    *   Update `A_MaxHotkeysPerInterval`.
    *   Update `RecordChordKeyDown` with a key filter.
    *   Update `MirrorSend` to use `Send`.
    *   Update all chord-related "Restore Typing" hotkeys to use `Send`.
