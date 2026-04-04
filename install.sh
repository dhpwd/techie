#!/bin/bash
#
# Techie installer
# Installs Claude Code (if needed) and the Techie plugin.
# No developer tools (git, Xcode) required.
#
# Usage: curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash
#

set -eo pipefail

MARKETPLACE_NAME="dhpwd-techie"
PLUGIN_REF="techie@${MARKETPLACE_NAME}"

echo ""
echo "  Installing Techie..."
echo ""

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Add a line to the shell rc file(s) if it isn't already there.
# For bash: writes to both .bashrc and .bash_profile to cover
# login shells (macOS terminals) and non-login interactive shells.
ensure_in_rc() {
  local line="$1"
  local rc_files=()
  case "$(basename "${SHELL:-/bin/zsh}")" in
    bash) rc_files=("$HOME/.bashrc" "$HOME/.bash_profile") ;;
    *)    rc_files=("$HOME/.zshrc") ;;
  esac
  for rc_file in "${rc_files[@]}"; do
    if ! grep -qF "$line" "$rc_file" 2>/dev/null; then
      printf '\n%s\n' "$line" >> "$rc_file"
    fi
  done
}

# ---------------------------------------------------------------------------
# Step 1 – Claude Code
# ---------------------------------------------------------------------------

if ! command -v claude &> /dev/null; then
  if [ -x "$HOME/.local/bin/claude" ]; then
    echo "  Claude Code found but not on PATH – fixing..."
  else
    echo "  Claude Code not found – installing..."
    curl -fsSL https://claude.ai/install.sh | bash -s stable
    echo ""
  fi

  # Make claude available now (this session) and permanently (rc file)
  export PATH="$HOME/.local/bin:$PATH"
  ensure_in_rc 'export PATH="$HOME/.local/bin:$PATH"'

  if ! command -v claude &> /dev/null; then
    echo "  ✗ Could not find 'claude' after installation."
    echo "    Close this terminal, open a new one, and run this installer again."
    exit 1
  fi

  echo "  Claude Code installed."
  echo ""
fi

# ---------------------------------------------------------------------------
# Step 2 – Techie plugin (downloaded as zip – no git required)
# ---------------------------------------------------------------------------

MARKETPLACE_DIR="$HOME/.claude/marketplaces/$MARKETPLACE_NAME"
ZIP_URL="https://github.com/dhpwd/techie/archive/refs/heads/main.zip"
TMP_ZIP="$(mktemp)"
TMP_DIR="$(mktemp -d)"
trap 'rm -f "$TMP_ZIP"; rm -rf "$TMP_DIR"' EXIT

echo "  Downloading Techie plugin..."
if ! curl -fsSL -o "$TMP_ZIP" "$ZIP_URL"; then
  echo "  ✗ Download failed. Check your internet connection and try again."
  exit 1
fi

if ! unzip -qo "$TMP_ZIP" -d "$TMP_DIR"; then
  echo "  ✗ Failed to extract plugin."
  exit 1
fi

# GitHub zips contain a single top-level directory – find it dynamically
EXTRACTED="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d)"
if [ -z "$EXTRACTED" ] || [ "$(echo "$EXTRACTED" | wc -l)" -ne 1 ]; then
  echo "  ✗ Unexpected archive layout."
  exit 1
fi

rm -rf "$MARKETPLACE_DIR"
mkdir -p "$(dirname "$MARKETPLACE_DIR")"
mv "$EXTRACTED" "$MARKETPLACE_DIR"

echo "  Installing Techie plugin..."

claude plugin marketplace remove "$MARKETPLACE_NAME" 2>/dev/null || true

output="$(claude plugin marketplace add "$MARKETPLACE_DIR" 2>&1)" || {
  echo "  ✗ Failed to register plugin source."
  echo "$output" | tail -3 | sed 's/^/    /'
  exit 1
}

output="$(claude plugin install "$PLUGIN_REF" 2>&1)" || {
  echo "  ✗ Failed to install plugin."
  echo "$output" | tail -3 | sed 's/^/    /'
  exit 1
}
echo ""

echo "  ✅ Done. Type 'claude' and press Enter to get started."
echo ""
