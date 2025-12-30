# Proposal: Undo/Redo Chords & Tuning

## Goal
Add chords for Undo and Redo actions and reduce the global chord timeout to minimize input latency during fast typing.

## Changes

### 1. New Chords (`halmak-chords` and `mirror-chords`)
| Chord Keys | Action | Mnemonic |
| :--- | :--- | :--- |
| `l` + `d` | `Ctrl + z` (Undo) | Left + Down? (Mnemonic TBD) |
| `n` + `m` | `Ctrl + y` (Redo) |  |

### 2. Chord Timeout Tuning
- **Reduce** `defchords` timeout from **100ms** to **50ms**.
- *Reason:* A shorter timeout ensures that if keys are typed sequentially but quickly (high frequency), they are registered as individual letters rather than waiting for a potential chord.

## Reason
To improve editing efficiency and overall typing responsiveness.
