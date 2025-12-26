# Add Halmak Mirror Style

## 1. Goal
Implement a new mirroring style based on the provided Halmak-inspired layout. This layout optimizes the left-hand grid for one-handed typing by remapping base keys and defining space-hold alternates.

## 2. What Changes
*   Introduce `Halmak` as a new `MirrorStyle`.
*   Implement alpha remaps for the base layer (Normal Tap).
*   Implement mirroring mappings for the space layer (Hold Space).
*   Update the `MirrorStyle` toggle logic and Tray/GUI menus to support the new style.
*   Update `Global Chords` "Restore Typing" section to handle Halmak key assignments.

## 3. Layout Details
### Base Layer (Standard Tap)
- Q -> N, W -> S, E -> T, R -> H, T -> R
- A -> E, S -> A, D -> I, F -> O, G -> U
- Z -> L, X -> D, C -> C, V -> M

### Space Layer (Hold Space)
- Q -> G, W -> P, E -> W, R -> Y, T -> F
- A -> K, S -> J, D -> X, F -> Q, G -> Z
- C -> B, V -> V
