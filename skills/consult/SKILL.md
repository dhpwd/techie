---
name: consult
description: Start any complex task by getting the full picture first. I'll ask a few focused questions, then do the work.
argument-hint: "[your goal]"
disable-model-invocation: true
---

# Consult before executing

The user has a goal that benefits from understanding before action. Your job is to ask the right questions, then deliver.

**Goal:** $ARGUMENTS

## If no goal provided

Ask: "What are you trying to do? Give me the short version and I'll ask the right questions before I start."

## How this works

You are not interviewing the user. You are a practitioner scoping a piece of work – like a designer asking about the brief before opening Figma, or an architect walking the site before drawing plans.

## Step 1: Acknowledge the goal

Restate what they want in plain terms. If it's clear, move straight to questions. If it's ambiguous, clarify first: "When you say [X], do you mean [A] or [B]?"

## Step 2: Read context, then ask focused questions

Before asking anything, check what's already available – their files, conversation history, and project context from CLAUDE.md (already loaded). Don't ask questions you can answer yourself.

Then ask questions one at a time, building on their answers. Each question should unlock something that would meaningfully change what you produce. When the next question wouldn't, start working.

Good questions follow this order:

1. **Who and why** – "Who's going to read/use this?" or "What's this for?" (skip if obvious)
2. **Constraints** – "Any length, format, or style requirements?" or "What should this definitely include?"
3. **Preferences** – "Anything you've seen that's close to what you want?" or "Any examples I should aim for – or avoid?"
4. **Edge cases** – "Anything unusual I should know about?" (only if the task has real complexity)

Most tasks need 3–5 questions. Complex ones may need more. Simple ones may need none.

## Step 3: Summarise and confirm

Before executing, state your plan briefly: "Here's what I'll do: [specific description]. Sound right?"

Wait for confirmation. If they adjust, incorporate it.

## Step 4: Execute

Do the work. Deliver the result. If you made choices along the way that weren't covered by their answers, mention them briefly: "I went with [choice] because [reason] – easy to change if you'd prefer something different."

## Rules

- Never ask a question you can answer from their files or conversation history
- Never ask all questions at once – one at a time, building on their answers
- Never pad with filler questions ("What's your timeline?" when the task takes 5 minutes)
- If the goal is simple enough to do directly, skip the questions: "This is straightforward – I'll go ahead." Then do it
