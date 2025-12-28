# Specification: Halmak Refactor

## 1. Constants and Globals
- Hardcode `MirrorStyle := "Halmak"`.
- Remove `ToggleMirrorStyle` and related `StreamRead/Write` calls for MirrorStyle.

## 2. Hotkey Optimizations
- Replace all `SendEvent` calls in mirroring logic with `SendInput` (via `MirrorSend`).
- Consolidate `#HotIf MirrorStyle == "Halmak"` and `#HotIf !NavMode && MirrorMode`.

## 3. Space Handling
- Ensure `Space Up` correctly identifies when a combo was sent to avoid double spacing or dead space.
- Use `A_MenuMaskKey` if necessary to prevent Start Menu interference during combos.

## 4. Chord Optimization
- Refine `PerformChord` to use a more efficient delay/repeat mechanism.
- Remove redundant Halmak definitions that appeared both in the style section and the Global Chords section.
