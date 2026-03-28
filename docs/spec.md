# Techie – design document

Architecture decisions, session lifecycle, and design rationale for the Techie plugin. For current behaviour, read the implementation files directly – they are the source of truth.

**Author:** Dan Hopwood
**Licence:** MIT
**Target audience:** Smart non-technical people – founders, operators, knowledge workers – who want the compounding power of Claude Code without the developer-shaped learning curve

### Key references

- [Plugins](https://code.claude.com/docs/en/plugins.md) – creating plugins, directory structure, manifest
- [Plugins reference](https://code.claude.com/docs/en/plugins-reference.md) – complete technical spec (schemas, CLI commands, hook events, environment variables)
- [Skills](https://code.claude.com/docs/en/skills.md) – SKILL.md format, frontmatter fields, invocation control, arguments
- [Subagents](https://code.claude.com/docs/en/sub-agents.md) – agent definitions, `initialPrompt`, `memory`, preloaded skills, main-thread agent
- [Output styles](https://code.claude.com/docs/en/output-styles.md) – custom output style format
- [Plugin marketplaces](https://code.claude.com/docs/en/plugin-marketplaces.md) – distribution and marketplace setup
- `~/Vaults/Fidero/Reference/Non-Coding Agentic Workflows.md` – the "core context pattern" for CLAUDE.md in knowledge-work projects (internal, not published)
- `~/Vaults/Fidero/Reference/Non-Technical Guide Approach.md` – voice and structure principles for the target audience (internal, not published)

---

## Plugin structure

```
techie/
├── .claude-plugin/
│   └── plugin.json
├── settings.json
├── agents/
│   └── techie.md
├── themes/
│   ├── techie-light.terminal
│   ├── techie-light.itermcolors
│   ├── techie-light-ghostty
│   ├── techie-light-warp.yaml
│   ├── techie-light-kitty.conf
│   ├── techie-dark.terminal
│   ├── techie-dark.itermcolors
│   ├── techie-dark-ghostty
│   ├── techie-dark-warp.yaml
│   └── techie-dark-kitty.conf
└── skills/
    ├── first-steps/
    ├── remember/
    ├── consult/
    ├── learn/
    ├── setup-theme/
    ├── explain/
    ├── commands/
    ├── troubleshoot/
    ├── save/
    ├── history/
    ├── undo/
    ├── update/
    ├── guide/
    ├── jargon-decoder/
    └── progress-tracker/
```

---

## Architecture decisions

### Agent activation

`settings.json` uses `"agent": "techie:techie"` (plugin-namespaced). The unnamespaced `"techie"` does not activate the agent as main thread – this is a Claude Code plugin requirement.

### Preloading

Only model-invoked skills (`jargon-decoder`, `progress-tracker`) are listed in the agent's `skills` frontmatter. Preloading injects full skill content into context at startup – adding user-invoked skills would waste context window space and override their `disable-model-invocation: true` setting.

### `initialPrompt`

Not supported for plugin-shipped agents. The agent's system prompt contains first-run detection instructions that fire when the user sends their first message. The blog post guides users to type `/first-steps` directly.

---

## Known limitations and workarounds

| Limitation                                                                                  | Workaround                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `initialPrompt` not supported for plugin agents                                             | Agent system prompt handles first-run detection on first user message; blog post guides users to type `/first-steps`                                                       |
| `settings.json` `agent` key requires plugin-namespaced name (`techie:techie`, not `techie`) | Discovered empirically – not documented in Claude Code docs                                                                                                                |
| Terminal.app profile names derive from filename, not the plist `name` field                 | AppleScript references `techie-light` / `techie-dark` (matching filenames), not `Techie Light`                                                                             |
| Terminal.app theme import opens a new window                                                | `open` + `sleep 2` + AppleScript to close import window and apply to original. Must run as single Bash command – agent splits multi-step commands into separate tool calls |
| Plugin agents cannot use `hooks`, `mcpServers`, or `permissionMode` frontmatter             | Copy agent to `.claude/agents/` if these are needed (official workaround)                                                                                                  |

---

## Session lifecycle

How the skills relate to each other across a user's journey:

| When                             | What happens                                      | Mechanism                                     |
| -------------------------------- | ------------------------------------------------- | --------------------------------------------- |
| First session (empty workspace)  | Guided setup: create first document + CLAUDE.md   | `/first-steps` (includes memory setup)        |
| First session (existing project) | Survey files, create CLAUDE.md from what's here   | `/remember` (offered by first-run detection)  |
| Returning session                | Greet, reference previous work, suggest next step | Agent prompt (reads CLAUDE.md)                |
| Occasionally, as workspace grows | Update CLAUDE.md with new key documents           | `/remember` (user runs manually)              |
| End of every session             | Log what was accomplished                         | `progress-tracker` (model-invoked, automatic) |

**Key distinction:** `remember` is for **project setup** (teach Claude about the workspace – mostly one-time, occasionally re-run). `progress-tracker` is for **session bookkeeping** (log what happened – automatic, every session).

**Retention note:** The returning-session behaviour is the primary retention mechanism. The moment a user experiences continuity – Claude remembering what they worked on and suggesting a concrete next step – is the moment CC's value over Cowork clicks. Sessions 2–5 are where this is won or lost.

---

## Skill reference

| Skill              | Type          | Purpose                                                            |
| ------------------ | ------------- | ------------------------------------------------------------------ |
| `first-steps`      | User-invoked  | Guided first session – creates a strategy doc through conversation |
| `remember`         | User-invoked  | Set up or update project memory (CLAUDE.md) for any workspace      |
| `consult`          | User-invoked  | Guided questions before executing any complex task                 |
| `learn`            | User-invoked  | Interactive concept learning by doing                              |
| `setup-theme`      | User-invoked  | Terminal appearance customisation (fonts, colours, contrast)       |
| `explain`          | User-invoked  | Scaffolded explanation from plain English to full technical detail |
| `commands`         | User-invoked  | Context-aware quick reference of what the user can do              |
| `troubleshoot`     | User-invoked  | Error diagnosis and fix in plain language                          |
| `save`             | User-invoked  | Save a checkpoint of current work (git add + commit)               |
| `history`          | User-invoked  | Show save history in plain English                                 |
| `undo`             | User-invoked  | Undo recent changes                                                |
| `update`           | User-invoked  | Check for and install plugin updates                               |
| `guide`            | User-invoked  | Open the companion getting-started guide                           |
| `jargon-decoder`   | Model-invoked | Auto-translates jargon inline as responses are generated           |
| `progress-tracker` | Model-invoked | Maintains a progress file showing compounding value over time      |

---

## Theme design principles

The plugin ships light and dark themes for each supported terminal (Terminal.app, iTerm2, Ghostty, Warp, Kitty).

- **Warm, not clinical** – soft background (warm off-white `#FAF8F5` for light; deep cool dark `#14191F` for dark), avoiding the "black void" that the WhatsApp group complained about
- **High contrast text** – body text clearly readable at 15pt without squinting
- **Distinct visual hierarchy** – headings, code, and emphasis should be visually distinguishable without relying on subtle shade differences
- **Two variants** – light (`techie-light.*`) and dark (`techie-dark.*`) for each terminal. Default to light (the "parchment" effect non-technical users respond to), offer dark as an option

---

## One-command installer

**Status: not yet built**

**File:** `install.sh` (repo root, not inside the plugin structure)

A single paste-and-go command for blog posts and WhatsApp seeds. Eliminates the chicken-and-egg problem – installs CC if missing, then installs the plugin.

```bash
curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash
```

The script should:

1. Check if Claude Code is installed; if not, install it (`curl -fsSL https://claude.ai/install.sh | bash`)
2. Install the techie plugin (`claude plugin install techie@dhpwd`)
3. Print a clear "done" message: "Type `claude` and press Enter to get started"

Keep the output friendly – coloured status messages, no jargon, no raw error dumps. Match the plugin's voice.

---

## Implementation notes

### Testing approach

- **Test first-run detection** – say "hello" in a clean directory with no CLAUDE.md. Verify the agent greets and prompts for `/first-steps`
- Test first-run flow on a clean directory with no CLAUDE.md
- Test returning-session flow with existing CLAUDE.md – verify it references previous work and suggests a next step
- Test the second and third sessions specifically – these are where retention is won or lost
- Test each skill independently
- Test with 3-5 non-technical people from the Foundrs AI Chat group before public launch. Observe where they hesitate, what confuses them, what they skip. One round of iteration with feedback
- Record a first-session video for the README

### Iteration signals

Things to watch for after launch:

- Which skills get used most (prioritise improvements there)
- Where users get stuck in the first-run flow
- Which jargon terms come up repeatedly (add to decoder)
- Whether the progress tracker feels useful or ignorable
- Terminal appearance complaints that the setup skill doesn't cover
