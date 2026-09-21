## MODIFIED Requirements
### Requirement: Middle Mouse Click B-Mode
The system SHALL support two middle mouse button modes in HYN mode and Navigation mode, switchable via `Ctrl + B`:
1. **Double-Click Mode (Default)**: Normal middle click on single click; double-click toggles NVDA.
2. **Single-Click Mode**: Single click toggles NVDA; Space + click sends normal middle click.

#### Scenario: User clicks middle mouse in Double-Click mode
- **WHEN** the system is in HYN or Navigation mode and Double-Click mode is active
- **AND** the user single-clicks the Middle Mouse Button
- **THEN** the system outputs a standard Windows middle click.

#### Scenario: User double-clicks middle mouse in Double-Click mode
- **WHEN** the system is in HYN or Navigation mode and Double-Click mode is active
- **AND** the user double-clicks the Middle Mouse Button
- **THEN** the system toggles the NVDA screen reader without sending middle clicks to the active application.

#### Scenario: User clicks middle mouse in Single-Click mode
- **WHEN** the system is in HYN or Navigation mode and Single-Click mode is active
- **AND** the user single-clicks the Middle Mouse Button
- **THEN** the system toggles the NVDA screen reader.

#### Scenario: User clicks middle mouse with Space held in Single-Click mode
- **WHEN** the system is in HYN or Navigation mode and Single-Click mode is active
- **AND** the user holds Space and clicks the Middle Mouse Button
- **THEN** the system sends a standard middle mouse click.

#### Scenario: User switches middle click mode with Ctrl + B
- **WHEN** the user presses `Ctrl + B` in HYN or Navigation mode
- **THEN** the system toggles between Double-Click mode and Single-Click mode
- **AND** displays an informative tooltip and plays audio confirmation chimes.
