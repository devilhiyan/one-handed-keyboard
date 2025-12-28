# Spec: Interception Driver & Config

## Config Change
Update `defcfg` to include:
```lisp
(defcfg
  process-unmapped-keys yes
  windows-interception-mouse-hwid "0, 0, 0, 0"
  ;; ... other settings
)
```

## Driver Installation
Run: `install-interception.exe /install`
