#!/bin/bash
#
# Techie installer
# Installs Claude Code (if needed), the Techie plugin, and configures
# beginner-friendly settings. No developer tools (git, Xcode) required.
#
# Usage:   curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash
# Undo:    curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash -s -- --uninstall
#

set -eo pipefail

# Reconnect stdin to the terminal so the shell remains usable after curl|bash
exec < /dev/tty 2>/dev/null || true

# ---------------------------------------------------------------------------
# Colours
# ---------------------------------------------------------------------------

G='\033[0;32m'  # green
Y='\033[0;33m'  # yellow
C='\033[0;36m'  # cyan
D='\033[0;90m'  # dim
R='\033[0m'     # reset

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

MARKETPLACE_NAME="dhpwd-techie"
PLUGIN_REF="techie@${MARKETPLACE_NAME}"
CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
BACKUP_FILE="$SETTINGS_FILE.techie-backup"
WORKSPACE="$HOME/Workspace"

# ---------------------------------------------------------------------------
# Uninstall
# ---------------------------------------------------------------------------

if [[ "$1" == "--uninstall" ]]; then
  echo ""
  echo -e "  ${C}Uninstalling Techie...${R}"

  # Ensure claude is on PATH (mirrors install path)
  if ! command -v claude &>/dev/null && [ -x "$HOME/.local/bin/claude" ]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi

  # Remove only the keys Techie added, preserving everything else
  if [[ -f "$SETTINGS_FILE" ]]; then
    if command -v jq &>/dev/null; then
      jq '
        # Remove Techie-managed top-level keys
        del(.autoUpdatesChannel, .spinnerTipsEnabled, .spinnerVerbs) |

        # Remove defaultMode if Techie set it
        if .permissions.defaultMode == "acceptEdits" then del(.permissions.defaultMode) else . end |

        # Remove Techie-managed permission entries (keep user-added ones)
        if .permissions.allow then
          .permissions.allow -= [
            "Bash(git status *)","Bash(git diff *)","Bash(git log *)",
            "Bash(git add *)","Bash(git commit *)","Bash(git init *)",
            "Bash(git revert *)","Bash(git rev-parse *)",
            "Bash(ls *)","Bash(echo *)","Bash(uname *)",
            "Bash(cp *)","Bash(mv *)","Bash(mkdir *)",
            "Bash(open *)","Bash(xdg-open *)"
          ]
        else . end |
        if .permissions.deny then
          .permissions.deny -= [
            "Read(.env)","Read(.env.*)","Read(~/.ssh/**)","Read(~/.aws/**)"
          ]
        else . end |

        # Clean up empty structures
        if .permissions.allow == [] then del(.permissions.allow) else . end |
        if .permissions.deny == [] then del(.permissions.deny) else . end |
        if .permissions == {} then del(.permissions) else . end
      ' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp"

      if jq -e '. == {}' "${SETTINGS_FILE}.tmp" &>/dev/null; then
        rm "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
      else
        mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
      fi
      echo -e "  ${G}✓${R} Techie settings removed"

    elif command -v python3 &>/dev/null; then
      python3 - "$SETTINGS_FILE" <<'PYEOF'
import json, sys, os

path = sys.argv[1]
with open(path) as f:
    s = json.load(f)

for k in ("autoUpdatesChannel", "spinnerTipsEnabled", "spinnerVerbs"):
    s.pop(k, None)

techie_allow = {
    "Bash(git status *)","Bash(git diff *)","Bash(git log *)",
    "Bash(git add *)","Bash(git commit *)","Bash(git init *)",
    "Bash(git revert *)","Bash(git rev-parse *)",
    "Bash(ls *)","Bash(echo *)","Bash(uname *)",
    "Bash(cp *)","Bash(mv *)","Bash(mkdir *)",
    "Bash(open *)","Bash(xdg-open *)",
}
techie_deny = {"Read(.env)","Read(.env.*)","Read(~/.ssh/**)","Read(~/.aws/**)"}

perms = s.get("permissions", {})
if perms.get("defaultMode") == "acceptEdits":
    del perms["defaultMode"]
if "allow" in perms:
    perms["allow"] = [x for x in perms["allow"] if x not in techie_allow]
    if not perms["allow"]:
        del perms["allow"]
if "deny" in perms:
    perms["deny"] = [x for x in perms["deny"] if x not in techie_deny]
    if not perms["deny"]:
        del perms["deny"]
if not perms:
    s.pop("permissions", None)

if s:
    with open(path, "w") as f:
        json.dump(s, f, indent=2)
        f.write("\n")
else:
    os.remove(path)
