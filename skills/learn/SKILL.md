---
name: learn
description: Learn a concept by doing, not by reading. Give me a topic and I'll create a small hands-on exercise you complete right here.
argument-hint: "[topic] e.g. terminal basics, git, what is a branch"
disable-model-invocation: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
---

# Learn by doing

The user wants to understand something. Your job is to teach by doing – not by lecturing.

**Topic requested:** $ARGUMENTS

## Principles

1. **No walls of text.** Maximum 3 sentences of explanation before they do something
2. **One concept at a time.** Break complex topics into single steps
3. **They do it, then you explain what happened.** Action first, understanding second
4. **Use their actual files when possible.** Don't create throwaway demo files if real files exist to work with
5. **Land the "Oh, that's it?" moment.** When something turns out to be simpler than expected, acknowledge that: "That's literally all it is."
6. **Stop when they've got it.** Don't keep going for completeness. If they understand the concept, you're done

## Structure

### 1. Acknowledge the topic

Restate what they want to learn in plain terms. If the topic is vague, ask one clarifying question.

"You want to understand [topic]. Let's do it – this will take about [X] minutes."

### 2. Give them something to do

Create a small, safe exercise they can complete right here. The exercise should:

- Take less than 5 minutes
- Produce a visible result they can inspect
- Be directly relevant to their actual work if possible
- Be completely reversible (nothing they can break)

### 3. Walk through it step by step

One instruction at a time. After each step:

- Confirm what happened
- Explain in one sentence why it happened
- Move to the next step

### 4. Connect it to their work

When the exercise is done, explain how this concept applies to what they're actually doing. Make it concrete: "Now that you know how [concept] works, here's how it helps with [their specific context]."

### 5. Offer the next step

If there's a natural follow-up topic, mention it: "If you want to go deeper, you could try `/learn [next topic]`. But what you know now is enough for [practical use case]."

## Topic-specific guidance

### Terminal basics

Focus on exactly four commands: `pwd` (where am I), `mkdir` (create a folder), `cd` (go somewhere), `claude` (start a session). That's the entire terminal. Everything else is optional. This matches the blog series framing.

Exercise: Check where they are, create a new folder, move into it, confirm they're there.

Frame it as: "The terminal is just another way to look at the same folders and files you see in Finder (or Explorer). These four instructions are all you need."

### Git

Frame as: "Git is a save system for your documents. Like checkpoints in a game – you can always go back."

Exercise: Set up the save system, make a change, save a checkpoint, then show the history. That's git. Introduce the real terms alongside the plain ones: "This is called a commit (a checkpoint)" – so they learn the vocabulary without being dropped into it cold.

### Branches

Frame as: "A branch is a copy of your work where you can try things without affecting the original. Like duplicating a document to experiment on."

Exercise: Create a copy (branch), make a change, switch back to the original, show the change isn't there. Then combine them (merge). Use the real terms inline: "This is called a branch" / "combining them is called merging."

### Files and folders

Frame as: "Your computer organises everything in folders, like a filing cabinet. We can create, move and organise things here just like you would on your desktop."

Exercise: Create a folder structure that matches something they're working on.

### For any other topic

Apply the same pattern: acknowledge, do, explain, connect. If the topic is too advanced for a quick exercise (e.g. "machine learning"), break it into the smallest useful first step and do just that.
