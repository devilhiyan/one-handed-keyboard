# Tasks: Fix Interception Driver

- [ ] **Step 1: Install Interception Driver**
    - Execute the installer: `kanata\Interception\Interception\command line installer\install-interception.exe /install`.
    - *Note:* This usually requires a reboot, but we will try without first if it claims success.

- [ ] **Step 2: Update Config to Probe Mouse**
    - Add `windows-interception-mouse-hwid "0, 0, 0, 0"` to `defcfg` in `kanata.kbd`.
    - This forces Kanata to look for mice and might initialize the injection system.

- [ ] **Step 3: User Reboot (If needed)**
    - If Step 1 says "Reboot required", we must inform the user.