PYEOF
      echo -e "  ${G}✓${R} Techie settings removed"

    else
      echo -e "  ${Y}!${R} Could not clean settings (need jq or python3)."
      echo -e "    Install jq (${C}brew install jq${R}) then re-run the uninstaller,"
      echo -e "    or delete ${D}$SETTINGS_FILE${R} if you have no other Claude Code settings."
    fi
  fi

  rm -f "$BACKUP_FILE"

  # Remove plugin
  if command -v claude &>/dev/null; then
    claude plugin uninstall "$PLUGIN_REF" 2>/dev/null || true
    claude plugin marketplace remove "$MARKETPLACE_NAME" 2>/dev/null || true
  fi
  rm -rf "$CLAUDE_DIR/marketplaces/$MARKETPLACE_NAME" 2>/dev/null || true
  echo -e "  ${G}✓${R} Plugin removed"

  echo ""
  echo -e "  ${G}Done.${R} Techie has been removed."
  echo -e "  ${D}Your workspace folder (~/${WORKSPACE##*/}) was not removed.${R}"
  echo ""
  exit 0
fi

# ---------------------------------------------------------------------------
# Welcome
# ---------------------------------------------------------------------------

echo ""
echo -e "  ${C}Installing Techie...${R}"
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
    zsh)  rc_files=("$HOME/.zshrc") ;;
    *)    return 0 ;;  # unsupported shell – skip rc write, session export is enough
  esac
  for rc_file in "${rc_files[@]}"; do
    if ! grep -qF "$line" "$rc_file" 2>/dev/null; then
      printf '\n%s\n' "$line" >> "$rc_file"
    fi
  done
}

