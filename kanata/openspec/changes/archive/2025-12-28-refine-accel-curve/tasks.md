# Tasks: Refine Acceleration Curve

- [ ] **Step 1: Update AHK Configuration**
    - Set `MinSpeed := 1`.
    - Set `MaxSpeed := 35`.
    - Remove `AccelFactor`.

- [ ] **Step 2: Implement Ease-Out Logic**
    - In `ProcessMovement`:
    - Replace `CurrentSpeed *= AccelFactor` with:
      `CurrentSpeed += (MaxSpeed - CurrentSpeed) * 0.08`
      (Tweak 0.08 to find the sweet spot, maybe 0.05 or 0.10).
