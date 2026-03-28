---
name: history
description: Show your save history – all the checkpoints you've created, newest first.
disable-model-invocation: true
allowed-tools:
  - Bash
---

# Save history

Show the user their checkpoint history in plain English.

## Steps

1. Check if this is a git repository. If not, say: "No save history yet. Type `/techie:save` to create your first checkpoint."
2. Run `git log --oneline -20` to get recent history
3. Present as a clean list:

> **Your checkpoints:**
>
> - [date] – [message]
> - [date] – [message]
> - [date] – [message]

4. Format dates as relative ("2 hours ago", "yesterday", "3 days ago") not raw timestamps
5. If they want to go back to one, mention: "Type `/techie:undo` to go back to a previous checkpoint."

## Rules

- Never show raw git log output
- Never say "commit", "hash", "SHA", or "HEAD"
- Show the last 10 checkpoints by default. Offer more if they ask
