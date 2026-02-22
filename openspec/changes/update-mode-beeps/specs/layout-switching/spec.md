## MODIFIED Requirements
### Requirement: Mode Cycling
The system SHALL allow the user to cycle through all available keyboard input modes using a single modifier key tap, and SHALL provide distinct auditory feedback for each mode.

#### Scenario: Cycle through modes using Ctrl with audio feedback
- **WHEN** the user taps the `Ctrl` key in Halmak mode
- **THEN** the system switches to Navigation (Mouse) mode AND plays 2 distinct beeps at a high pitch (e.g., 1200Hz).
- **WHEN** the user taps the `Ctrl` key in Navigation mode
- **THEN** the system switches to QWERTY mode, displays the QWERTY notification, AND plays 3 distinct beeps at a low pitch (e.g., 400Hz).
- **WHEN** the user taps the `Ctrl` key in QWERTY mode
- **THEN** the system returns to Halmak mode AND plays 1 distinct beep at a medium pitch (e.g., 750Hz).
