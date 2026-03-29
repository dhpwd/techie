---
name: report
description: Report a bug or suggest an improvement. Opens a short form with the technical details pre-filled.
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
---

# Feedback

The user wants to share feedback, report a bug, or suggest an improvement.

## Steps

1. Detect their environment silently:

```bash
RAW_OS=$(uname -s)
case "$RAW_OS" in
  Darwin*) OS="macOS" ;;
  Linux*)  OS="Linux" ;;
  MINGW*|MSYS*|CYGWIN*) OS="Windows" ;;
  *) OS="$RAW_OS" ;;
esac
echo "OS: $OS"
echo "Terminal: ${TERM_PROGRAM:-unknown}"
```

2. Read the plugin version from `${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json` (the `version` field). If the file isn't found, use "unknown".

3. URL-encode the detected values (replace spaces with `%20`). Build the form URL:

```
https://docs.google.com/forms/d/e/1FAIpQLSfHXXL9u8fRp28uXSn4dh6yZ-UNHbV4m8h80I--3NQrqRrTSw/viewform?usp=pp_url&entry.221684436=OS_VALUE&entry.1629691851=TERMINAL_VALUE&entry.493720977=VERSION_VALUE
```

4. Open the URL in their browser (`open` on macOS, `xdg-open` on Linux, `start` on Windows).

5. Tell the user: "I've opened a short feedback form in your browser. The technical details are already filled in – pick a category and describe what's on your mind."

6. If the conversation already contains a description of the issue (e.g. they ran `/troubleshoot` or described a problem), add: "You can copy what you told me into the form, or describe it fresh – whatever's easier."

## Rules

- Don't show the URL or any technical details to the user
- Don't ask questions before opening the form – the form handles collection
- Keep the confirmation to two sentences maximum
