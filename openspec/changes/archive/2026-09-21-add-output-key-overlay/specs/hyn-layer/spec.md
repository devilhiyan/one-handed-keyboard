## ADDED Requirements

### Requirement: Key Output Overlay HUD
The system SHALL provide a configurable live Key Output Overlay positioned near the Windows system tray that displays the final output keys sent to the OS.

#### Scenario: User toggles overlay via Space + X
- **WHEN** the system is in HYN layer
- **AND** the user holds `Space` and presses physical `X`
- **THEN** the system toggles the `ShowOutputKeys` setting
- **AND** plays audio chime confirmation
- **AND** updates the system tray checkmark state.

#### Scenario: User types while overlay is enabled
- **WHEN** `ShowOutputKeys` is enabled
- **AND** an output key combination (such as `Insert`, `Up`, or `Ctrl + C`) is sent to Windows
- **THEN** the overlay displays the formatted key name without stealing focus
- **AND** auto-hides after 2.5 seconds of typing inactivity.
