# Decision Log

## 2024-03-24 Hybrid Architecture (Kanata + AutoHotkey)
*   **Decision:** Use **Kanata** for low-level key remapping/layers and **AutoHotkey (v2)** for mouse emulation and GUI feedback.
*   **Status:** Accepted
*   **Context:**
    *   **Kanata:** Excellent at "interception" and complex layering/chords (e.g., tap-hold, multi-key chords) which are difficult to implement reliably in pure AHK without interference.
    *   **AutoHotkey:** Superior for logic that requires "state" (like mouse acceleration curves), drawing on-screen overlays (tooltips/GUIs), and interacting with the Windows OS (window management).
*   **Consequences:**
    *   Requires running two processes.
    *   **The Bridge Protocol:** We must reserve F13-F24 keys as communication signals between Kanata and AHK.

## 2024-05-20 Media Seek via Arrow Keys
*   **Decision:** Use `Left Arrow` and `Right Arrow` for Media Seek (Rewind/Fast Forward).
*   **Status:** Accepted
*   **Context:**
    *   Windows lacks a universal "Seek 5 Seconds" command.
    *   Standard `MediaFastForward` keys are unreliable in web players (YouTube, etc.).
    *   Arrow keys are the de facto standard for 5s seeking in almost all media apps.
*   **Consequences:** The app must be in focus for seeking to work.

## 2024-05-20 Custom Brightness Shortcuts
*   **Decision:** Map Brightness to `A+T` (Up) and `Q+G` (Down) on the base layer.
*   **Status:** Accepted
*   **Context:** User preference for specific physical key locations.
*   **Consequences:** Removed legacy brightness controls from the Mirror layer to avoid duplication.

## 2024-03-24 Halmak Layout Base
*   **Decision:** Use **Halmak** as the primary one-handed layout base.
*   **Status:** Accepted
*   **Context:** Optimizes mirror-typing by grouping common letters more efficiently for one-handed use compared to QWERTY.

## 2024-03-24 "Mirror Keys" concept
*   **Decision:** Use `Spacebar` as the primary "Mirror Modifier".
*   **Status:** Accepted
*   **Context:** The spacebar is the easiest key to hold with the thumb while typing with other fingers, enabling rapid access to the "other half" of the keyboard without moving the hand.
