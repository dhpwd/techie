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

Tell them what you found: "You're using [terminal app] on [OS]. Let me make it more comfortable."

## Step 2: Apply the theme automatically where possible

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

**Font size** – must be manual (no API). Walk them through: Cmd+, → Profiles → Text → Font → Change → size 14-16. Recommend Menlo or SF Mono.

### macOS iTerm2

**Colour scheme** – import and apply via AppleScript:

```bash
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie.itermcolors" "/tmp/techie.itermcolors"
open "/tmp/techie.itermcolors"
sleep 1
osascript -e 'tell application "iTerm2" to tell current session of current window to set color preset to "Techie"'
```

**Font size** – manual: Cmd+, → Profiles → Text → size 14-16. Recommend JetBrains Mono, Fira Code, or Menlo.

### Ghostty

**Theme file** – copy to Ghostty's themes directory:

```bash
mkdir -p "$HOME/.config/ghostty/themes"
cp "${CLAUDE_PLUGIN_ROOT}/themes/techie-ghostty" "$HOME/.config/ghostty/themes/techie"
```

Then: "I've installed the theme. To activate it, add `theme = techie` to your Ghostty config, or ask me to do it."

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
3. Font size: 14-16 (Cascadia Code is already installed and excellent)
4. Colour scheme: try "One Half Light" for light, or "One Half Dark" for softer dark

### Any other terminal

Fall back to manual instructions. The two changes that matter most: (1) font size to 14-16, (2) a lighter or higher-contrast colour scheme.

## Step 3: Match the Claude Code theme

The terminal theme controls the window. Claude Code also has its own text theme (syntax colours, diffs). These should match.

Tell the user: "One more thing – I also need to match the text colours inside this window. Type `/config`, scroll down to Theme, press Space, and choose the one that matches your background (Light mode if you went light, Dark mode if you went dark). You'll see a preview so you can pick what looks best."

If they chose a light terminal theme, recommend "Light mode". If dark, recommend "Dark mode". Mention the colorblind-friendly options exist if relevant.

## Step 4: Confirm and suggest terminal upgrade (if applicable)

After applying: "How does that look? Better? We can adjust further – larger font, different colours, whatever works for you."

If they're still uncomfortable: even larger font (18-20 isn't unusual), swap light/dark, increase line spacing if available.

If they're using Terminal.app or default Windows Terminal and still finding it uncomfortable, suggest upgrading the app itself: "These settings help, but the app you're using has limits. Warp (warp.dev) is a free terminal app designed to be friendlier – it organises output into blocks instead of an endless scroll, and the clipboard works the way you'd expect. Takes 2 minutes to install. Everything we've set up here transfers." Only suggest once. Don't push.

If they install Warp, guide them through onboarding choices:

- Theme: choose **"Light"** (warm, readable – matches our design goals)
- Plan: choose **"Classic terminal with third-party agents"** (Free) – not the $18/mo agent option. They're using Claude Code, not Warp's built-in agent
- Natural language detection: **skip it** (leave unchecked) – it autodetects plain English input and routes to Warp's own agent, which conflicts with Claude Code

## Step 5: Note for future

"These settings are saved permanently. If you ever want to adjust again, just type `/techie:setup-theme`."
