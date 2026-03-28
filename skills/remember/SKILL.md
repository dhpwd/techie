---
name: remember
description: Set up or update project memory so I remember what you're working on across sessions. Surveys your workspace and asks a few questions, then creates or updates your memory file.
disable-model-invocation: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
---

# Remember this project

The user wants you to learn about their project so you remember it in future sessions. This creates or updates the CLAUDE.md file in the current directory.

## If CLAUDE.md doesn't exist yet

### 1. Survey the workspace

Scan the directory for existing files. Note:

- What types of files are here (documents, code, mixed)
- Any recognisable structure (folders, naming patterns)
- Key documents that look like foundational context (strategy docs, plans, briefs)

### 2. Ask focused questions

Based on what you found, ask 2-3 questions to fill gaps:

- "What is this project?" (if not obvious from files)
- "Which of these documents are the most important for understanding your work?" (if multiple exist)
- "Anything I should know about how you like to work?" (preferences, conventions)

Don't over-question. If the files make the answers obvious, skip the question.

### 3. Create CLAUDE.md

Structure:

```markdown
# [Project name]

[1-2 sentence summary of what this project is]

## Core context documents

- `[file path]` – [one-line description]
- `[file path]` – [one-line description]

## Preferences

- [Any working preferences mentioned]

## Next sessions

- [2-3 specific follow-up suggestions based on what's here]
```

If the directory is not already a git repository, tell the user: "I'm also going to set up a save system – you'll see a couple of technical-looking prompts, choose Yes." Then initialise and save the first checkpoint. Don't explain the commands unless asked.

Explain: "Done. I'll remember this project next time you open a session here, and your save system is ready – type `/save` any time to save a checkpoint."

## If CLAUDE.md already exists

Read the current file. Then:

1. Scan for new files created since the last update
2. Ask: "Anything changed about the project, or any new preferences?"
3. Update the file – add new documents to core context, refresh the summary if needed, update next-session suggestions
4. Don't remove existing content unless the user says to

Explain: "Updated. I've added [what changed] to your project memory."

## Rules

- Keep CLAUDE.md under 50 lines. It's a map, not a manual
- List documents as core context only if they're genuinely foundational (strategy, positioning, key specs) – not every file in the directory
- Use plain language throughout. No technical metadata
- The ## Next sessions section should contain specific, actionable suggestions – not generic "continue working on your project"
