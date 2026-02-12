# Project Analysis Report: Mirror Keys

> Date: 2026-02-12
> Status: Analysis Complete

## 1. Project Overview
"Mirror Keys" is a one-handed typing system designed to allow full keyboard access using primarily the left hand. It employs a "Mirror Layer" concept where holding the **Spacebar** mirrors the keyboard layout (e.g., Left-Hand keys output Right-Hand keys).

## 2. Architecture Evolution
The project is currently transitioning or has transitioned from a standalone AutoHotkey implementation to a more robust hybrid architecture.

### Legacy / Standalone (`Mirrored keyboard one hand.ahk2`)
-   **Technology**: Pure AutoHotkey v2.
-   **Mechanic**: Uses `InputHook` to intercept keys and reimplement chords/layers in software.
-   **Features**: Includes a GUI Map, Settings persistence, and Tray icon management.
-   **Limitations**: Complex handling of "chords" (simultaneous key presses) and potential interference with other hooks.

### Hybrid Architecture (`kanata/`)
-   **Decision Date**: 2024-03-24
-   **Components**:
    1.  **Kanata (`kanata.kbd`)**: Low-level kernel interception (via Interception driver). Handles the heavy lifting of key remapping, layers (Halmak, Mirror, QWERTY), and chords.
    2.  **AutoHotkey Bridge (`kanata_mouse_bridge.ahk`)**: Handles logic that Kanata finds difficult, specifically stateful Mouse Movement (acceleration curves), GUI overlays (Tooltips), and Windows OS interactions (Brightness WMI).
-   **Communication**: "Bridge Keys" (F13-F24) are sent by Kanata and trapped by AHK to trigger actions.

## 3. Key Components

### Kanata Configuration (`kanata.kbd`)
-   **Layers**:
    -   `default` (Halmak): Optimized one-handed base layout.
    -   `mirror`: Activated by holding Space. Mirrors keys (e.g., `q` -> `z`, `w` -> `b`).
    -   `mouse`: Activated by tapping Left Control. Maps WASD to F-keys for AHK to read.
    -   `qwer`: Standard QWERTY fallback.
-   **Chords**: Extensive use of chords (simultaneous presses) for navigation (e.g., `w+e`=Up), editing (`z+x`=Undo), and media control.

### AHK Bridge (`kanata_mouse_bridge.ahk`)
-   **Role**: Listens for F13-F24 signals from Kanata.
-   **Mouse Engine**: Implements smooth mouse acceleration when WASD (mapped to F13-F16) are held.
-   **Visuals**: Provides ToolTip feedback for mode switching (Nav Mode ON/OFF).
-   **System**: Controls Screen Brightness via WMI calls when triggered by specific F-key combos.

## 4. Documentation Status
-   `01-Decisions.md`: Records the shift to Hybrid Architecture and choice of Halmak layout.
-   `02-Functionality.md`: Detailed specification of mappings, chords, and the Bridge Protocol.

## 5. Conclusion
The project is in a rigorous state with a clear separation of concerns. The move to Kanata for input processing significantly improves reliability for fast typing and chording, while retaining AHK for the "creature comforts" of mouse emulation and visual feedback.
