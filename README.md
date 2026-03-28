# Techie

A Claude Code plugin that gives you a techie – the technical friend who handles complexity so you don't have to.

## Who this is for

Smart non-technical people – founders, operators, knowledge workers – who want the power of Claude Code without the developer-shaped learning curve. You don't need to become technical. You need someone who handles that side of things.

Claude Code gives you things Cowork and the desktop app can't – persistent memory, custom agents that hand off to each other, and a project structure where every piece connects. But it's built for developers. This plugin replaces its interface with one designed for people who have better things to do than learn what a "working directory" is.

## Install

```bash
claude plugin add dhpwd/techie
```

Works in any terminal. On Mac, [Ghostty](https://ghostty.org) is free and looks great out of the box.

## What happens when you start

First time? Type `/setup-theme` to make the window comfortable (bigger text, warmer colours), then `/first-steps` to create your first useful document through a guided conversation. Takes about 10 minutes. The plugin sets up project memory so it remembers everything next time.

When you come back, it picks up where you left off – references what you were working on and suggests a concrete next step. No re-explaining.

<!-- TODO: screenshot of first-run conversation -->

## Skills

Describe what you need in plain English – that works for most things. For specific workflows:

| What you want                      | What to type           |
| ---------------------------------- | ---------------------- |
| Guided first session               | `/first-steps`         |
| Set up project memory              | `/remember`            |
| Start a complex task with guidance | `/consult [your goal]` |
| Learn something by doing           | `/learn [topic]`       |
| Make this window look better       | `/setup-theme`         |
| Explain what just happened         | `/explain`             |
| Quick reference of commands        | `/commands`            |
| Fix something that went wrong      | `/troubleshoot`        |
| Save a checkpoint                  | `/save`                |
| See your save history              | `/history`             |
| Undo recent changes                | `/undo`                |
| Check for plugin updates           | `/update`              |
| Open the getting-started guide     | `/guide`               |

Two skills run automatically in the background: **jargon decoder** translates technical terms inline, and **progress tracker** logs what you've accomplished across sessions.

## Terminal appearance

The default terminal is small text on a black void. `/setup-theme` detects your terminal app and applies a warmer, more readable theme. Supports Terminal.app, iTerm2, Ghostty, Warp, and Kitty.

<!-- TODO: before/after screenshot -->

## Learn more

Part of a series covering setup, first documents, and making Claude remember everything – at [danhopwood.com](https://danhopwood.com).

---

Something not working? [Open an issue](https://github.com/dhpwd/techie/issues) or email <dan@fidero.com>

Check for updates: `/update`

Built by [Dan Hopwood](https://danhopwood.com) · MIT licence
