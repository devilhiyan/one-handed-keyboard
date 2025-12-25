# Navigation Workflow Plan

## 1. Goal
Upgrade the "Navigation Mode" workflow to align the "Transient" and "Permanent" behaviors. The roles of the keys vs. Spacebar combinations will simply flip between the two modes.

## 2. Current State (Analysis)
*   **Permanent Mode** (`MouseMode = On`):
    *   **Direct Key Press (e.g., E/S/D/F):** Moves the Mouse Cursor.
    *   **Space + Key:** Sends Arrow Keys / Navigation (Up/Left/Down/Right).
*   **Transient Mode** (`MouseMode = Off`):
    *   **Direct Key Press:** Moves the Mouse Cursor.
    *   **Space Press:** Acts as Left Click (Hold to Drag).

## 3. Proposed New State

The concept is a symmetric "Flip" of roles.

### A. Permanent Mode (Mouse-First)
*Focus: Controlling the pointer.*
*   **Default Behavior (No Space):** Mouse Actions (Move, Click, Scroll).
*   **Modified Behavior (Space + Key):** Keyboard Actions (Arrows, Enter, Home/End).

### B. Transient Mode (Keyboard-First)
*Focus: Text Navigation.*
*   **Default Behavior (No Space):** Keyboard Actions (Arrows, Enter, Home/End).
*   **Modified Behavior (Space + Key):** Mouse Actions (Move, Click, Scroll).

## 4. Detailed Key Mapping (New Style - ESDF Example)

| Key | **Permanent Mode** (Mouse-First) | **Transient Mode** (Keyboard-First) |
| :--- | :--- | :--- |
| **E** | Mouse Up | Arrow Up |
| **S** | Mouse Left | Arrow Left |
| **D** | Mouse Down | Arrow Down |
| **F** | Mouse Right | Arrow Right |
| **Space + E** | Arrow Up | Mouse Up |
| **Space + S** | Arrow Left | Mouse Left |
| **Space + D** | Arrow Down | Mouse Down |
| **Space + F** | Arrow Right | Mouse Right |
| | | |
| **W** | Wheel Up | Home |
| **R** | Wheel Down | End |
| **Space + W** | Home | Wheel Up |
| **Space + R** | End | Wheel Down |
| | | |
| **Capslock** | Left Click (Hold to Drag) | Enter |
| **Space + Capslock** | Enter | Left Click (Hold to Drag) |
| | | |
| **Shift** (LShift/RShift) | Right Click | Space Key |
| **Space + Shift** | Space Key | Right Click |

## 5. Implementation Details
1.  **Code Structure**: The `#HotIf` blocks need to be reorganized.
    *   Block 1: `NavMode && MouseMode` (Permanent) -> Defines Mouse Actions direct, Keyboard actions via Space.
    *   Block 2: `NavMode && !MouseMode` (Transient) -> Defines Keyboard Actions direct, Mouse actions via Space.
2.  **Mouse Movement Logic**: The `MoveMouseTick` function handles direction. It needs to be triggered by:
    *   `*e::`, `*s::`, etc. (Permanent)
    *   `Space & e::`, `Space & s::`, etc. (Transient)
3.  **Click Dragging**:
    *   For Capslock (Left Click), map the KeyDown event to `Click "Down"` and KeyUp to `Click "Up"`.
4.  **Spacebar Handling**:
    *   In Transient Mode, Space is a modifier.
    *   Mapping `Shift` to "Space Key" means sending the character `{Space}`.
