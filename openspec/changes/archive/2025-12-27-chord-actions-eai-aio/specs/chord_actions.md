# Spec: 3-Key Chord Actions

## 1. Chord Definitions
- **Chord:** `e + a + i` (Physical `A`, `S`, `D`)
  - **Action:** `Backspace`
- **Chord:** `a + i + o` (Physical `S`, `D`, `F`)
  - **Action:** `Delete`

## 2. Logic Extension
The `PerformChord` function shall be extended to check for a third key:
`PerformChord(Key1, Key2, KeyAct, MouseAct, Key3 := "", KeyAct3 := "")`

- If `Key3` is provided and `GetKeyState(Key3, "P")` is true:
  - Trigger `KeyAct3`.
  - Add to `ActiveChords` with 3-key context.
- Else:
  - Trigger `KeyAct` (normal 2-key chord).

## 3. Repetition
3-key chords SHALL support repetition via `ChordMasterTick` just like 2-key chords.

## 4. Conflict Handling
When a 3-key chord is detected, the script MUST avoid sending the individual 2nd key actions that might have been triggered by the first two keys in the sequence. 
*Note: Due to the immediate nature of `ChordAction`, a slight overlap might occur, but the system should prioritize the 3-key action.*
