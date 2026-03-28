# Techie

A Claude Code plugin that transforms the terminal into an accessible assistant for smart non-technical people.

## Build spec

The complete specification is at `docs/spec.md`. Read it before starting any work. It contains:

- Plugin structure and manifest
- Main-thread agent definition (full system prompt)
- Output style (lighter alternative)
- 14 skills with complete SKILL.md content
- Terminal theme design principles
- README structure
- Implementation notes with build order and testing approach

**The spec is the source of truth.** Build exactly what it describes. When in doubt, re-read the relevant section.

## How to test

```
claude --plugin-dir .
```

This loads the plugin locally. Use `/reload-plugins` to pick up changes without restarting.
