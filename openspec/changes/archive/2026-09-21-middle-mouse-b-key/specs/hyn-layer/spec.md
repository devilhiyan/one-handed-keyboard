## ADDED Requirements
### Requirement: Middle Mouse Click B-Mode
The system SHALL support using the Middle Mouse Button as the B key in HYN mode and Navigation mode, enabled by default.

#### Scenario: User clicks middle mouse in HYN mode
- **WHEN** the system is in HYN mode and Middle Click B-Mode is enabled
- **AND** the user clicks the Middle Mouse Button
- **THEN** the system toggles the NVDA screen reader.

#### Scenario: User clicks middle mouse with Space held
- **WHEN** the system is in HYN or Navigation mode and Middle Click B-Mode is enabled
- **AND** the user holds the Space key and clicks the Middle Mouse Button
- **THEN** the system sends the Windows Voice Typing shortcut (`Win + H`).

#### Scenario: User toggles Middle Click B-Mode with Ctrl + B
- **WHEN** the user presses `Ctrl + B` in HYN or Navigation mode
- **THEN** the system toggles Middle Click B-Mode between enabled and disabled
- **AND** displays an informative tooltip and plays an audio confirmation beep.

#### Scenario: Normal middle click in QWERTY mode or when disabled
- **WHEN** the system is in QWERTY mode or Middle Click B-Mode is disabled
- **AND** the user clicks the Middle Mouse Button
- **THEN** the system outputs standard Windows middle click.
