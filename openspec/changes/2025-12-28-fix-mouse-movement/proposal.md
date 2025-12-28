# Proposal: Fix Mouse Movement Actions

## Context
The user has confirmed that the `mouse` layer activates (the `f` key outputs "M"), but the `wasd` keys do not move the cursor. Currently, mouse actions are defined inline (e.g., `(movemouse-up 5 10)`).

## Problem
Inline mouse actions might not be parsing or executing correctly in this specific Kanata build/environment. Additionally, `movemouse-up` requires specific arguments that might behave differently than expected without acceleration.

## Solution
1.  **Use Aliases:** We will move the mouse action definitions into `defalias`. This is the standard, most robust way to define actions in Kanata.
2.  **Verify Action Type:** We will stick to `movemouse-up/down/left/right` but defined as aliases.
3.  **Fallback Test:** We will add `mwu` (Mouse Wheel Up) to the `q` key in the mouse layer. If `q` scrolls but `w` doesn't move, we know cursor movement specifically is the issue.

## Plan
1.  Define aliases: `@mm-u`, `@mm-l`, `@mm-d`, `@mm-r` with value `(movemouse-up 10 10)`, etc.
2.  Update `mouse` layer to use these aliases.
3.  Map `q` to `mwu` (Mouse Wheel Up) and `e` to `mwd` (Mouse Wheel Down) for extra verification.

## Risks
*   If mouse injection is blocked at the driver level, this won't fix it. But this cleans up the config to rule out syntax issues.
