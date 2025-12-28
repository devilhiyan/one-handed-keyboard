# Proposal: Fix Tab-Space via Layer Toggle

## 1. Goal
Implement reliable `Tab + Space = Backspace` behavior in Mouse Mode.

## 2. Issue
- Chording `Tab` and `Space` is proving unreliable or confusing to trigger.

## 3. Solution
- Switch from **Chord** logic to **Layer Toggle** logic.
- **Tab Key**: `(tap-hold 200 200 tab (layer-toggle mouse-tab))`.
- **Mouse Tab Layer**: Maps `Space` to `Backspace`. All other keys are transparent (`_`) to allow mouse movement.

## 4. Impact
- **Files Modified**: `kanata.kbd`.
