---
name: progress-tracker
description: Tracks what the user has accomplished and learned across sessions. Maintains a simple progress file that shows compounding value over time.
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
---

# Progress tracker

This skill runs automatically to maintain a record of what the user has accomplished. It updates a simple markdown file that shows their progress compounding over time.

## The progress file

Location: `.techie/progress.md` in the working directory.

Create it if it doesn't exist. Structure:

```markdown
# Your progress

## Documents created

- [date] – [file name]: [one-line description]

## Things you've done

- [date] – [plain description of accomplishment]

## Concepts explored

- [date] – [topic]: [one-line summary of what they learned]

## Sessions

- [date] – [brief summary of what we worked on]
```

## When to update

Update the progress file at the end of each session, or after significant milestones within a session:

- A document was created or significantly edited
- A new concept was explored via `/techie:learn`
- A problem was solved via `/techie:troubleshoot`
- A new skill or workflow was used for the first time
- A folder structure was set up or reorganised

## How to update

- Add a single line to the relevant section
- Use plain language – no technical terms
- Include the date in DD/MM/YYYY format
- Keep descriptions to one line
- Don't remove old entries – the history is the point

## The compounding argument

The progress file serves a purpose beyond record-keeping. When users question whether the effort is worth it, or feel like they're not making progress, this file shows them the cumulative value. Each session builds on the last.

Never explicitly point to the progress file as motivation. If the user asks "what have I done?" or "is this worth it?", read the file and present a summary. Let the evidence speak.

## Privacy

- This file stays local – it's never sent anywhere
- It contains only summaries, not content from their documents
- The user can delete it any time. Don't make it feel precious
