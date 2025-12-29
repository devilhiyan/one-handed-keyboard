# Specification: Kanata-AHK Bridge Documentation

## File: `kanata/ARCHITECTURE.md`

Create a new file with the following sections:

### 1. Overview
High-level description of the hybrid architecture.
- **Kanata**: The Hardware Abstraction Layer (HAL). It sits at the driver level (Interception), normalizing physical inputs.
- **AutoHotkey**: The Logic Layer. It receives "signals" from Kanata and executes complex behaviors (mouse acceleration curves, GUI tooltips).

### 2. The Bridge Protocol (Virtual Wires)
Document the mapping interface.

| Physical Action | Kanata Layer | Output (Virtual Key) | AHK Action |
| :--- | :--- | :--- | :--- |
| **Mouse Move** | `mouse` | `F13` - `F16` | Triggers `ProcessMovement` timer (accel math) |
| **Mouse Click** | `mouse` | `F17`, `F18` | `Click Down`/`Up` passthrough |
| **Mouse Scroll** | `mouse` | `F19`, `F20` | Loop `Click Wheel` |
| **Nav Toggle** | `halmak` | `F24` | Toggles Tooltip/State in AHK |

### 3. Mouse Logic
Explain why AHK is used for mouse:
- Kanata's mouse keys are static or have simple curves.
- AHK allows for custom `Ease-Out` acceleration math: `Speed += (Max - Current) * Factor`.
- Timer-based polling prevents key-repeat stuttering.

### 4. Lifecycle Management
Explain `start_kanata.ps1`:
1.  Starts AHK (Hidden).
2.  Starts Kanata (Blocking).
3.  `finally` block ensures AHK is killed when Kanata terminates.

## File: `kanata/docs/LAYOUT.md`

Create a comprehensive layout reference:
- **Halmak Layer**: Visual or tabular representation of the base one-handed layout.
- **Mirror Layer**: The reflected keys when Space is held.
- **Mouse Layer**: The navigation keys (ESDF/WASD style) and F-key mappings.
- **Modifiers**: Explain Space-hold, Ctrl-hold behavior.

## File: `kanata/docs/CHORDS.md`

Create/Update this file to reflect `kanata.kbd` exactly:
- `w`+`e` -> Up
- `s`+`d` -> Down
- `a`+`s` -> Left
- `d`+`f` -> Right
- `q`+`w` -> Home
- `e`+`r` -> End
- `a`+`d` -> Backspace
- `s`+`f` -> Delete
- Document the "Single Key Fallbacks" logic (e.g., `(q) c`) which handles overlap between chord timers and single presses.

## File: `kanata/docs/ARCHITECTURE.md`

Create the architecture documentation as described above (Bridge Protocol, Mouse Logic).

## File: `kanata/README.md`

- Add a "Documentation" section linking to the files in `docs/`.
