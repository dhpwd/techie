---
name: commands
description: Quick reference of useful commands, categorised and practical. Shows what's relevant to your current situation.
disable-model-invocation: true
allowed-tools:
  - Read
  - Bash
  - Glob
---

# Commands quick reference

Show the user a practical, categorised reference of what they can do. Not a wall of text – short, scannable, useful.

## Step 1: Check context

Before showing commands, quickly check:

- Does CLAUDE.md exist? (They have project context)
- Are there files in the directory? (They have existing work)
- What kind of files are present? (Documents, code, mixed)

Tailor the reference to their situation.

## Step 2: Show relevant commands

Use this format – one line per command, grouped by what they'd want to do:

### Working with documents

| What you want                  | What to type                                    |
| ------------------------------ | ----------------------------------------------- |
| Create a new document          | "Create a document called [name] about [topic]" |
| Edit an existing document      | "Update [file name] to [change]"                |
| Read a document back to me     | "Read [file name]" or type `@` to pick a file   |
| Find something in my documents | "Search for [term] in my files"                 |
| Summarise a document           | "Summarise @[pick a file]"                      |
| Organise my files into folders | "Organise these files by [theme/date/project]"  |

### Getting help

| What you want                 | What to type            |
| ----------------------------- | ----------------------- |
| Explain what just happened    | `/explain`       |
| Learn how something works     | `/learn [topic]` |
| Fix something that went wrong | `/troubleshoot`  |
| Make this window look better  | `/setup-theme`   |
| See this reference again      | `/commands`      |

### Useful to know

| What you want                      | What to type                         |
| ---------------------------------- | ------------------------------------ |
| See what files are here            | "What files do I have?"              |
| Check where I am                   | "Where am I?" (shows current folder) |
| Go to a different folder           | "Go to [folder name]"                |
| Undo the last thing                | "Undo that" or `/undo`               |
| Start a fresh conversation         | `/exit` then type `claude` again     |
| Go back to a previous conversation | `/resume`                            |

If they have a git repository, add:

### Saving your work

| What you want         | What to type                               |
| --------------------- | ------------------------------------------ |
| Save a checkpoint     | `/save` or "Save a checkpoint"      |
| See your save history | `/history` or "Show my saves"       |
| Undo recent changes   | `/undo` or "Undo that"              |
| See what's changed    | "What have I changed since the last save?" |

## Step 3: Remind them

End with: "You don't need to memorise any of this. Just describe what you want in plain English and I'll handle it. This reference is here if you want it – `/commands` any time."
