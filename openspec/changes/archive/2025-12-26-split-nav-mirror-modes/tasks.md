# Implementation Tasks

- [x] **Define MirrorMode Variable**
    - [x] Initialize `Global MirrorMode := False` at the top of the script (near `NavMode`).
    - [x] (Optional) Load state from settings if persistence is desired (default to False for now).

- [x] **Add Toggle Logic**
    - [x] Create `ToggleMirrorMode(*)` function.
    - [x] Update `Tray` menu to include "Enable &Mirroring" with a checkmark indicating state.
    - [x] Update `Custom Tray Menu` (GUI) to include a "Mirroring: On/Off" toggle button.

- [x] **Update Hotkey Contexts**
    - [x] Update `#HotIf MirrorStyle == "Standard" && !NavMode` to `#HotIf MirrorStyle == "Standard" && MirrorMode && !NavMode`.
    - [x] Update `#HotIf MirrorStyle == "Overlapping" && !NavMode` to `#HotIf MirrorStyle == "Overlapping" && MirrorMode && !NavMode`.
    - [x] Update `#HotIf MirrorStyle == "Hybrid" && !NavMode` to `#HotIf MirrorStyle == "Hybrid" && MirrorMode && !NavMode`.
    - [x] Update `#HotIf MirrorStyle == "Dvorak" && !NavMode` to `#HotIf MirrorStyle == "Dvorak" && MirrorMode && !NavMode`.

- [x] **Notification**
    - [x] Add `Notify("Mirror Mode: ON/OFF")` to the toggle function.
