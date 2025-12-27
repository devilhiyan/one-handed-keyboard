# Fix Navigation Consistency and Symmetry (Iteration 3)

## Goal
Make navigation chords (Up/Down/Left/Right) perfectly consistent, order-independent, and reliable in all modes (Halmak, Dvorak, Standard).

## Analysis of Issues
1.  **Symmetry:** The current logic uses `A_TickCount - KeyPressTimes[Key1]`. While both `a & s` and `s & a` are defined, they rely on the `InputHook` accurately catching the prefix key down event.
2.  **Logic Flaw:** Modifiers are usually "held". If a user holds `A` for 500ms then presses `S`, they definitely want navigation. The current logic treats any gap > 150ms as "Rollover Typing", which is the exact opposite of what a user expects when holding a key to use it as a modifier.
3.  **AS Failure:** Likely a combination of the timing logic being backwards for modifier-style usage and potential hook suppression.

## Plan
1.  **Refine Chord Detection Logic:**
    *   **Simultaneous Mode:** If the time difference between BOTH keys going down is < **100ms**, it's a chord (order-independent).
    *   **Modifier Mode:** If the first key was pressed more than **300ms** ago and is still held, it's a chord (intentional modifier usage).
    *   **Typing Rollover:** If the gap is between **100ms and 300ms**, it's treated as fast typing (rollover). This preserves the ability to type `EA` in Halmak.
2.  **Symmetric Timing:** Use `Abs(KeyPressTimes[Key1] - KeyPressTimes[Key2])` to ensure `a & s` and `s & a` behave identically.
3.  **Robust Time Recording:** Improve `RecordChordKeyDown` to ensure it captures events reliably.
4.  **Increase Window:** Provide a more permissive timing for "Simultaneous" presses.

## Changes
1.  **`Mirrored keyboard one hand.ahk2`**:
    *   Update `PerformChord` with the new tripartite logic (Simultaneous / Typing / Modifier).
    *   Update `RecordChordKeyDown` to be more robust.
    *   Ensure `ChordKeys` contains all relevant keys.
