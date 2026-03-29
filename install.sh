#!/bin/bash
#
# Techie installer
# Installs Claude Code (if needed) and the techie plugin.
#
# Usage: curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash
#

set -e

echo ""
echo "  Installing techie..."
echo ""

# Step 1: Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
  echo "  Claude Code not found – installing..."
  curl -fsSL https://claude.ai/install.sh | bash -s stable
  echo ""

  # Verify it worked
  if ! command -v claude &> /dev/null; then
    echo "  Claude Code installation failed. Install it manually:"
    echo "  https://code.claude.com/docs/en/quickstart"
    exit 1
  fi

  echo "  Claude Code installed."
  echo ""
fi

# Step 2: Install the techie plugin
echo "  Adding techie plugin..."
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
