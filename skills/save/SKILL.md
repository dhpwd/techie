---
name: save
description: Save a checkpoint of your current work. Creates a save point you can return to later.
disable-model-invocation: true
allowed-tools:
  - Bash
---

# Save a checkpoint

The user wants to save their current work. This is git add + git commit, framed as "saving a checkpoint."

## Steps

1. Check if the directory is a git repository. If not, tell them: "I need to set up a save system first – you'll see a technical-looking prompt, choose Yes." Then initialise (`git init`). Confirm: "Save system ready."
2. Check what's changed (`git status`). If nothing has changed, say: "Nothing new to save – you're up to date."
3. Stage all changes (`git add -A`)
4. Ask: "What were you working on? I'll use that as the label for this checkpoint." Use their answer as the commit message. If they say something vague, write a clear message yourself based on what changed.
5. Commit and confirm: "Saved. You can type `/history` to see all your checkpoints, or `/undo` if you need to go back."

## Rules

- Never show raw git output
- Never say "commit", "stage", "repository", or "branch" unless the user has used them first
- Frame everything as "checkpoints" and "saves"
