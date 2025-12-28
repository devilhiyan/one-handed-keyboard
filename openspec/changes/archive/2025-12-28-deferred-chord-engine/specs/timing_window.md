# Spec: Deferred Chord Window

## 1. Timing Requirement
- The script SHALL wait up to **200ms** from the *first* chord-related key press before evaluating.
- If all keys are released before 200ms: Evaluate immediately upon release of the last key.
- If keys are still held at 200ms: Evaluate and begin continuous action.

## 2. Evaluation Logic
- The script MUST track the "peak" chord (the combination with the most keys) achieved during the window.
- Example: If the user presses `a`, then `s`, then `d`, then releases all within 150ms -> Execute `Backspace` (3-key chord) once.
- Example: If the user holds `a`, `s`, `d` for 500ms -> Execute `Backspace` once at 200ms, then repeat every 50ms.

## 3. Immediate Typing Prevention
- Single key taps (that don't result in a chord) MUST still function correctly, potentially with a slight delay or by being sent immediately if no second key is pressed within the window.
- *Note:* To maintain responsiveness, if a key is released *before* the 200ms window ends and no other keys were pressed, it should be treated as a normal tap.

## 4. Repetition
- After the initial 200ms delay and execution, if the keys remain held, the action SHALL repeat every 50ms (or current master tick rate).
