# Hyn Layer Specification

## Purpose
Defines key mappings, behaviors, and special function triggers for the one-handed Hyn layer.
## Requirements
### Requirement: Dictation Shortcut (Windows + H)
The base Hyn layer SHALL map the physical B key to the Windows Dictation shortcut.

#### Scenario: User presses B
- **WHEN** the user is in the Hyn layer and presses the physical B key
- **THEN** the system outputs `Windows + H` (`lmet + h`)
- **AND** it does not output the character `b`.

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

### Requirement: Insert Key Chord
The system SHALL map the chord combination of `Tab` and `` ` `` (`grv`) in the HYN layer to the `Insert` key.

#### Scenario: User presses Tab and Grave simultaneously
- **WHEN** the system is in HYN layer
- **AND** the user presses the `Tab` and `` ` `` keys within the chord timeout window
- **THEN** the system outputs the `Insert` (`ins`) key.

#### Scenario: User taps Grave key alone
- **WHEN** the user taps the `` ` `` key without another chord key
- **THEN** the system outputs the `` ` `` character.

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

### Requirement: Global Sticky Modifiers Mode and Overlapping Chains
The system SHALL support a toggleable Global Sticky Modifiers Mode for modifiers (`Ctrl`, `Alt`, `Shift`, `Win`, and `Insert`), with Space acting strictly as a real-time mirror selector that attaches to letters rather than the modifier, and multi-key combinations supported via overlapping key hand-off.

#### Scenario: User toggles Sticky Modifiers Mode via Ctrl + Space + X
- **WHEN** the system is in HYN layer
- **AND** the user holds `Ctrl` and `Space` and presses physical `X`
- **THEN** the system toggles the `StickyHoldEnabled` setting
- **AND** plays audio chime confirmation and updates the system tray checkmark state.

#### Scenario: User types multi-key sequence with Space mirror hand-off
- **WHEN** Sticky Modifiers Mode is enabled and a modifier (e.g. `Ctrl`) is tapped
- **AND** the user presses keys while maintaining at least one key pressed at all times
- **THEN** keys pressed while `Space` is held are output as mirrored keys
- **AND** keys pressed while `Space` is released are output as unmirrored keys
- **AND** once all keys are released, the chain completes and the sticky modifier auto-releases.


