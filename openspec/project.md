# Project Context

## Purpose
**Mirror Keys** is an accessibility tool designed to facilitate one-handed typing on a standard QWERTY keyboard. It functions by mirroring the keyboard layout when the **Spacebar** is held down, allowing users to access keys on the opposite side of the keyboard without moving their hand. It aims to improve typing efficiency and comfort for one-handed users.

## Tech Stack
- **Language**: AutoHotkey v2 (AHK v2)
- **Platform**: Windows (Win32)

## Project Conventions

### Code Style
- **Directives**: Use `#Requires Autohotkey v2.0+`, `#SingleInstance Force`, and `#UseHook` at the beginning of the script.
- **Naming**: PascalCase for functions (`MirrorSend`, `Keyboard_Display`), camelCase or snake_case for variables (`map_x`, `hover_state`).
- **Indentation**: Tab-based indentation is preferred, or consistent 4-space indentation.
- **Hotkeys**: Use `#HotIf` for context-sensitive hotkeys (e.g., checking `MirrorStyle` or `NavMode`).
- **Global Variables**: Used for settings and state management (`NavMode`, `MirrorStyle`, `KeyboardWindow`).

### Architecture Patterns
- **Event-Driven**: The core logic is driven by keyboard events (hotkeys) and GUI events.
- **State Management**: Global variables track the current state (Navigation Mode, Mirror Style). Settings are persisted to a local `.ini` file (`MirrorKeys-Settings-<Username>.ini`) using wrapper functions `StreamRead` and `StreamWrite`.
- **Modes**:
    - **Mirror Mode**: The default mode where Spacebar acts as a modifier to mirror keys. Supports 'Standard', 'Overlapping', and 'Hybrid' styles.
    - **Navigation Mode**: Toggled via a key (default LWin or Ctrl), allowing keyboard keys to simulate mouse movement and clicks.
- **GUI**: A built-in GUI displays the keyboard mapping, created using AHK's `Gui` object and GDI+ for images.

### Testing Strategy
- **Manual Testing**: Primary method. Verify each hotkey combination in different modes (Standard, Overlapping, Hybrid).
- **Functional Testing**: Ensure GUI opens/closes correctly, settings are saved/loaded, and interaction with the system tray works.

### Git Workflow
- **Branching**: Feature branches (e.g., `feature/new-layout`) merged into `main`.
- **Commits**: Clear, descriptive commit messages.

## Domain Context
- **Accessibility**: The project specifically targets users who need to type with one hand due to disability, injury, or situational preference.
- **Keyboard Remapping**: Deep understanding of scan codes, virtual key codes, and modifier keys in Windows is essential.
- **Input Interception**: The script uses keyboard hooks to intercept and modify input before it reaches the active application.

## Important Constraints
- **Admin Rights**: May be required to interact with high-privileged applications (e.g., Task Manager, some games). The script includes a self-elevation block.
- **Keyboard Hook**: Must use `InstallKeybdHook` to ensure reliability.
- **Single Instance**: Only one instance of the script should run at a time (`#SingleInstance Force`).

## External Dependencies
- **AutoHotkey v2**: The runtime environment required to execute the `.ahk2` script.
- **Windows API**: implicitly used via AHK for window management, input injection, and system tray interaction.