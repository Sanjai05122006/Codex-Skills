#!/usr/bin/env bash
# ============================================================
# Claude Code — Project Skills Setup
#
# Usage:
#   bash install-claude.sh
#
# Downloads the latest skills from GitHub and installs them
# into .claude/skills in the current project.
# ============================================================

set -Eeuo pipefail

REPO_URL="https://github.com/Sanjai05122006/Codex-Skills.git"
SKILLS_SRC=".codex/skills"
SKILLS_DEST=".claude/skills"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
RESET='\033[0m'

info()    { echo -e "${CYAN}ℹ  $*${RESET}"; }
success() { echo -e "${GREEN}✔  $*${RESET}"; }
warn()    { echo -e "${YELLOW}⚠  $*${RESET}"; }
error()   { echo -e "${RED}✖  $*${RESET}" >&2; exit 1; }

echo
echo -e "${BOLD}╔══════════════════════════════════════════╗"
echo -e "║  Claude Code — Project Skills Setup      ║"
echo -e "╚══════════════════════════════════════════╝${RESET}"
echo

# ------------------------------------------------------------
# Check required commands
# ------------------------------------------------------------

for cmd in git find cp mktemp; do
    command -v "$cmd" >/dev/null 2>&1 || error "'$cmd' is required but not installed."
done

# ------------------------------------------------------------
# Verify project
# ------------------------------------------------------------

if ! [[ \
    -d ".git" || \
    -f "package.json" || \
    -f "pyproject.toml" || \
    -f "requirements.txt" || \
    -f "Cargo.toml" || \
    -f "go.mod" || \
    -f "composer.json" || \
    -f "pom.xml" ]]; then
    error "Run this script from your project root."
fi

info "Project: $(basename "$PWD")"

# ------------------------------------------------------------
# Clone repo
# ------------------------------------------------------------

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

info "Fetching latest skills..."

git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null \
    || error "Unable to clone repository."

success "Repository downloaded."

SRC="$TMP_DIR/$SKILLS_SRC"

[[ -d "$SRC" ]] || error "'$SKILLS_SRC' not found in repository."

mkdir -p "$SKILLS_DEST"

echo
info "Installing into:"
echo "  $PWD/$SKILLS_DEST"
echo

installed=0
installed_names=()

while IFS= read -r -d '' skill_dir; do

    skill_name="$(basename "$skill_dir")"

    if [[ ! -f "$skill_dir/SKILL.md" ]]; then
        warn "Skipping '$skill_name' (missing SKILL.md)"
        continue
    fi

    dest="$SKILLS_DEST/$skill_name"

    if [[ -d "$dest" ]]; then
        rm -rf "$dest"
        action="Updated"
    else
        action="Installed"
    fi

    cp -a "$skill_dir" "$dest"

    success "$action → $skill_name"

    installed=$((installed + 1))
    installed_names+=("$skill_name")

done < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

[[ $installed -gt 0 ]] || error "No valid skills were found."

# ------------------------------------------------------------
# Update .gitignore
# ------------------------------------------------------------

touch .gitignore

if ! grep -qxF ".claude/skills/" .gitignore; then
    {
        echo
        echo "# Claude Code skills"
        echo ".claude/skills/"
    } >> .gitignore

    info "Added .claude/skills/ to .gitignore"
fi

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

echo
echo -e "${BOLD}──────────────────────────────────────────${RESET}"
echo -e "${BOLD}Installation Complete${RESET}"
echo
echo "Project : $(basename "$PWD")"
echo "Installed: $installed skill(s)"
echo "Location : $PWD/$SKILLS_DEST"
echo

printf "Skills:\n"
for skill in "${installed_names[@]}"; do
    echo "  • $skill"
done

echo
success "Done! Start Claude Code in this project."
echo
