# Specification: Spacebar State Synchronization

## MODIFIED Requirements

### Requirement: Immediate Spacebar Recovery
The system MUST allow the spacebar to function as a normal spacebar on the first tap following a layer-switched interaction.

#### Scenario: Tap After Layer Switch
- **GIVEN** the spacebar was used as a modifier (e.g., Space + E)
- **WHEN** the spacebar is released
- **AND** the spacebar is pressed and released again (Tap)
- **THEN** the Tap MUST output a space character immediately.

### Requirement: Logical Modifier Tracking
Functions that check for the spacebar modifier MUST use the internal `KeyTracker` state to prevent race conditions with physical key states.

#### Scenario: Modifier Trigger
- **WHEN** a key is pressed (e.g., E)
- **IF** `KeyTracker[0x20]` is `1` (Down)
- **THEN** `MirrorActionOccurred` MUST be set to `True`
- **AND** the mirrored key (e.g., W) MUST be sent.
