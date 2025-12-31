# Proposal: Volume and Brightness Chords

## Goal
Add dedicated chords for system controls (Volume and Brightness) to improve accessibility without leaving the home position.

## Mappings

### 1. Halmak Layer (Base)
*   **Chord (a h)** -> **Volume Increase** (`volu`)
*   **Chord (o c)** -> **Volume Decrease** (`vold`)
    *   *Note*: In `defsrc`, `o` is `f` position? No, let's verify key positions.
    *   `defsrc`: `... a s d f g h j k l ...`
    *   `halmak`: `... a s d f g h j k l ...`
    *   BUT `halmak-chords` rebinds single keys:
        *   `(f)` -> `o` (Output)
        *   `(q)` -> `c` (Output)
        *   Wait, the user request says "ah" and "oc". Are these **Physical Keys** or **Output Characters**?
        *   Assuming **Output Characters** based on previous interactions (Undo/Redo used Output names).
        *   **If Output 'a'**: Physical `a` -> Output `a`.
        *   **If Output 'h'**: Physical `r` -> Output `h`.
        *   So `ah` -> Physical `a` + `r`.
        *   **If Output 'o'**: Physical `f` -> Output `o`.
        *   **If Output 'c'**: Physical `q` -> Output `c`.
        *   So `oc` -> Physical `f` + `q`.

### 2. Mirror Layer (Space held)
*   **Chord (a h)** -> **Brightness Increase** (`brup`)
    *   User said "space ah".
    *   This implies holding Space (Mirror Layer) and pressing the chord that produces `a` and `h`? Or pressing the mirrored positions?
    *   Usually, Mirror layer chords are symmetric.
    *   Let's assume the user means the same *physical* keys as above, but while holding Space.
    *   Or, they mean the keys that output `a` and `h` *in the mirror layer*?
    *   In Mirror:
        *   Physical `a` -> Output `q`.
        *   Physical `r` -> Output `y`.
    *   This gets confusing.
    *   **Interpretation**: User likely means the same **Physical Chords** as the base layer, but activated when Space is held.
    *   So:
        *   Physical `a` + `r` (while Space held) -> Brightness Up.
        *   Physical `f` + `q` (while Space held) -> Brightness Down.

## Plan
1.  **Verify Key Mappings**: Confirm which physical keys correspond to Halmak 'a', 'h', 'o', 'c'.
    *   `a` -> Physical `a`.
    *   `h` -> Physical `r`.
    *   `o` -> Physical `f`.
    *   `c` -> Physical `q`.
2.  **Update `kanata.kbd`**:
    *   Add `(a r) volu` to `halmak-chords`.
    *   Add `(q f) vold` to `halmak-chords`.
    *   Add `(a r) brup` to `mirror-chords`.
    *   Add `(q f) brdn` to `mirror-chords`.

## User Request Refinement
"map halmak ah to volume increase ... oc to volume decrease"
"space ah to brightness increase ... space co to brightness decrease" (Note: User said "co" for brightness decrease, but "oc" for volume decrease. "co" and "oc" are the same chord `c`+`o`).

## Conflict Check
*   `(a r)`: Currently undefined?
*   `(q f)`: Currently undefined?
