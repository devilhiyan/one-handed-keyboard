## ADDED Requirements

### Requirement: Chord Combinations
The system SHALL support key combinations (chords) that trigger specific actions.
- **Normal Action:** Key combination types a specific keyboard key (e.g., `Up`, `Down`).
- **Mirror Action:** When `Space` is held, the chord triggers a mouse or alternative action.

#### Scenario: Chord repetition
- **WHEN** a chord is held down
- **THEN** it should repeat its action after an initial delay.

#### Scenario: Chord and non-chord key interference
- **WHEN** a chord is being held and a non-chord key is pressed
- **THEN** the non-chord key should be sent normally and the script MUST NOT crash.

### Requirement: Typing Restore
The system SHALL restore normal typing for prefix keys if they are released without triggering a chord.

#### Scenario: Tap prefix key
- **WHEN** a chord key (like `w`) is tapped and released
- **THEN** it should send its remapped Halmak equivalent.
