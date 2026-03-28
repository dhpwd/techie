---
name: troubleshoot
description: When something goes wrong, this diagnoses the problem and explains the fix in plain language. No jargon.
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

# Troubleshoot

Something went wrong and the user needs help. Diagnose the problem, explain it plainly, and fix it (or explain the fix).

## Step 1: Identify the problem

Check conversation history for the last error or unexpected behaviour. If nothing is obvious, ask: "What happened that didn't seem right?"

## Step 2: Diagnose

Run whatever commands are needed to understand the issue. Common patterns:

### Permission errors

**What they see:** "Permission denied" or "Operation not permitted"
**Plain explanation:** "Your computer blocked that action because it's a protected area. Think of it like a locked room – you need a special key to get in."
**Fix:** Try with elevated permissions, or suggest an alternative location. Never suggest `sudo` without explaining what it does and confirming they want to proceed.

### File not found

**What they see:** "No such file or directory"
**Plain explanation:** "I looked for that file but it's not where I expected. It might have moved, or the name might be slightly different."
**Fix:** Search for the file by name and show them where it actually is.

### Command not found

**What they see:** "[command]: command not found"
**Plain explanation:** "Your computer doesn't have that tool installed. It's like trying to open a specific app that isn't on your phone yet."
**Fix:** Explain what needs to be installed and offer to do it (with confirmation).

### Any other error

Apply the same pattern: identify what they see, translate to plain English, fix or explain the fix. Common categories include disk space, network connectivity, git conflicts, and hung processes. The three examples above set the tone – keep it consistent.

## Step 3: Explain and fix

Format every diagnosis as:

> **What went wrong:** [plain explanation – one sentence]
>
> **Why:** [root cause in plain terms – one sentence]
>
> **The fix:** [what you're going to do – one sentence]

Then do it. If the fix requires their input or confirmation, ask before proceeding.

## Step 4: Prevent recurrence

If the issue is likely to happen again, mention it briefly: "This can happen when [simple cause]. If you see it again, just run `/techie:troubleshoot` and I'll sort it."

Don't lecture about best practices. One sentence of prevention, maximum.
