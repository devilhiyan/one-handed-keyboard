# Keyboard Layout Reference

This document describes the logical layers defined in `kanata.kbd`.

## 1. Halmak Layer (Base)

This is the default layer, optimized for one-handed typing using the Halmak layout principles.

*   **Left Hand Side:** Maps to standard QWERTY keys but outputs Halmak characters.
*   **Chords:** Extensive use of 2-key chords for navigation and editing (see [CHORDS.md](CHORDS.md)).

**Key Behaviors:**
*   `Space`: Taps for `Space`, **Holds** to activate the **Mirror Layer**.
*   `Physical Esc` (Top-Left): Acts as **`Left Windows`** (`@lmet-mod`) in Hyn mode:
    *   **Tap:** Standard Windows Start key (enables `Win + E`, `Win + D`, etc.).
    *   **Hold:** Activates `fn-layer`.
    *   *Note:* Standard physical keyboard on one-handed devices has no dedicated Win key.
*   `Z + X + C + V`: Dedicated home-row **`Escape` (`Esc`)**.
*   `b`: Toggles **NVDA Screen Reader** (runs as Administrator without UAC prompts via bridge key `F7`).
*   `Middle Mouse Click`: Operates in two modes (switchable via `Ctrl + B`):
    *   **Double-Click Mode (Default):** Single middle click is normal middle click (and hold/drag for autoscroll); double-clicking toggles **NVDA Screen Reader**.
    *   **Single-Click Mode:** Single middle click toggles **NVDA Screen Reader**; holding `Space` + middle clicking outputs a **Simple Middle Click**.
*   `Ctrl + B`: Switches between Double-Click Mode and Single-Click Mode in Hyn and Navigation modes.
*   `Tab + Q`: Shows the on-screen **Layout Cheat Sheet** overlay (Hyn mode only):
    *   **Tap (< 300ms):** Pins the cheat sheet open on screen (dismiss by clicking or pressing any key).
    *   **Hold (>= 300ms):** Peeks the cheat sheet; letting go automatically hides it.
*   `L-Ctrl`: Taps for `L-Ctrl`, **Holds** to activate `ctrl-layer` (helper).
*   `L-Ctrl` (Tap-Hold special): Used to toggle **Navigation/Mouse Mode**.

## 2. Mirror Layer

**Activation:** Hold `Space` while in the Halmak layer.

This layer "mirrors" the keyboard, allowing the left hand to type keys normally found on the right side of the keyboard.

| Physical Key (Left) | Mirrored Output (Right) |
| :--- | :--- |
| `q` | `b` |
| `w` | `p` |
| `e` | `w` |
| `r` | `y` |
| `a` | `k` |
| `s` | `j` |
| `d` | `g` |
| `f` | `f` |
| `z` | `c` |
| `x` | `b` |
| `c` | `x` |
| `v` | `z` |
| `b` | `Win + H` (Speech Dictation) |
| `g` | `v` |

*(Note: The exact mapping is defined in the `deflayer mirror` section of `kanata.kbd`)*

### Function Keys (F1 – F12)
Physical function keys `F1` to `F5` on the left hand are mirrored using the **Spacebar**:
*   `F1` – `F5` (Alone): Normal `F1` to `F5`.
*   `Space + F5`: `F6`
*   `Space + F4`: `F7`
*   `Space + F3`: `F8`
*   `Space + F2`: `F9`
*   `Space + F1`: `F10`
*   `Space + Esc + F1`: `F11` (Browser Fullscreen)
*   `Space + F1 + F2`: `F12` (Developer Tools / Save As)

### Navigation & Editing Chords
*   `Z + X + C + V`: **`Escape` (`Esc`)** (Instant home-row Escape)
*   `Z + C`: **`Cut` (`Ctrl + X`)**
*   `Space + Q + W`: **`Page Up`** (Mirror pair of `Home`)
*   `Space + E + R`: **`Page Down`** (Mirror pair of `End`)
*   `Space + A + D`: **`Insert`** (Mirror pair of `Delete`)
*   `Space + A + R`: **`Mute Audio`** (Mirror pair of `Volume Up`)

