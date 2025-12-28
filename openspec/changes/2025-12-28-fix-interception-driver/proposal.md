# Proposal: Fix Interception Driver for Mouse Injection

## Context
The user reports that neither mouse movement (`WASD`) nor scrolling (`Q/E`) works in the `mouse` layer, although the layer activation key (`F` -> `M`) works. This indicates that **keyboard interception is working**, but **mouse injection is failing**.

## Problem
Kanata uses the Interception driver to inject mouse events on Windows. If the driver is not correctly installed or if Kanata is not configured to identify the mouse device (even a virtual one), injection fails.
Kanata's `kanata.kbd` often requires `windows-interception-mouse-hwid` to be set if specific mouse hardware needs to be intercepted, but for *injection* (creating events), it usually works generically unless blocked. However, since we are *emulating* a mouse with a keyboard, the events are synthetic.

Possible causes:
1.  **Missing `movemouse-inherit-accel-state`:** Some examples suggest this might be needed for smoother operation, though unlikely to block it entirely.
2.  **Driver Issue:** The Interception driver might need a reinstall or a reboot.
3.  **Missing `linux-use-trackpoint-property` equivalent?** (No, Windows).
4.  **Hardware ID:** We might need to explicitly tell Kanata *which* mouse ID to use, or at least define one, even if we are only injecting. (Usually not required for injection, but let's check).

**Crucial Observation:** The `kanata.kbd` currently has `process-unmapped-keys yes`. The logs show `using the Interception driver for keyboard IO`. It does *not* mention mouse IO.

## Solution
1.  **Verify Interception Installation:** We will run the installer `install-interception.exe` again to ensure it's set up.
2.  **Enable Mouse Interception in Config:** We will add a dummy or catch-all `windows-interception-mouse-hwid` to `defcfg` to force Kanata to initialize the mouse subsystem.
3.  **Restart:** A reboot is often required for Interception, but we can try reloading the driver/Kanata first.

## Plan
1.  **Modify Config:** Add `windows-interception-mouse-hwid "Any"` (or similar catch-all if supported, otherwise leave blank or try to find a valid ID).
    *   *Correction:* Kanata docs say: "If this defcfg item is not defined, the log will not print [mouse HWIDs]."
    *   We will add `windows-interception-mouse-hwid "0, 0, 0, 0"` just to see if it triggers initialization, or better yet, run a diagnostic to find IDs.
2.  **Diagnostic Step:** We will create a `diagnostic.kbd` that enables `windows-interception-mouse-hwid "0"` (invalid) just to force logging of actual mouse IDs when the user clicks.
3.  **Re-install Driver:** Run the command line installer.

## Refined Plan
1.  Add `windows-interception-mouse-hwid "0, 0, 0, 0"` to `kanata.kbd`. This often "wakes up" the mouse handling.
2.  Instruct user to run the installation command if they haven't recently.

## Risks
*   Modifying driver settings can temporarily disable input if not careful (Interception is generally safe).

## Success Criteria
*   Mouse moves or scrolls.
