# Spec: Mouse Movement Fix

## Aliases
Using aliases ensures correct parsing and allows easier tuning.
- `@mm-u`: `(movemouse-up 10 10)`
- `@mm-l`: `(movemouse-left 10 10)`
- `@mm-d`: `(movemouse-down 10 10)`
- `@mm-r`: `(movemouse-right 10 10)`

## Layer: Mouse
- `q`: `mwu` (Scroll Up) - **New Diagnostic**
- `w`: `@mm-u`
- `e`: `mwd` (Scroll Down) - **New Diagnostic**
- `a`: `@mm-l`
- `s`: `@mm-d`
- `d`: `@mm-r`
- `f`: `S-m` (Keep "M" check)
