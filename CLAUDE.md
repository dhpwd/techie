# Techie

A Claude Code plugin that transforms the terminal into an accessible assistant for smart non-technical people.

## Design document

`docs/spec.md` contains architecture decisions, session lifecycle, theme design principles, and testing approach. The implementation files are the source of truth – the design doc captures the rationale behind them.

## How to test

```bash
claude --plugin-dir .
```

This loads the plugin locally. Use `/reload-plugins` to pick up changes without restarting.
