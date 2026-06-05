# Hyn Layer Specification

## ADDED Requirements
### Requirement: Dictation Shortcut (Windows + H)
The base Hyn layer SHALL map the physical B key to the Windows Dictation shortcut.

#### Scenario: User presses B
- **WHEN** the user is in the Hyn layer and presses the physical B key
- **THEN** the system outputs `Windows + H` (`lmet + h`)
- **AND** it does not output the character `b`.
