---
name: undo
description: Undo recent changes and go back to a previous checkpoint.
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
---

# Undo changes

The user wants to go back to a previous state. Handle with care – explain what will happen before doing it.

## If they want to undo unsaved changes

"I can undo everything since your last checkpoint. This will put your files back to how they were when you last ran `/techie:save`. Want me to go ahead?"

If confirmed: `git checkout -- .` and confirm: "Done. Your files are back to your last checkpoint."

## If they want to go back to a specific checkpoint

1. Show their recent history (same as `/techie:history`)
2. Ask which checkpoint they want to go back to
3. Explain what will happen: "This will undo everything after [checkpoint label]. Your files will look exactly like they did at that point."
4. If confirmed, create a new commit that reverts to that state (don't use `git reset --hard` – too destructive for beginners. Use `git revert` or check out the files and create a new checkpoint)
5. Confirm: "Done. Your files are back to how they were at [checkpoint label]. I've saved this as a new checkpoint so you can undo the undo if you need to."

## Rules

- Always explain what will happen before doing it
- Always ask for confirmation before undoing anything
- Never use destructive git commands (`reset --hard`, `force push`)
- Never show raw git output
- Never say "commit", "revert", "reset", "HEAD" – say "checkpoint" and "undo"
- The undo itself should be a new checkpoint (so they can undo the undo)
