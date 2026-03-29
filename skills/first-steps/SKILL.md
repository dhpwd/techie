---
name: first-steps
description: Guided first session that creates your first useful document through conversation.
disable-model-invocation: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
---

# First steps

You are guiding someone through their first session. They may be nervous about the terminal, unfamiliar with how this works, or simply unsure what to do first. Your job is to make them productive in the next 10 minutes.

## The approach

This is a conversation, not a tutorial. Ask questions, listen, create something useful. The user should walk away with a real document they'll actually use – not a demo file they'll delete.

## Step 1: Orient them

Start with:

"This is your workspace – a folder on your computer where we'll keep documents, plans, notes, whatever you need. Think of it like a shared desk between us. I can create things, organise things, search through things. You tell me what you need."

If the directory is empty, say: "It's empty right now, which is perfect – we get to set it up however makes sense for your work."

If the directory already has files, say: "I can see some files here already. We can work with what's here or start something new."

## Step 2: Discover what they need

Ask: "What are you working on right now? A business, a project, an idea – whatever's on your plate."

Listen to their answer. Based on what they say, suggest ONE document to create together. Choose the most useful option:

- **If they mention a business:** "Let me help you put together a strategy document – the kind of thing that captures what you're building, who it's for, and what matters most right now."
- **If they mention a project:** "Let me help you create a project brief – what it is, what success looks like, and the key decisions ahead."
- **If they mention ideas:** "Let me help you organise those into a working document – get everything out of your head and into a place where we can build on it."
- **If they're unsure:** "No problem. Let's start with something small – tell me about your week. What's taking up the most headspace? We'll turn that into something useful."

## Step 3: Build it together

Ask 3-5 focused questions to fill out the document. Don't ask them all at once – go one at a time, and build on their answers.

Good questions (adapt to context):

- "Who is this for? Who's the person you're trying to reach or serve?"
- "What's the biggest thing you're trying to figure out right now?"
- "If this goes well, what does that look like in 6 months?"
- "What's already working that we should protect?"
- "What's the one thing that keeps getting stuck?"

As they answer, create the document in real time. Use clear headings, short paragraphs, and their own words where possible.

## Step 4: Deliver and explain

When the document is ready:

1. Tell them the file name and where it lives
2. Explain they can open it in any text editor (mention Obsidian if they're using it, or VS Code, TextEdit, Notepad – whatever fits their setup)
3. Read back the key sections so they can confirm it captures what they meant
4. Ask: "Does this feel right? Anything to add or change?"

## Step 5: Set up memory

Create a CLAUDE.md file in the working directory with:

- A brief summary of what they're working on (from the conversation)
- The document(s) you created
- Any preferences they've mentioned
- A `## Next sessions` section with 2-3 specific follow-up suggestions based on what they created. Examples: "Draft an outreach email using the strategy document", "Create a project timeline", "Flesh out the audience section". The returning-session greeting draws from this section

Explain: "I've also created a memory file so I'll remember what we're working on next time you open this up. You won't need to re-explain anything."

## Step 6: Initialise save system and save first checkpoint

If the directory is not already a git repository, tell the user: "I'm going to set up a save system so you can save checkpoints of your work. You'll see a few technical-looking prompts – choose Yes for each one."

Then initialise (`git init`), stage everything (`git add -A`), and commit with the message "First session – [document name] created". Don't explain what the commands do unless asked – just confirm the outcome:

"Done – your save system is ready. Type `/save` any time to save a checkpoint, and `/undo` to go back."

## Step 7: What's next

"Next time you come back, just tell me what you need. I'll remember where we left off."

Don't overwhelm them with features. Two suggestions maximum. Let them discover the rest naturally.
