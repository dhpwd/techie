#!/bin/bash
#
# Techie installer
# Installs Claude Code (if needed) and the Techie plugin.
#
# Usage: curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash
#

set -e

echo ""
echo "  Installing Techie..."
echo ""

# Step 1: Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
  if [ -x "$HOME/.local/bin/claude" ]; then
    echo "  Claude Code found but not on PATH – fixing..."
  else
    echo "  Claude Code not found – installing..."
    curl -fsSL https://claude.ai/install.sh | bash -s stable
    echo ""
  fi
  export PATH="$HOME/.local/bin:$PATH"

  # Verify it worked
  if ! command -v claude &> /dev/null; then
    # Detect shell rc file; default to .zshrc (macOS default)
    case "$(basename "$SHELL")" in
      bash) rc_file=".bashrc" ;;
      *)    rc_file=".zshrc" ;;
    esac
    echo "  Claude Code installed but 'claude' wasn't found on your PATH."
    echo ""
    echo "  Add it manually, then try again:"
    echo "    echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/$rc_file"
    echo "    source ~/$rc_file"
    exit 1
  fi

  echo "  Claude Code installed."
  echo ""
fi

# Step 2: Install the Techie plugin
echo "  Adding Techie plugin..."
if ! claude plugin marketplace add dhpwd/techie 2>&1 | tail -1; then
  echo "  Failed to add marketplace. Check your internet connection and try again."
  exit 1
fi
if ! claude plugin install techie@dhpwd-techie 2>&1 | tail -1; then
  echo "  Failed to install plugin. Try: claude plugin install techie@dhpwd-techie"
  exit 1
fi
echo ""

echo "  Done. Type 'claude' and press Enter to get started."
echo ""
