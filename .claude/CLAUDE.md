# Techie

A Claude Code plugin that transforms the terminal into an accessible assistant for smart non-technical people.

## Design document

`docs/spec.md` contains architecture decisions, session lifecycle, theme design principles, and testing approach. The implementation files are the source of truth – the design doc captures the rationale behind them.

## How to test

```bash
claude --plugin-dir .
```

This loads the plugin locally. Use `/reload-plugins` to pick up changes without restarting.

## Working conventions

- Markdown is the product here: `agents/agent.md`, `skills/*/SKILL.md` and `install.sh` are executable behaviour, not documentation. There is no CI and no PR gate – pushing to `main` is releasing, because installs and updates pull straight from it. Push only complete, reviewed work, and only on an explicit go-ahead
- From a worktree branch, land changes with `git push origin HEAD:main` rather than merging locally – the `main` checkout may be in use by another session. Push only when the branch holds nothing but the intended commits
- Before pushing substantive changes, test them locally (`claude --plugin-dir .`) – the manual flows are in `docs/spec.md`
- A change that alters a decision recorded in `docs/spec.md` updates the spec in the same commit
- Work that won't be done now (follow-ups, deferred trade-offs, bugs): propose a Linear ticket in chat, create it only on an explicit go-ahead
- If user-facing behaviour changes (install, skills, prompts copy), check `README.md` and the companion blog posts for stale claims before release
