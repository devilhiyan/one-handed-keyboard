# Navigation Chords

## 1. Goal
Implement a system of "Chords" (simultaneous key presses) to perform Navigation and Mouse actions without entering a dedicated "Navigation Mode". This allows for seamless text editing and cursor movement.

## 2. Key Mappings

### Standard Chords (Keyboard Actions)
| Keys | Action |
| :--- | :--- |
| `w` + `e` | `Up` |
| `s` + `d` | `Down` |
| `a` + `s` | `Left` |
| `d` + `f` | `Right` |
| `q` + `w` | `Home` |
| `e` + `r` | `End` |

### Mirror Chords (Space + Keys)
| Keys (Held with Space) | Action |
| :--- | :--- |
| `Space` + `w` + `e` | `Mouse Move Up` |
| `Space` + `s` + `d` | `Mouse Move Down` |
| `Space` + `a` + `s` | `Mouse Move Left` |
| `Space` + `d` + `f` | `Mouse Move Right` |
| `Space` + `q` + `w` | `Mouse Wheel Up` |
| `Space` + `e` + `r` | `Mouse Wheel Down` |

## 3. Implementation Details
*   **Mechanism**: Use AutoHotkey's Custom Combinations (`Key1 & Key2::`).
*   **Side Effect**: The first key in a combination (e.g., `w` in `w & e`) becomes a "Prefix Key". It will only send its character upon **release** if no other key was pressed. This introduces slight input latency for standard typing of these keys (`q, w, e, r, a, s, d, f`).
*   **Bidirectional Logic**: Implement both orders (e.g., `w & e` and `e & w`) to ensure the chord works regardless of which key is pressed microseconds earlier.

## 4. Code Structure
```ahk
; --- Navigation Chords ---
; Up / Mouse Up
w & e:: ChordAction("{Up}", "MoveMouse_Up")
e & w:: ChordAction("{Up}", "MoveMouse_Up")

; Down / Mouse Down
s & d:: ChordAction("{Down}", "MoveMouse_Down")
d & s:: ChordAction("{Down}", "MoveMouse_Down")

; ... (rest of mappings)

; Helper Function
ChordAction(KeyAction, MouseAction) {
    if GetKeyState("Space", "P") {
        ; Execute Mouse Action (function call or logic)
        %MouseAction%()
    } else {
        SendEvent KeyAction
    }
}

; Restore Native Function (Prefix Keys)
w::Send "w"
e::Send "e"
s::Send "s"
d::Send "d"
; ... etc
```
