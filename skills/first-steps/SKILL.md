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

## Before you start

Check if the current working directory is the user's home folder (`~`). If so, don't proceed – they need to relaunch from a project folder. Check whether `~/Workspace` exists:

- **If it exists:** "You need to be in your project folder first. Type `/exit`, then `cd Workspace`, then `claude` to come back."
- **If it doesn't:** "You need a project folder first. Type `/exit`, then `mkdir Workspace`, then `cd Workspace`, then `claude` to come back."

Stop here. Don't continue to Step 1.

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

Once you have all their answers, create the document using a relative path in the current directory (e.g. `Strategy.md`, never `~/Strategy.md`). Use clear headings, short paragraphs, and their own words where possible.

## Step 4: Deliver and explain

When the document is ready:

1. Tell them the file name and where it lives
2. Explain they can open it in any text editor (mention Obsidian if they're using it, or VS Code, TextEdit, Notepad – whatever fits their setup)
3. Read back the key sections so they can confirm it captures what they meant
4. Ask: "Does this feel right? Anything to add or change?"

## Step 5: Transition and set up memory

Once the user confirms the document is right (or after making any changes they requested), pause before doing anything else. Say something like:

"Before we wrap up, I'll do two quick things: set up a memory file so I remember what we discussed next time, and a save system so you can save checkpoints of your work. You'll see some text appear – that's just me working. Happy for me to go ahead?"

Wait for them to confirm before continuing. Then create a CLAUDE.md file in the working directory with:

- A brief summary of what they're working on (from the conversation)
- The document(s) you created
- Any preferences they've mentioned
- A `## Next sessions` section with 2-3 specific follow-up suggestions based on what they created. Examples: "Draft an outreach email using the strategy document", "Create a project timeline", "Flesh out the audience section". The returning-session greeting draws from this section

## Step 6: Initialise save system and save first checkpoint

First, check if Git is available (`which git`). If it's not installed, skip the save system entirely. Tell them: "There's a checkpoint system that lets you save and undo your work, but it needs a tool installed first. It's a one-time setup but takes a few minutes to download. Want me to set that up now, or would you rather do it another time?"

If they want to proceed, explain first: "You'll see a technical-looking prompt asking for permission – choose Yes. Then a popup will appear asking to install some tools – that includes what we need. It might take a few minutes to download. Let it finish, then type `/save` and the checkpoint system will be ready." Then run `xcode-select --install` (macOS).

If they'd rather skip it, say: "No problem – your documents are saved normally on your computer either way. You can set this up any time by typing `/save` and I'll walk you through it." Then go straight to Step 7.

If Git is available and the directory is not already a git repository, tell the user: "I'm going to set up a save system so you can save checkpoints of your work."

Then initialise (`git init`), stage everything (`git add -A`), and commit with the message "First session – [document name] created". Don't explain what the commands do unless asked – just confirm the outcome:

"All set. I've created a memory file so I'll remember this next time, and your save system is ready. Type `/save` any time to save a checkpoint, and `/undo` to go back."

## Step 7: What's next

"Next time you come back, just tell me what you need. I'll remember where we left off. When you're done for now, type `/exit`."

Don't overwhelm them with features. Two suggestions maximum. Let them discover the rest naturally.
