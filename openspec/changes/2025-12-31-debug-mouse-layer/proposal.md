# Proposal: Debug Mouse Layer

The mouse movement feature is currently non-functional despite recent configuration fixes. This proposal aims to diagnose the root cause by adding visibility into the system's state and simplifying the input chain.

## Diagnosis Plan

1.  **Signal Tracing**: We will add file-based logging to `kanata_mouse_bridge.ahk`. This will tell us definitively:
    *   If the bridge receives the "Enable" signal (F24).
    *   If the bridge receives the "Movement" signals (F13-F16).
    *   If the internal state (`NavMode`, `MouseMode`) is toggling correctly.

2.  **Isolation**: We will temporarily bypass the Kanata Chord engine for the movement keys. It is possible that the chord logic is interfering with the rapid-fire or held state of the navigation keys. We will map WASD directly to F13-F16 in a debug layer.

## Expected Outcome

*   A log file `debug_mouse.log` containing timestamps and event names.
*   Confirmation of whether the failure lies in **sending** the signal (Kanata), **receiving** the signal (AHK), or **processing** the movement (AHK logic).
