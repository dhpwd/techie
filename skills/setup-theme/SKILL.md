---
name: setup-theme
description: Make this window easier on the eyes – bigger text, nicer colours, less intimidating. Detects your terminal and applies changes automatically where possible.
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
  - Write
---

# Terminal appearance setup

The user wants to make their terminal less visually hostile. This is a real barrier – people physically struggle with small monospace text on dark backgrounds with no visual hierarchy. Take it seriously.

## Step 1: Detect their environment

```bash
echo "OS: $(uname -s)"
echo "Shell: $SHELL"
echo "Term Program: ${TERM_PROGRAM:-unknown}"
echo "Term: $TERM"
```

Tell them what you found: "You're using [terminal app] on [OS]."

## Step 2: Suggest Ghostty (Mac + Terminal.app only)

If they're on macOS and using Terminal.app, suggest Ghostty before doing any theming: "Before I change anything here, there's a free app called Ghostty (ghostty.org) that looks much nicer – softer fonts, cleaner design. Want to try it? If not, I'll make this one look better."

If they want Ghostty: guide them to download from ghostty.org, open it, type `claude` to start a new session, then run `/setup-theme` again from Ghostty. Done – skip the Terminal.app theming entirely.

If they decline or they're not on Terminal.app: continue to Step 3.

## Step 3: Ask light or dark

"Do you prefer a light background (easier on the eyes in daylight) or dark?" Default to light if they're unsure.

The plugin bundles light and dark variants. Use the light files by default (`techie-light.*`) or the dark files if they prefer (`techie-dark.*`). Substitute the correct file names in the steps below. For Terminal.app, the profile name matches the filename without extension – `techie-light` or `techie-dark`.

## Step 4: Apply the theme automatically where possible

Try the programmatic approach first. Fall back to manual instructions only where automation isn't possible.

### macOS Terminal.app

**Colour scheme and font** – import and apply via AppleScript:

```bash
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-light.terminal" "/tmp/techie-light.terminal"
open "/tmp/techie-light.terminal"
sleep 2
osascript -e '
tell application "Terminal"
  if (count of windows) > 1 then close front window
  set targetProfile to settings set "techie-light"
  set current settings of front window to targetProfile
  set default settings to targetProfile
end tell
'
```

Run this as a single Bash command – do not split it into separate tool calls. The `sleep 2` gives Terminal time to register the profile before AppleScript references it.

If AppleScript fails, fall back to manual: "Open Terminal → Settings → Profiles → select techie-light → click Default."

### macOS iTerm2

**Colour scheme** – import and apply via AppleScript:

```bash
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-light.itermcolors" "/tmp/techie-light.itermcolors"
open "/tmp/techie-light.itermcolors"
sleep 1
osascript -e 'tell application "iTerm2" to tell current session of current window to set color preset to "Techie"'
```

**Font size** – manual: Cmd+, → Profiles → Text → size 15. Recommend JetBrains Mono, Fira Code, or Menlo.

### Ghostty

Install our custom theme and activate it.

```bash
mkdir -p "$HOME/.config/ghostty/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-light-ghostty" "$HOME/.config/ghostty/themes/techie"
```

Then find the Ghostty config file (check `~/Library/Application Support/com.mitchellh.ghostty/config` first on macOS, fall back to `~/.config/ghostty/config`). Add `theme = techie` and `font-size = 15`. If no config file exists, create one at `~/.config/ghostty/config`.

Tell the user: "I've set up the theme. Type `/exit`, then press Cmd+Shift+Comma to refresh the colours, then type `claude -c` to pick up where we left off."

If they don't like the warm light theme, offer alternatives. Run `ghostty +list-themes` to get available themes, suggest a few that match what they're after, and swap by changing the `theme` line in the config. They'll need to `/exit` and press `Cmd+Shift+Comma` then `claude -c` to see the change.

### Warp / Kitty

Copy theme files to the standard locations:

```bash
# Warp
mkdir -p "$HOME/.warp/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-light-warp.yaml" "$HOME/.warp/themes/techie.yaml"

# Kitty
mkdir -p "$HOME/.config/kitty/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-light-kitty.conf" "$HOME/.config/kitty/themes/techie.conf"
```

Then tell the user how to activate in their app's settings.

### Windows Terminal

**Programmatic not possible** – walk them through manually:

1. Click the down arrow next to the tabs → Settings
2. Under Profiles, click default profile → Appearance
3. Font size: 15 (Cascadia Code is already installed and excellent)
4. Colour scheme: try "One Half Light" for light, or "One Half Dark" for softer dark

### Any other terminal

Fall back to manual instructions. The two changes that matter most: (1) font size to 15, (2) a lighter or higher-contrast colour scheme.

## Step 5: Match the Claude Code theme

The terminal theme controls the window. Claude Code also has its own text theme (syntax colours, diffs). These should match.

Tell the user: "One more thing – I also need to match the text colours inside this window. Type `/config`, scroll down to Theme, press Space, and choose the one that matches your background (Light mode if you went light, Dark mode if you went dark). You'll see a preview so you can pick what looks best."

If they chose a light terminal theme, recommend "Light mode". If dark, recommend "Dark mode". Mention the colorblind-friendly options exist if relevant.

## Step 6: Confirm and adjust

After applying: "How does that look? Better? We can adjust further – larger font, different colours, whatever works for you."

If they're still uncomfortable: even larger font (18-20 isn't unusual), swap light/dark, increase line spacing if available.

## Step 7: Configure environment settings

Tell the user: "I'm going to configure a couple of things to make this work better for you. You'll see a permission prompt with some technical-looking changes – choose Yes."

Then, in **one edit** to `~/.claude/settings.json` (preserving existing keys), merge:

- **Stable updates** – `"autoUpdatesChannel": "stable"`
- **Disable spinner tips** – `"spinnerTipsEnabled": false` (default tips are developer-oriented)
- **Spinner verbs** – `"spinnerVerbs": {"mode": "replace", "verbs": ["Pondering", "Brewing", "Cooking up", "Noodling on", "Rustling up", "Spelunking", "Rummaging through", "Hatching", "Whipping up", "Tinkering with", "Percolating", "Marinating on", "Pivoting", "Disrupting", "Synergising with", "Leveraging", "Circling back to", "Aligning stakeholders on", "Moving the needle on", "Blue-skying", "Deep-diving into", "Taking offline", "Boiling the ocean", "Zooming out on", "Considering whether this scales", "Putting a pin in", "Parking", "Workshopping", "Running it up the flagpole"]}`

After the user approves: "Done. I've made the loading messages a bit more fun and set updates to a stable channel so nothing changes unexpectedly. These settings are saved permanently – type `/setup-theme` any time to adjust.

To pick up the new settings, `/exit` then run `claude` to start a fresh session."
