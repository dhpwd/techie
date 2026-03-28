# Techie

A Claude Code plugin that gives you a techie – the technical friend who handles complexity so you don't have to.

## Who this is for

Smart non-technical people – founders, operators, knowledge workers. You don't need to become technical. You need someone who handles that side of things.

This plugin replaces Claude Code's developer-oriented interface with one designed for people who have better things to do than learn what a "working directory" is.

## Install

```bash
claude plugin add dhpwd/techie
```

Works in any terminal. On Mac, [Ghostty](https://ghostty.org) is free and looks great out of the box.

## What happens when you start

Type `/techie:first-steps` and you'll have a guided conversation that creates your first useful document – a strategy doc, project brief, or working plan based on what you're actually working on. Takes about 10 minutes. The plugin sets up project memory so it remembers everything next time.

When you come back, it picks up where you left off – references what you were working on and suggests a concrete next step. No re-explaining.

<!-- TODO: screenshot of first-run conversation -->

## Skills

Describe what you need in plain English – that works for most things. For specific workflows:

| What you want                      | What to type                  |
| ---------------------------------- | ----------------------------- |
| Guided first session               | `/techie:first-steps`         |
| Set up project memory              | `/techie:remember`            |
| Start a complex task with guidance | `/techie:consult [your goal]` |
| Learn something by doing           | `/techie:learn [topic]`       |
| Make this window look better       | `/techie:setup-theme`         |
| Explain what just happened         | `/techie:explain`             |
| Quick reference of commands        | `/techie:commands`            |
| Fix something that went wrong      | `/techie:troubleshoot`        |
| Save a checkpoint                  | `/techie:save`                |
| See your save history              | `/techie:history`             |
| Undo recent changes                | `/techie:undo`                |
| Check for plugin updates           | `/techie:update`              |
| Open the getting-started guide     | `/techie:guide`               |

Two skills run automatically in the background: **jargon decoder** translates technical terms inline, and **progress tracker** logs what you've accomplished across sessions.

## Terminal appearance

The default terminal is small text on a black void. `/techie:setup-theme` detects your terminal app and applies a warmer, more readable theme. Supports Terminal.app, iTerm2, Ghostty, Warp, and Kitty.

<!-- TODO: before/after screenshot -->

## Learn more

Part of a series on Claude Code for non-technical people at [danhopwood.com](https://danhopwood.com).

---

Something not working? [Open an issue](https://github.com/dhpwd/techie/issues) or email <dan@fidero.com>

Check for updates: `/techie:update`

Built by [Dan Hopwood](https://danhopwood.com) · MIT licence
