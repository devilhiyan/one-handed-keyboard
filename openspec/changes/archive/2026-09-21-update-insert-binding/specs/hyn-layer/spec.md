## ADDED Requirements

### Requirement: Insert Key Chord
The system SHALL map the chord combination of `Tab` and `` ` `` (`grv`) in the HYN layer to the `Insert` key.

#### Scenario: User presses Tab and Grave simultaneously
- **WHEN** the system is in HYN layer
- **AND** the user presses the `Tab` and `` ` `` keys within the chord timeout window
- **THEN** the system outputs the `Insert` (`ins`) key.

#### Scenario: User taps Grave key alone
- **WHEN** the user taps the `` ` `` key without another chord key
- **THEN** the system outputs the `` ` `` character.
