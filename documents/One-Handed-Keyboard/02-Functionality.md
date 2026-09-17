# One-Handed Keyboard Specifications

## Description
A sophisticated one-handed typing system enabling full keyboard access using only the left hand (conceptually) via a "Mirror" layer triggered by the Spacebar. It utilizes **Kanata** for input interception and **AutoHotkey** for mouse emulation and visual feedback.

## Functionality Flow

### 1. Dual-Layer Architecture
The system operates as a pipeline:
1.  **Physical Input** -> **Kanata** (Interception Driver)
2.  **Kanata Logic**:
    *   Handles Chords (simultaneous key presses).
    *   Handles Layers (Halmak, Mirror, Mouse).
    *   **Output**: Either standard keys OR "Bridge Keys" (F13-F24).
3.  **Bridge Protocol** -> **AutoHotkey**:
    *   AHK listens for F13-F24.
    *   **Action**: Performs mouse movement, clicking, or UI notifications.

## Key Mappings & Chords

### 1. Halmak Layer (Default)
This is the primary typing layer. Physical keys correspond to the **Halmak** layout to minimize travel distance.

#### Single Key Mapping (Physical -> Output)
| Physical Key | Output (Halmak) | Physical Key | Output (Halmak) |
| :--- | :--- | :--- | :--- |
| **Q** | `c` | **A** | `a` |
| **W** | `s` | **S** | `e` |
| **E** | `t` | **D** | `i` |
| **R** | `h` | **F** | `o` |
| **T** | `r` | **G** | `u` |
| **Z** | `l` | **X** | `d` |
| **C** | `n` | **V** | `m` |
| **B** | `Toggle NVDA (Admin)` | | |

#### Chords (Mult-Key Combos)
| Chord (Physical) | Action / Output | Note |
| :--- | :--- | :--- |
| **W + E** | `Up` | |
| **S + D** | `Down` | |
| **A + S** | `Left` | |
| **D + F** | `Right` | |
| **Q + W** | `Home` | |
| **E + R** | `End` | |
| **S + F** | `Backspace` | |
| **A + D** | `Delete` | |
| **S + D + F** | `Ctrl + Backspace` | |
| **A + F** | `Ctrl + C` | Copy |
| **X + C** | `Ctrl + J` | |
| **Z + X** | `Ctrl + Z` | Undo (Left Hand) |
| **L + D** | `Ctrl + Z` | Undo (Right Hand equivalent) |
| **C + V** | `Ctrl + Y` | Redo (Left Hand) |
| **N + M** | `Ctrl + Y` | Redo (Right Hand equivalent) |
| **Z + X + C + V**| `F10` | |
| **A + R** | `Volume Up` | |
| **Q + F** | `Volume Down` | |
| **G + T** | `Play/Pause` | |
| **Q + T** | `PrintScreen` | |
| **G + E** | `Right Arrow` | Media Seek Forward (5s) |
| **G + W** | `Left Arrow` | Media Seek Rewind (5s) |
| **A + T** | `Brightness Up` | |
| **Q + G** | `Brightness Down` | |
| **Tab + Q** | `Layout Cheat Sheet` | Hyn mode only (F9 bridge) |

#### Punctuation Chords
| Chord (Physical) | Output | Chord (Physical) | Output |
| :--- | :--- | :--- | :--- |
| **S + E** | `/` | **G + R** | `?` |
| **W + E + R** | `.` | **E + T** | `>` |
| **R + W** | `,` | **Q + E** | `<` |
| **F + E** | `;` | **F + E** | `;` |
| **W + T** | `[` | **Q + R** | `{` |
| **A + W** | `"` | **A + G** | `@` |
| **S + E + F** | `=` | **S + G** | `(` |
| **F + G** | `_` | | |

---

### 2. Mirror Layer (Hold Spacebar)
Activates when `Space` is held. Maps keys to the opposite side of the keyboard.

