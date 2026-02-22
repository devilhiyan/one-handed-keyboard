# Change: Cleanup Legacy Files

## Why
The project has migrated to a hybrid Kanata + AutoHotkey architecture located in the `kanata/` directory. The files in the root directory are legacy artifacts from the pure AHK implementation and are now outdated/redundant.

## What Changes
- **DELETE** `Mirrored keyboard one hand.ahk2`
- **DELETE** `MirrorKeys-Settings-ooki.ini`
- **DELETE** `CHORDS.md`
- **DELETE** `GEMINI.md`

## Impact
- **Affected specs**: None (Files are outside OpenSpec scope)
- **Affected code**: Root directory cleanup.
