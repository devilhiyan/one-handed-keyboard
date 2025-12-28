# Proposal: Fix Tab-Space Chord

## 1. Goal
Make the `Tab + Space` chord reliable.

## 2. Issue
- The current chord timeout is set to `50ms`. This is extremely tight for two keys that are not adjacent, leading to failed activation.

## 3. Changes
### Kanata (`kanata.kbd`)
- Increase `mouse-chords` timeout to `150ms`.
- Verify the chord definition is correct.

## 4. Impact
- **Files Modified**: `kanata.kbd`.
