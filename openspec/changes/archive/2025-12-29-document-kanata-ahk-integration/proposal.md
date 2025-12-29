# Proposal: Document Kanata-AHK Bridge Architecture

## Context
The project uses a hybrid approach for keyboard and mouse control:
1.  **Kanata**: Handles low-level keyboard interception, remapping, layers (Halmak/Mirror), and chording.
2.  **AutoHotkey (AHK)**: Handles mouse movement logic, acceleration, and specific GUI feedback (tooltips).

Currently, this interaction is defined only by reading the code (`kanata.kbd` mapping keys to F13-F24, and `kanata_mouse_bridge.ahk` listening to them). There is no central documentation explaining *why* this split exists or *how* the communication protocol (F-keys) works.

## Goal
Create a comprehensive documentation set within a dedicated `kanata/docs/` folder that explains:
- The responsibility split between Kanata and AHK (`kanata/docs/ARCHITECTURE.md`).
- The "Virtual Wire" protocol (F13-F24 mappings).
- The mouse acceleration logic implementation.
- The startup orchestration (`start_kanata.ps1`).
- **Full Reference**: A complete list of all key mappings, layers, and chords (`kanata/docs/LAYOUT.md` and `kanata/docs/CHORDS.md`).

## Why
- **Organization**: Keeps the root `kanata/` directory clean by moving detailed documentation into a dedicated subfolder.
- **Maintainability**: Future developers (or the user) might forget why F13 is mapped in Kanata or why AHK is listening for it.
- **Clarity**: Explains the "Bridge" pattern which is non-standard.
- **Usability**: The user needs a single source of truth for "What does this key do?" since the layout is complex (Halmak + Mirror + Chords).
