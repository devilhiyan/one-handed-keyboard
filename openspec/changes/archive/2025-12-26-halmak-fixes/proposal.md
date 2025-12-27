# Halmak Fixes Proposal

## Goal
Fix inconsistencies in the "Halmak" mirror style and correct the Spacebar behavior to allow single-tap spacing.

## Context
The user identified two issues:
1.  **Halmak CapsLock:** CapsLock does not function as Enter in Halmak mode, unlike other modes.
2.  **Spacebar Tap:** Tapping Space currently requires a double-tap to send a Space (based on code analysis), or is otherwise behaving unexpectedly. The user requested single-tap Space behavior.

## Changes
1.  **Mirrored keyboard one hand.ahk2**:
    *   Add `Capslock::` hotkey to the Halmak `#HotIf` block.
    *   Simplify the global `Space Up::` hotkey to send `{Space}` on a single tap if `Space` was the prior key.
