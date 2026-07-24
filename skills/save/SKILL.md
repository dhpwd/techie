---
name: save
description: Save a checkpoint of your current work.
disable-model-invocation: true
allowed-tools:
  - Bash
---

# Save a checkpoint

The user wants to save their current work. This is git add + git commit, framed as "saving a checkpoint."

## Prerequisites

Check whether saving will work. On macOS, run `xcode-select -p` – silent and safe. Don't trust `which git`: fresh Macs have a placeholder that passes that check, then triggers Apple's install popup on the first real Git command. On other systems, check `git --version` runs. If it won't work: "The checkpoint system needs a tool installed first. It's a one-time setup but takes a few minutes to download. Want me to set that up now?"

If yes, explain first: "If a permission prompt appears, choose Yes. Then a popup will appear asking to install some tools – that includes what we need. It might take a few minutes to download. Let it finish, then type `/save` again and I'll save a checkpoint." Then run `xcode-select --install` (macOS) or offer their system's package manager. If no: "No problem – your documents are saved normally on your computer either way." Then stop.

## Steps

1. Check if the directory is a git repository. If not, tell them: "I need to set up a save system first." Then initialise (`git init`). Confirm: "Save system ready."
2. Check an identity is configured (`git config user.email` – empty output means it isn't). If not, set one for this folder only: `git config user.name "[their first name]"` (or "Techie" if you don't know it) and `git config user.email "techie@localhost"`. Without this the save fails with a raw git error
3. Check what's changed (`git status`). If nothing has changed, say: "Nothing new to save – you're up to date."
4. Stage all changes (`git add -A`)
5. Ask: "What were you working on? I'll use that as the label for this checkpoint." Use their answer as the commit message. If they say something vague, write a clear message yourself based on what changed.
6. Commit and confirm: "Saved. You can type `/history` to see all your checkpoints, or `/undo` if you need to go back."

## Rules

- Never show raw git output
- Never say "commit", "stage", "repository", or "branch" unless the user has used them first
- Frame everything as "checkpoints" and "saves"
