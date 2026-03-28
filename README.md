# Techie

A Claude Code plugin that turns the terminal into your techie – the technical friend who handles complexity so you don't have to.

## Who this is for

Smart non-technical people – founders, operators, knowledge workers – who want the compounding power of Claude Code without the developer-shaped learning curve.

## Install

```bash
claude plugin add dhpwd/techie
```

Works in any terminal. For the best experience, we recommend [Warp](https://warp.dev) (free).

## What happens when you start

Open a terminal, navigate to any folder, and type `claude`. Techie detects whether you're starting fresh or picking up where you left off:

- **New workspace** – walks you through creating your first useful document (a strategy doc, project brief, or working plan) through a conversation. Sets up project memory so it remembers everything next time
- **Returning session** – greets you by name, references what you were working on, and suggests a concrete next step. No re-explaining needed

The first session takes about 10 minutes. Every session after that picks up where you left off.

## What you can do

Just describe what you need in plain English. Techie handles the technical side. For specific workflows, these skills are available:

| What you want                      | What to type                  |
| ---------------------------------- | ----------------------------- |
| Guided first session               | `/techie:first-steps`         |
| Set up project memory              | `/techie:remember`            |
| Start a complex task with guidance | `/techie:consult [your goal]` |
| Learn something by doing           | `/techie:learn [topic]`       |
| Make the terminal look better      | `/techie:setup-theme`         |
| Explain what just happened         | `/techie:explain`             |
| Quick reference of commands        | `/techie:commands`            |
| Fix something that went wrong      | `/techie:troubleshoot`        |
| Save a checkpoint of your work     | `/techie:save`                |
| See your save history              | `/techie:history`             |
| Undo recent changes                | `/techie:undo`                |
| Check for plugin updates           | `/techie:update`              |

Two background skills run automatically – **jargon decoder** translates technical terms inline as they appear, and **progress tracker** keeps a record of what you've accomplished across sessions.

## Terminal appearance

The terminal can feel uncomfortable – small text, harsh colours, no visual hierarchy. Type `/techie:setup-theme` and Techie will detect your terminal app and apply a warmer, more readable theme automatically. Supports Terminal.app, iTerm2, Ghostty, Warp, and Kitty.

## Learn more

This plugin is part of a series on getting the most out of Claude Code for non-technical people at [danhopwood.com](https://danhopwood.com).

## Feedback

Something not working? [Open an issue](https://github.com/dhpwd/techie/issues) or email dan@fidero.com.

## Updates

Check for updates: type `/techie:update`

## Author

Built by [Dan Hopwood](https://danhopwood.com).

## Licence

MIT
