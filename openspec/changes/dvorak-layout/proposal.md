# Dvorak Mirroring Mode

## 1. Problem
The current `Mirror Keys` implementation supports "Standard" (QWERTY symmetric), "Overlapping" (QWERTY shifted), and "Hybrid" styles. Users who use the **Dvorak** keyboard layout (either via OS settings or preference) cannot effectively use the mirroring feature because the mirrored keys are calculated based on QWERTY geometry.

For a Dvorak user:
*   Left Home Row (`A O E U I`) should mirror to Right Home Row (`D H T N S`).
*   Current "Standard" mirroring maps `A` -> `;`, `S` -> `L`, which is incorrect for Dvorak geometry.

## 2. Proposed Solution
Add a new **Mirror Style** option: **"Dvorak"**.

When this style is active (`MirrorStyle == "Dvorak"`):
*   The script will map `Space` + [Left Dvorak Key] to [Right Dvorak Key] (and vice versa).
*   This allows a user typing with the Dvorak layout to access the other half of the keyboard symmetrically.

### Key Mapping (Dvorak)

| Hand | Row | Input (Space +) | Output |
| :--- | :--- | :--- | :--- |
| **Left** | **Top** | `'` | `l` |
| | | `,` | `r` |
| | | `.` | `c` |
| | | `p` | `g` |
| | | `y` | `f` |
| | **Home** | `a` | `s` |
| | | `o` | `n` |
| | | `e` | `t` |
| | | `u` | `h` |
| | | `i` | `d` |
| | **Bottom** | `;` | `z` |
| | | `q` | `v` |
| | | `j` | `w` |
| | | `k` | `m` |
| | | `x` | `b` |
| | | | |
| **Right** | **Top** | `f` | `y` |
| | | `g` | `p` |
| | | `c` | `.` |
| | | `r` | `,` |
| | | `l` | `'` |
| | **Home** | `d` | `i` |
| | | `h` | `u` |
| | | `t` | `e` |
| | | `n` | `o` |
| | | `s` | `a` |
| | **Bottom** | `b` | `x` |
| | | `m` | `k` |
| | | `w` | `j` |
| | | `v` | `q` |
| | | `z` | `;` |

*Note: Function keys (F1-F12) and Numbers (1-0) generally remain standard or follow the existing QWERTY mirroring pattern as Dvorak keeps the number row standard.*

## 3. Implementation Details
1.  **Update `ToggleMirrorStyle` function**: Add "Dvorak" to the rotation cycle.
2.  **Add Hotkey Block**: Create a new `#HotIf MirrorStyle == "Dvorak" && !NavMode` block containing the mappings above.
3.  **UI Updates**: Ensure the System Tray menu reflects the "Dvorak" style name.

## 4. Dependencies / Conflicts
*   **Navigation Mode**: Navigation keys are currently defined by characters (`e`, `s`, `d`, `f`). If a user is on Dvorak, these keys are physically scattered.
    *   *Decision*: For this proposal, we focus **only** on the Mirroring aspect. Navigation mode might be awkward for Dvorak users unless they switch to "Old" (WASD) style (which is physically `,aoe` on Dvorak - clustered on left hand) or we implement a ScanCode-based Nav mode in a future update.

## 5. Why
To make the application accessible to one-handed users who type using the Dvorak layout.
