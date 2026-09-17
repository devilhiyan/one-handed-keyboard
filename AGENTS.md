<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to align on intent with plans (Phase 1)
- How to create and apply change proposals (Phase 2)
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Antigravity Assistant Rules for this Project

- **Always Update Cheat Sheet**: Whenever any key mappings, chords, layers, or keyboard behaviors in this project are modified, added, or removed, Antigravity MUST always:
  1. Update `kanata/generate_cheatsheet.py` with the new or modified mappings.
  2. Run `python kanata/generate_cheatsheet.py` to regenerate `kanata/layout_cheatsheet.png`.
  3. Keep `kanata/docs/LAYOUT.md` and `documents/One-Handed-Keyboard/02-Functionality.md` synchronized so all visual and textual references remain 100% accurate.