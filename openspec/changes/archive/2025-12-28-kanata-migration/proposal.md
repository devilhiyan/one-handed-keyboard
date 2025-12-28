# Kanata Migration Proposal

## Goal
Migrate the existing "Mirror Keys" functionality from AutoHotkey (AHK) to Kanata.

## Why
- **Cross-platform:** Kanata works on Windows, Linux, and macOS.
- **Low-level:** Kanata operates at a lower level than AHK (using Interception on Windows), potentially offering better performance and reliability for complex input handling like chords.
- **Configuration:** Text-based configuration (`.kbd`) is easier to version control and manage than complex AHK scripts.

## Scope
1.  **Mirror Mode:** Replicate the Spacebar-to-Mirror layer functionality.
2.  **Halmak Layout:** Ensure the base layout or mirrored keys respect the Halmak design as implemented in AHK.
3.  **Chords:** Port the chord definitions (e.g., `w+e` = Up) to Kanata's chord engine.
4.  **Navigation Mode:** Implement the Navigation layer (ESDF/WASD movement, mouse control).
5.  **Installation:** Set up Kanata executable and ensure it runs correctly on the user's system.

## Risks
- **Mouse Keys:** Kanata's mouse key support needs to be verified for smoothness compared to the AHK implementation.
- **Complexity:** The AHK script has some advanced logic (transient vs permanent modes) that might need simplification or creative use of Kanata features.