## 3. Mouse / Navigation Layer

**Activation:** Toggle by tapping `L-Ctrl` (configured as `@lctl-enter-nav`).
**Indication:** A tooltip "Navigation Mode: ON" appears.

This layer has two sub-modes, toggled via **Ctrl + Space**.

### A. Mouse Mode (Default Permanent)
*Focus: Precision pointer control.*

| Key | Action |
| :--- | :--- |
| `w/a/s/d` | Move Mouse Up/Left/Down/Right (Accelerating) |
| `q / e` | Mouse Wheel Up / Down |
| `Capslock` | Left Click (Hold to Drag) |
| `Shift` | Right Click |
| `Space + Capslock` | Enter |
| `Middle Click` | Normal Middle Click (Default) / Toggle NVDA (Mode 2) |
| `Double Mid-Click` | Toggle NVDA Screen Reader (Double-Click Mode Default) |
| `Space + Mid-Click` | Simple Middle Click (in Single-Click Mode) |
| `Ctrl + B` | Switch Middle Click Mode (Double vs Single NVDA) |

### B. Keyboard Mode (Transient)
*Focus: Rapid text navigation.*

| Key | Action |
| :--- | :--- |
| `w/a/s/d` | Arrow Keys Up/Left/Down/Right |
| `q + w` | Home |
| `w + e` | End |
| `Capslock` | Enter |
| `Space + Capslock` | Left Click (Hold to Drag) |
| `Shift` | Shift |
| `Space + Shift` | Right Click |
| `Middle Click` | Normal Middle Click (Default) / Toggle NVDA (Mode 2) |
| `Double Mid-Click` | Toggle NVDA Screen Reader (Double-Click Mode Default) |
| `Space + Mid-Click` | Simple Middle Click (in Single-Click Mode) |
| `Ctrl + B` | Switch Middle Click Mode (Double vs Single NVDA) |

**Exiting:** Tap `L-Ctrl` again to return to Halmak layer.

## 4. QWERTY Layer

**Activation:** Toggle via the `fn-layer` (Hold `L-Win` + press toggle key).

A standard passthrough layer for gaming or when others use the keyboard.
*   **Middle Click:** Operates strictly as a normal Windows middle mouse button.
*   **Ctrl + B:** Operates as standard `Ctrl + B` (e.g. bold text in editors).

## 5. Layout Cheat Sheet Overlay

*   **Trigger:** Press physical `Tab + Q` together in **Hyn mode** (sends bridge key `F9`).
*   **Restriction:** Exclusively accessible in Hyn mode (disabled in Mouse and QWERTY modes).
*   **Multi-Monitor Support:** Automatically detects the active monitor (under the mouse cursor or focused window) and scales to fit the work area like a maximized window.
*   **Mouse Wheel Zoom:** Scroll the mouse wheel (`WheelUp` / `WheelDown`) to zoom in or out (up to 6.0x) directly anchored at the current mouse cursor location.
*   **Middle-Mouse Drag Panning:** Hold and drag the **Middle Mouse Button** (`MButton`) to pan across the magnified sheet with boundary clamping.
*   **Instant Dismissal:** Pressing either **Left-Click**, **Right-Click**, or **ANY keyboard key** (as well as `Tab + Q` or `Escape`) closes the cheat sheet immediately.
*   **Assets:** Generated from [kanata/generate_cheatsheet.py](../generate_cheatsheet.py) to [kanata/layout_cheatsheet.png](../layout_cheatsheet.png) (3200x2040 Super-Resolution) and [kanata/layout_cheatsheet.pdf](../layout_cheatsheet.pdf) (vector-rasterized PDF for offline reading/printing).
