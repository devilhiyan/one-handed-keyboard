# Proposal: Refine Acceleration Curve

## 1. Goal
Improve mouse control by increasing starting speed and implementing an "ease-out" acceleration curve that slows down as it approaches a new maximum speed cap.

## 2. Changes
### AutoHotkey (`kanata_mouse_bridge.ahk`)
- **MinSpeed**: Keep at `1`.
- **MaxSpeed**: Reintroduce a cap at `35`.
- **Acceleration Logic**: Change from multiplicative (`* 1.07`) to proportional approach (`CurrentSpeed += (MaxSpeed - CurrentSpeed) * 0.05`).
    - This ensures rapid acceleration at the start and finer control near the top speed.

## 3. Impact
- **Files Modified**: `kanata_mouse_bridge.ahk`.