#### Single Key Mapping
| Physical Key | Output (Mirrored) | Original Position |
| :--- | :--- | :--- |
| **Q** | `z` | Bottom Left -> Bottom Left |
| **W** | `b` | Top Left -> Bottom Middle |
| **E** | `p` | Top Middle -> Top Right |
| **R** | `y` | Top Right -> Top Right |
| **T** | `x` | Top Right -> Bottom Left |
| **A** | `q` | Home Left -> Top Left |
| **S** | `g` | Home Left -> Home Middle |
| **D** | `w` | Home Middle -> Top Left |
| **F** | `f` | Home Right -> Home Left |
| **G** | `v` | Home Right -> Bottom Middle |
| **Z** | `c` | Bottom Left -> Bottom Middle |
| **X** | `b` | Bottom Middle -> Bottom Left |
| **C** | `k` | Bottom Right -> Home Right |
| **V** | `j` | Bottom Right -> Home Right |
| **B** | `Win + H` | Windows Voice Typing / Dictation |
| **1 .. 0** | Replaces number row in reverse order (0 = 1, 9 = 2...) |

#### Mirror Chords
| Chord (Physical) | Action / Output |
| :--- | :--- |
| **S + D + F** | `Ctrl + Alt + Backspace` |
| **A + F** | `Ctrl + V` (Paste) |
| **Z + X** | `Ctrl + Alt + Z` |

#### Mirror Punctuation
| Chord | Output | Chord | Output |
| :--- | :--- | :--- | :--- |
| **S + E** | `\` | **G + R** | `|` |
| **W + T** | `]` | **Q + R** | `}` |
| **F + E** | `:` | **S + G** | `)` |
| **A + W** | `'` | **S + E + F** | `+` |
| **F + G** | `-` | **A + G** | `@` |

---

### 3. Navigation / Mouse Mode
**Toggle:** `Left Control` (Tap)
**Bridge:** Sends F-Keys to AutoHotkey for execution.

| Physical Key | Mouse Mode Action | Keyboard Mode Action | Bridge Key |
| :--- | :--- | :--- | :--- |
| **W** | Move Up | Arrow Up | F13 |
| **A** | Move Left | Arrow Left | F14 |
| **S** | Move Down | Arrow Down | F15 |
| **D** | Move Right | Arrow Right | F16 |
| **Q** | Scroll Up | (Unmapped) | F19 |
| **E** | Scroll Down | (Unmapped) | F20 |
| **Capslock** | Left Click | Enter | F17 |
| **Space+Caps** | Enter | Left Click | F11 |
| **Shift** | Right Click | Shift | F18 |
| **Space+Shift**| Right Click | Right Click | F12 |
| **Q + W** | `Home` | `Home` | F21 |
| **W + E** | `End` | `End` | F22 |

---

### 4. Technical Protocol (Bridge)
| Key | Action |
| :--- | :--- |
| **F7** | Toggle NVDA Screen Reader (Admin, Hyn mode only) |
| **F8** | Switch to QWERTY |
| **F9** | Toggle Layout Cheat Sheet (Hyn mode only) |
| **F23** | Switch to Halmak (Nav OFF) / `Ctrl+Shift+F23`: **Brightness Up** |
| **F24** | Switch to Navigation Mode (Nav ON) / `Ctrl+Shift+F24`: **Brightness Down** |

### 5. Control Layer & Shortcuts
Holding `Left Control` activates a temporary layer with special functions:
*   **Tap LCtrl**: Toggles Mouse Mode.
*   **Ctrl + Space (Tap)**: Toggles Mouse Mode.
*   **Ctrl + Space (Hold)**: Activates **Mirror Layer**.
    *   *Usage*: Allows `Ctrl` + `Space` + `Key` chords.
    *   *Example*: `Ctrl` + `Space` + `D` (Physical) -> `Ctrl` + `W` (Output).

---

### 6. Layout Cheat Sheet Overlay
*   **Activation:** Press physical `Tab + Q` together while in **Hyn mode** (Kanata sends bridge key `F9`).
*   **Active Monitor Fit:** Automatically detects which screen has active focus or the mouse cursor, and fits the cheat sheet to that monitor's work area like a maximized window.
*   **Mouse Wheel Zooming:** Scroll wheel up or down (`WheelUp` / `WheelDown`) to zoom smoothly at the mouse cursor location (1.0x to 6.0x).
*   **Middle-Mouse Drag Panning:** Click and drag with the **Middle Mouse Button** (`MButton`) to pan around smoothly when zoomed in, with boundary clamping.
*   **Instant Close:** Left-click, right-click, or pressing ANY keyboard key immediately closes the overlay.
*   **Super-Resolution & PDF Assets:** Generated at 3200x2040 Ultra-HD resolution (`layout_cheatsheet.png`) for razor-sharp zoom, alongside a vector-rasterized PDF (`layout_cheatsheet.pdf`) for offline reading and printing.


