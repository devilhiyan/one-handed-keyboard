# Proposal: Restore Left Alt Functionality

## Issue
Currently, the **Left Alt** key in the Halmak layer is mapped to `@to-mouse`, which switches to the Mouse Navigation layer. The user finds this undesirable and wants **Left Alt** to function as a standard Alt key.

## Solution
Remap **Left Alt** in the `halmak` layer to `lalt`.

## Access to Navigation Mode
The user can still access Navigation Mode by tapping **Left Ctrl**, which is configured via the `@lctl-mod-halmak` alias to toggle the mouse layer.

## Implementation
1.  **Kanata (`kanata.kbd`)**:
    *   In `deflayer halmak`, change `@to-mouse` to `lalt`.
