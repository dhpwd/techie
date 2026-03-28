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

If they want Ghostty: guide them to download from ghostty.org, open it, type `claude` to start a new session, then run `/techie:setup-theme` again from Ghostty. Done – skip the Terminal.app theming entirely.

If they decline or they're not on Terminal.app: continue to Step 3.

## Step 3: Apply the theme automatically where possible

The plugin bundles its own theme files at `${CLAUDE_PLUGIN_ROOT}/themes/`. Try the programmatic approach first. Fall back to manual instructions only where automation isn't possible.

### macOS Terminal.app

**Colour scheme** – import and apply via AppleScript (changes the current window live):

```bash
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie.terminal" "/tmp/techie.terminal"
open "/tmp/techie.terminal"
sleep 2
osascript -e '
tell application "Terminal"
  if (count of windows) > 1 then close front window
  set targetProfile to settings set "Techie"
  set current settings of front window to targetProfile
  set default settings to targetProfile
end tell
'
```

If AppleScript fails, fall back to manual: "Open Terminal → Settings → Profiles → pick a lighter theme."

**Font** – the theme file sets Menlo 15pt automatically. If they want a different size, walk them through: Cmd+, → Profiles → Text → Font → Change.

### macOS iTerm2

**Colour scheme** – import and apply via AppleScript:

```bash
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie.itermcolors" "/tmp/techie.itermcolors"
open "/tmp/techie.itermcolors"
sleep 1
osascript -e 'tell application "iTerm2" to tell current session of current window to set color preset to "Techie"'
```

**Font size** – manual: Cmd+, → Profiles → Text → size 15. Recommend JetBrains Mono, Fira Code, or Menlo.

### Ghostty

Install our custom theme and activate it.

```bash
mkdir -p "$HOME/.config/ghostty/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-ghostty" "$HOME/.config/ghostty/themes/techie"
```

Then find the Ghostty config file (check `~/Library/Application Support/com.mitchellh.ghostty/config` first on macOS, fall back to `~/.config/ghostty/config`). Add `theme = techie` and `font-size = 15`. If no config file exists, create one at `~/.config/ghostty/config`.

Tell the user: "I've set up the theme. Type `/exit`, then press Cmd+Shift+Comma to refresh the colours, then type `claude -c` to pick up where we left off."

If they don't like the warm light theme, offer alternatives. Run `ghostty +list-themes` to get available themes, suggest a few that match what they're after, and swap by changing the `theme` line in the config. They'll need to `/exit` and press `Cmd+Shift+Comma` then `claude -c` to see the change.

### Warp / Kitty

Copy theme files to the standard locations:

```bash
# Warp
mkdir -p "$HOME/.warp/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-warp.yaml" "$HOME/.warp/themes/techie.yaml"

# Kitty
mkdir -p "$HOME/.config/kitty/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-kitty.conf" "$HOME/.config/kitty/themes/techie.conf"
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

## Step 4: Match the Claude Code theme

The terminal theme controls the window. Claude Code also has its own text theme (syntax colours, diffs). These should match.

Tell the user: "One more thing – I also need to match the text colours inside this window. Type `/config`, scroll down to Theme, press Space, and choose the one that matches your background (Light mode if you went light, Dark mode if you went dark). You'll see a preview so you can pick what looks best."

If they chose a light terminal theme, recommend "Light mode". If dark, recommend "Dark mode". Mention the colorblind-friendly options exist if relevant.

## Step 5: Confirm and adjust

After applying: "How does that look? Better? We can adjust further – larger font, different colours, whatever works for you."

If they're still uncomfortable: even larger font (18-20 isn't unusual), swap light/dark, increase line spacing if available.

## Step 6: Note for future

"These settings are saved permanently. If you ever want to adjust again, just type `/techie:setup-theme`."
