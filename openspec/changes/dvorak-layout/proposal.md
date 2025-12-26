# Dvorak Layout & Mirroring

## 1. Problem
The previous implementation assumed the user had their OS layout set to Dvorak. The new requirement is to make the "Dvorak" Mirror Style act as a complete **Dvorak Emulator** for users with a Physical QWERTY keyboard and QWERTY OS setting.

When `MirrorStyle == "Dvorak"`:
1.  Normal typing should output Dvorak characters.
2.  Mirror typing (`Space` + Key) should output the mirrored Dvorak character.

## 2. Proposed Solution
Modify the `#HotIf MirrorStyle == "Dvorak" && !NavMode` block to include mappings for ALL standard keys.

### Logic Table (Physical QWERTY Input)

| Physical Key | Dvorak Output (Normal) | Mirror Target (Dvorak) | Mirror Output |
| :--- | :--- | :--- | :--- |
| **Row 1** | | | |
| `-` | `[` | `]` (Right Top Ext 2) | `=` |
| `=` | `]` | `[` (Right Top Ext 1) | `[`? No. `[` mirrors to `]`. Wait. |

**Mirroring Logic Review (Dvorak Geometry):**
*   **Numbers**: `1-5` <-> `6-0`. `[` <-> `]`.
    *   Left `[` (Physical `-`) mirrors to Right `]` (Physical `=`).
    *   Right `]` (Physical `=`) mirrors to Left `[` (Physical `-`).
*   **Top Row**: `' , . P Y` <-> `F G C R L`. `/` <-> `?`
    *   `'` (Phys `Q`) <-> `L` (Phys `P`)
    *   `,` (Phys `W`) <-> `R` (Phys `O`?) No.
    *   Let's trace Physical to Dvorak to Mirror.

| Phys Key | Dvorak Char | Dvorak Hand/Pos | Mirror Dvorak Char | Output |
| :--- | :--- | :--- | :--- | :--- |
| **Row 2** | | | | |
| `q` | `'` | L Pinky | `l` | `l` |
| `w` | `,` | L Ring | `r` | `r` |
| `e` | `.` | L Mid | `c` | `c` |
| `r` | `p` | L Index | `g` | `g` |
| `t` | `y` | L Index Ext | `f` | `f` |
| `y` | `f` | R Index Ext | `y` | `y` |
| `u` | `g` | R Index | `p` | `p` |
| `i` | `c` | R Mid | `.` | `.` |
| `o` | `r` | R Ring | `,` | `,` |
| `p` | `l` | R Pinky | `'` | `'` |
| `[` | `/` | R Ext 1 | `[` (Num Row?) | `[` ? No. |
| `]` | `=` | R Ext 2 | `]` | `]` ? |

**Wait**, Mirroring `/` and `=`.
Dvorak `/` (Phys `[`) is Right Top Ext.
Mirror is Left Top Ext?
Left Top Ext is `?` No. Dvorak Left Top Ext is... nothing?
Dvorak Row 1: `... 9 0 [ ]`.
Dvorak Row 2: `' , ...`. (Starts at Pinky).
So `/` (Phys `[`) mirrors to... `Tab` (or Backspace)?
In previous Standard logic: `[` mirrors to `Tab`.
So `Space & [` -> `Tab` (or Backspace).

| Phys Key | Dvorak Char | Mirror Output |
| :--- | :--- | :--- |
| **Row 3** | | |
| `a` | `a` | `s` |
| `s` | `o` | `n` |
| `d` | `e` | `t` |
| `f` | `u` | `h` |
| `g` | `i` | `d` |
| `h` | `d` | `i` |
| `j` | `h` | `u` |
| `k` | `t` | `e` |
| `l` | `n` | `o` |
| `;` | `s` | `a` |
| `'` | `-` | `Enter` (Mirror of Capslock) |

| Phys Key | Dvorak Char | Mirror Output |
| :--- | :--- | :--- |
| **Row 4** | | |
| `z` | `;` | `z` |
| `x` | `q` | `v` |
| `c` | `j` | `w` |
| `v` | `k` | `m` |
| `b` | `x` | `b` |
| `n` | `b` | `x` |
| `m` | `m` | `k` |
| `,` | `w` | `j` |
| `.` | `v` | `q` |
| `/` | `z` | `;` |

## 3. Implementation Code Structure

```ahk
#HotIf MirrorStyle == "Dvorak" && !NavMode

; --- ROW 1 (Numbers) ---
; Normal
-::[
=::]
; Mirror
Space & -::]
Space & =::[
Space & 1::0 ...

; --- ROW 2 (Top) ---
; Normal
q::'
w::,
e::.
r::p
t::y
y::f
u::g
i::c
o::r
p::l
[::/
]::=
; Mirror
Space & q::l
Space & w::r
Space & e::c
Space & r::g
Space & t::f
Space & y::y
Space & u::p
Space & i::.
Space & o::,
Space & p::'
Space & [::Backspace ; (Mirror of Tab/Backsp)
Space & ]::Backspace

; ... etc for other rows
```