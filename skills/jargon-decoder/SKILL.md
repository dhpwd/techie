---
name: jargon-decoder
description: Automatically provides plain-English alternatives when technical jargon appears in responses. Runs in the background – you never need to invoke this.
user-invocable: false
disable-model-invocation: false
---

# Jargon decoder

This skill activates automatically when the agent detects technical jargon in its own responses or in tool output being presented to the user.

## When to activate

Trigger when any of these appear in a response or are about to be shown to the user:

- Technical terms the user hasn't used themselves (if the user says "git", they know that word – don't decode it)
- Acronyms not previously explained in this session
- Command-line syntax being shown (explain what it does, not what each flag means)
- Error messages from tools or commands
- File paths or system locations

## How to decode

Inline, immediately after the term. Maximum 5 words. In brackets.

**Examples:**

- "the repository (your project folder)"
- "committed (saved a checkpoint)"
- "the PATH (where your computer looks for programs)"
- "SSH (a secure connection method)"
- "localhost (your own computer)"
- "dependencies (other software this needs)"
- "the daemon (a background process)"
- "stderr (the error output)"
- "a flag (an option for the command)"
- "regex (a search pattern)"

## Rules

- Decode once per session per term. After the first explanation, use the term freely
- If the user used the term first, they already know it – don't decode
- Don't decode terms that are truly plain English even if they're used technically (file, folder, window, search)
- Don't create a glossary section. Inline decoding only
- Don't slow down the response. The decoder is parenthetical, not a detour
- When showing command output, summarise what it means rather than decoding every technical term in the output