# Merge settings into Claude Code's settings.json without overwriting
# existing keys (except the ones we explicitly set). Requires jq or python3.
merge_settings() {
  local open_cmd="Bash(open *)"
  [[ "$(uname)" != "Darwin" ]] && open_cmd="Bash(xdg-open *)"

  local permissions_allow
  permissions_allow=$(cat <<EOF
["Bash(git status *)","Bash(git diff *)","Bash(git log *)","Bash(git add *)","Bash(git commit *)","Bash(git init *)","Bash(git revert *)","Bash(git rev-parse *)","Bash(ls *)","Bash(echo *)","Bash(uname *)","Bash(cp *)","Bash(mv *)","Bash(mkdir *)","$open_cmd"]
EOF
  )
  local permissions_deny='["Read(.env)","Read(.env.*)","Read(~/.ssh/**)","Read(~/.aws/**)"]'

  local spinner_verbs='["Pondering","Brewing","Cooking up","Noodling on","Rustling up","Spelunking","Rummaging through","Hatching","Whipping up","Tinkering with","Percolating","Marinating on","Pivoting","Disrupting","Synergising with","Leveraging","Circling back to","Aligning stakeholders on","Moving the needle on","Blue-skying","Deep-diving into","Taking offline","Boiling the ocean","Zooming out on","Considering whether this scales","Putting a pin in","Parking","Workshopping","Running it up the flagpole"]'

  if command -v jq &>/dev/null; then
    local existing="{}"
    if [[ -f "$SETTINGS_FILE" ]]; then
      existing=$(cat "$SETTINGS_FILE")
    fi

    echo "$existing" | jq \
      --argjson pa "$permissions_allow" \
      --argjson pd "$permissions_deny" \
      --argjson sv "$spinner_verbs" \
      '
      # Merge permissions – deduplicate, set default mode
      .permissions.defaultMode = "acceptEdits" |
      .permissions.allow = ((.permissions.allow // []) + $pa | unique | sort) |
      .permissions.deny = ((.permissions.deny // []) + $pd | unique | sort) |

      # Spinner and updates
      .autoUpdatesChannel = "stable" |
      .spinnerTipsEnabled = false |
      .spinnerVerbs = {"mode": "replace", "verbs": $sv}
      ' > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"

  elif command -v python3 &>/dev/null; then
    python3 - "$SETTINGS_FILE" "$permissions_allow" "$permissions_deny" "$spinner_verbs" <<'PYEOF'
import json, sys, os

settings_path = sys.argv[1]
pa = json.loads(sys.argv[2])
pd = json.loads(sys.argv[3])
sv = json.loads(sys.argv[4])

settings = {}
if os.path.exists(settings_path):
    with open(settings_path) as f:
        settings = json.load(f)

perms = settings.setdefault("permissions", {})
perms["defaultMode"] = "acceptEdits"
existing_allow = perms.get("allow", [])
existing_deny = perms.get("deny", [])
perms["allow"] = sorted(set(existing_allow + pa))
perms["deny"] = sorted(set(existing_deny + pd))

settings["autoUpdatesChannel"] = "stable"
settings["spinnerTipsEnabled"] = False
settings["spinnerVerbs"] = {"mode": "replace", "verbs": sv}

tmp_path = settings_path + ".tmp"
with open(tmp_path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")
os.rename(tmp_path, settings_path)
PYEOF
  else
    echo -e "  ${Y}!${R} Could not configure settings (need jq or python3)."
    echo -e "    Run ${C}/setup-theme${R} inside Claude Code to configure manually."
    return 1
  fi
}

# ---------------------------------------------------------------------------
# Step 1 – Claude Code
# ---------------------------------------------------------------------------

CC_NEEDS_NEW_TERMINAL=false

if ! command -v claude &> /dev/null; then
  if [ -x "$HOME/.local/bin/claude" ]; then
    echo -e "  ${D}Claude Code found but not on PATH – fixing...${R}"
  else
    echo -e "  ${D}Claude Code not found – installing...${R}"
    curl -fsSL https://claude.ai/install.sh | bash -s stable
    echo ""
  fi

  # Make claude available now (this session) and permanently (rc file)
  export PATH="$HOME/.local/bin:$PATH"
  ensure_in_rc 'export PATH="$HOME/.local/bin:$PATH"'

  if ! command -v claude &> /dev/null; then
    echo -e "  ${Y}✗${R} Could not find 'claude' after installation."
    echo "    Close this terminal, open a new one, and run this installer again."
    exit 1
  fi

  CC_NEEDS_NEW_TERMINAL=true

  echo -e "  ${G}✓${R} Claude Code installed"
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

echo -e "  ${D}Downloading Techie plugin...${R}"
if ! curl -fsSL -o "$TMP_ZIP" "$ZIP_URL"; then
  echo -e "  ${Y}✗${R} Download failed. Check your internet connection and try again."
  exit 1
fi

if ! unzip -qo "$TMP_ZIP" -d "$TMP_DIR"; then
  echo -e "  ${Y}✗${R} Failed to extract plugin."
  exit 1
fi

# GitHub zips contain a single top-level directory – find it dynamically
EXTRACTED="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d)"
if [ -z "$EXTRACTED" ] || [ "$(echo "$EXTRACTED" | wc -l)" -ne 1 ]; then
  echo -e "  ${Y}✗${R} Unexpected archive layout."
  exit 1
fi

rm -rf "$MARKETPLACE_DIR"
mkdir -p "$(dirname "$MARKETPLACE_DIR")"
mv "$EXTRACTED" "$MARKETPLACE_DIR"

echo -e "  ${D}Installing plugin...${R}"

claude plugin marketplace remove "$MARKETPLACE_NAME" 2>/dev/null || true

output="$(claude plugin marketplace add "$MARKETPLACE_DIR" 2>&1)" || {
  echo -e "  ${Y}✗${R} Failed to register plugin source."
  echo "$output" | tail -3 | sed 's/^/    /'
  exit 1
}

output="$(claude plugin install "$PLUGIN_REF" 2>&1)" || {
  echo -e "  ${Y}✗${R} Failed to install plugin."
  echo "$output" | tail -3 | sed 's/^/    /'
  exit 1
}

echo -e "  ${G}✓${R} Plugin installed"

# ---------------------------------------------------------------------------
# Step 3 – Configure settings (permissions, spinner, updates)
# ---------------------------------------------------------------------------

echo -e "  ${D}Configuring settings...${R}"

if [[ -f "$SETTINGS_FILE" ]]; then
  cp "$SETTINGS_FILE" "$BACKUP_FILE"
fi

if merge_settings; then
  echo -e "  ${G}✓${R} Settings configured"
fi

# ---------------------------------------------------------------------------
# Step 4 – Create workspace folder
# ---------------------------------------------------------------------------

if [[ ! -d "$WORKSPACE" ]]; then
  mkdir -p "$WORKSPACE"
  echo -e "  ${G}✓${R} Created workspace folder at ~/${WORKSPACE##*/}"
else
  echo -e "  ${D}Workspace folder already exists at ~/${WORKSPACE##*/}${R}"
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo -e "  ${G}All done!${R}"
echo ""

if [[ "$CC_NEEDS_NEW_TERMINAL" == true ]]; then
  echo -e "  Claude Code was just installed. Open a fresh terminal to make it available:"
  echo -e "  ${D}(Spotlight: press Cmd+Space, type Terminal, press Enter)${R}"
  echo ""
  echo -e "  Then type these two commands, pressing Enter after each:"
else
  echo -e "  Type these two commands, pressing Enter after each:"
fi

echo ""
echo -e "    ${C}cd ${WORKSPACE##*/}${R}"
echo -e "    ${C}claude${R}"
echo ""
echo -e "  ${D}To undo everything later:${R}"
echo -e "  ${D}curl -fsSL https://raw.githubusercontent.com/dhpwd/techie/main/install.sh | bash -s -- --uninstall${R}"
echo ""
