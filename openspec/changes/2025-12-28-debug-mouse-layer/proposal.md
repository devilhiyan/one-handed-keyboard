# Proposal: Debug and Fix Mouse Layer

## Context
The user reports that the "Mouse Mode" in the Kanata configuration is not working. Despite previous configuration updates to correct layer sizes and toggle logic, the mouse cursor movement via keys (ESDF) is not functioning as expected. Additionally, the user requested notifications to indicate state changes, but the current Kanata binary prohibits command execution (`danger-enable-cmd` is disabled).

## Problem
1.  **Layer Activation Uncertainty:** It is unclear if the `mouse` layer is failing to activate, or if it activates but the movement keys fail.
2.  **No Feedback:** The user has no visual or auditory confirmation when entering/exiting layers.
3.  **Command Restrictions:** We cannot use external scripts (PowerShell/AutoHotkey) to show toast notifications because the Kanata binary is compiled with command execution disabled.

## Solution
We will implement a diagnostic approach to isolate the failure and a workaround for feedback.

1.  **Diagnostic Layer Configuration:**
    *   Map a standard key (e.g., `a`) in the `mouse` layer to output a distinct character (e.g., `m`) or symbol. This verifies *layer activation*.
    *   If the layer activates but mouse doesn't move, the issue is with `movemouse` actions or permissions.
    *   If the layer doesn't activate, the issue is with the `lctl + spc` toggle logic.

2.  **Simplify Mouse Actions:**
    *   Temporarily replace `movemouse-smooth-diagonals` and complex acceleration with basic `movemouse-up`, etc., to rule out parameter errors.

3.  **Visual Feedback (Workaround):**
    *   Since we can't spawn processes, we will use **Caps Lock** or **Num Lock** status as a poor-man's indicator if Kanata supports `caps-lock` switching on layer change (though Kanata's ability to manipulate LEDs is limited without specific hardware support, we can try toggling the logical state).
    *   Alternatively, we can map a key in the mouse layer to "jiggle" the mouse immediately upon entry (if possible via macro) or just rely on the test key `a` -> `m`.

## Plan
1.  Modify `kanata.kbd` to include a "Layer Check" key.
2.  Simplify mouse movement parameters.
3.  Test and iterate based on user observation (User will press the check key).

## Risks
*   If Kanata's `movemouse` is completely broken in this binary/OS combo, we may need to switch to an alternative tool (like AutoHotkey) for the mouse emulation part, keeping Kanata for keyboard remapping.

## Success Criteria
*   User can confirm layer activation.
*   User can move mouse cursor using keyboard keys.
