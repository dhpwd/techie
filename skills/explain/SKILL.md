---
name: explain
description: Scaffolded explanation from plain English to full technical detail. Use with no arguments to explain the last thing that happened, or specify a topic and optional analogy domain.
argument-hint: "[topic] [analogy domain]"
disable-model-invocation: true
allowed-tools:
  - Read
  - Bash
---

# Explain

The user wants something explained. Either the last thing that happened, or a specific concept.

**What to explain:** $ARGUMENTS

## If no arguments provided (explain the last thing)

Look at the conversation history. Find the last action, output, or error. Explain:

1. **What happened** – one sentence, plain English
2. **Why it matters** – one sentence on what it means for them
3. **What to do next** – one sentence (if any action is needed)

Format:

> **What happened:** [plain explanation]
>
> **What it means:** [why they should care, or why they shouldn't worry]
>
> **Next step:** [what to do, or "Nothing – we're good."]

## If a concept is specified

Explain in three layers. Deliver layer 1, then layer 2 (if an analogy adds clarity), then stop. Only deliver layer 3 if they ask for more detail.

**Layer 1 – Plain English:** Explain $0 as if the reader has zero context. 10 words or fewer. No jargon.

**Layer 2 – Analogy** (include only if it genuinely aids understanding – skip for concepts simple enough without one): Relate to something the reader already knows. If they specified an analogy domain ($1), use that domain. Otherwise, choose whatever fits best.

**Layer 3 – Full technical description** (only on request): The real, precise, technical explanation. No dumbing down. University-level or practitioner-level detail – the kind of explanation that would satisfy someone who works with this concept daily.

**Example:** `/explain git cooking`

> **Git** is a save-point system for your files.
>
> Think of it like a recipe notebook where you photograph each page before you change it. You can flip back to any previous photo. Branching is like copying a recipe to experiment with – the original stays untouched until you decide the new version is better.

If they then ask "go deeper":

> Git is a distributed version control system that tracks content changes as snapshots (commits) in a directed acyclic graph. Each commit stores a tree of blob objects (file contents) and references its parent commit(s). Branches are lightweight pointers to commits. Merging combines divergent commit histories by creating a new commit with multiple parents, resolving conflicts where the same lines were modified in both branches.

## Rules

- No jargon in layers 1-2. Layer 3 uses proper technical terminology
- No code blocks unless they specifically ask to see raw output
- No "actually, it's more complicated than that" caveats
- If you're not sure what confused them, ask: "Which part wasn't clear?"
