## ADDED Requirements

### Requirement: Documentation Consistency
The system documentation structure SHALL be consolidated under `documents/` or `openspec/`.
- **Legacy Files:** The root directory SHALL NOT contain legacy implementation files (`.ahk2`, `.ini`) or reference files (`CHORDS.md`).

#### Scenario: Root directory cleanliness
- **WHEN** the project root is inspected
- **THEN** it MUST NOT contain `Mirrored keyboard one hand.ahk2`, `MirrorKeys-Settings-ooki.ini`, or `CHORDS.md`.
