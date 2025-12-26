# Dvorak Alpha-Only Mode

## 1. Goal
Refine the "Dvorak" Mirror Style to only remap keys that produce Alphabetic characters (A-Z) in the Dvorak layout. Keys that produce Symbols (punctuation, etc.) should retain their QWERTY (for Normal typing) or Standard Mirror (for Mirror typing) behavior.

## 2. Changes

### Normal Typing (Physical QWERTY -> Output)
*   **Q, W, E**: Retain as `q, w, e` (Dvorak `' , .`).
*   **R, T, Y, U, I, O, P**: Remap to `p, y, f, g, c, r, l`.
*   **A, M**: Retain as `a, m`.
*   **S, D, F, G, H, J, K, L, ;**: Remap to `o, e, u, i, d, h, t, n, s`.
*   **Z**: Retain as `z` (Dvorak `;`).
*   **X, C, V, B, N**: Remap to `q, j, k, x, b`.
*   **Comma (,)**: Remap to `w`.
*   **Period (.)**: Remap to `v`.
*   **Slash (/)**: Remap to `z`.
*   **Symbols ([, ], ', -, =)**: Retain QWERTY functions.

### Mirror Typing (Space + Physical QWERTY -> Output)
*   **Space + Q, W, E**: Remap to `l, r, c` (Dvorak Alphas).
*   **Space + R, T, Y, U**: Remap to `g, f, y, p` (Dvorak Alphas).
*   **Space + I**: Fallback to `e` (Standard Mirror) because Dvorak `.` is a symbol.
*   **Space + O**: Fallback to `w` (Standard Mirror) because Dvorak `,` is a symbol.
*   **Space + P**: Fallback to `q` (Standard Mirror) because Dvorak `'` is a symbol.
*   **Space + A, S, D, F, G, H, J, K, L, ;**: Remap to `s, n, t, h, d, i, u, e, o, a`.
*   **Space + Z**: Remap to `z` (Dvorak Alpha).
*   **Space + X, C, V, B, N, M**: Remap to `v, w, m, x, b, k`.
*   **Space + Comma (,)**: Remap to `j`.
*   **Space + Period (.)**: Remap to `q`.
*   **Space + Slash (/)**: Fallback to `z` (Standard Mirror) because Dvorak `;` is a symbol.

## 3. Code Implementation
The `#HotIf MirrorStyle == "Dvorak"` block will be updated to reflect these selective mappings.
Ignored keys will be explicitly mapped to their QWERTY/Standard values to ensure functionality since the Standard block is inactive.
