## MODIFIED Requirements
### Requirement: Mode Cycling
The system SHALL allow the user to cycle through all available keyboard input modes using a single modifier key tap, and SHALL provide distinct auditory feedback for each mode.

#### Scenario: Cycle through modes using Ctrl with audio feedback
- **WHEN** the user taps the `Ctrl` key in Halmak mode
- **THEN** the system switches to Navigation (Mouse) mode AND plays a distinct sound assigned to Navigation mode.
- **WHEN** the user taps the `Ctrl` key in Navigation mode
- **THEN** the system switches to QWERTY mode, displays the QWERTY notification, AND plays a distinct sound assigned to QWERTY mode.
- **WHEN** the user taps the `Ctrl` key in QWERTY mode
- **THEN** the system returns to Halmak mode AND plays a distinct sound assigned to Halmak mode.
