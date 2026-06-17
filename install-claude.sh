#!/usr/bin/env bash
# ============================================================
#  Claude Code Skills Installer
#  Repo: https://github.com/Sanjai05122006/Codex-Skills
#
#  Usage:
#    curl -fsSL https://raw.githubusercontent.com/Sanjai05122006/Codex-Skills/main/install.sh | bash
#
#  What it does:
#    - Clones (or updates) this skills repo to a temp location
#    - Copies every skill folder into ~/.claude/skills/
#    - Skips skills that are already up-to-date (idempotent)
# ============================================================

set -euo pipefail

# ── Config ────────────────────────────────────────────────
REPO_URL="https://github.com/Sanjai05122006/Codex-Skills.git"
SKILLS_DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
SKILLS_SRC_DIR="skills"          # folder inside the repo that holds skill sub-folders
BRANCH="main"
# ──────────────────────────────────────────────────────────

# Colours
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${CYAN}ℹ  $*${RESET}"; }
success() { echo -e "${GREEN}✔  $*${RESET}"; }
warn()    { echo -e "${YELLOW}⚠  $*${RESET}"; }
error()   { echo -e "${RED}✖  $*${RESET}" >&2; exit 1; }

echo -e "\n${BOLD}╔══════════════════════════════════════════╗"
echo -e "║   Claude Code Skills Installer           ║"
echo -e "╚══════════════════════════════════════════╝${RESET}\n"

# ── Prereqs ───────────────────────────────────────────────
for cmd in git curl; do
  command -v "$cmd" &>/dev/null || error "'$cmd' is required but not found. Please install it first."
done

# ── Clone / update repo ───────────────────────────────────
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

info "Cloning skills repo …"
if git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMP_DIR" --quiet 2>/dev/null; then
  success "Repo cloned."
else
  error "Failed to clone $REPO_URL — check the URL and your network connection."
fi

# ── Locate skills folder ──────────────────────────────────
SRC="$TMP_DIR/$SKILLS_SRC_DIR"
if [[ ! -d "$SRC" ]]; then
  # Fallback: skill folders may sit at the repo root
  SRC="$TMP_DIR"
  warn "No '$SKILLS_SRC_DIR/' folder found — treating repo root as skills source."
fi

# ── Prepare destination ───────────────────────────────────
mkdir -p "$SKILLS_DEST"
info "Installing skills to: $SKILLS_DEST"

# ── Install each skill ────────────────────────────────────
installed=0; skipped=0; errors=0

while IFS= read -r -d '' skill_dir; do
  skill_name="$(basename "$skill_dir")"

  # Must contain SKILL.md to count as a valid skill
  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    continue
  fi

  dest="$SKILLS_DEST/$skill_name"

  # Overwrite existing to ensure latest version
  if [[ -d "$dest" ]]; then
    rm -rf "$dest"
    action="Updated"
  else
    action="Installed"
  fi

  if cp -r "$skill_dir" "$dest" 2>/dev/null; then
    success "$action: $skill_name"
    ((installed++))
  else
    warn "Failed to install: $skill_name"
    ((errors++))
  fi

done < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

# ── Summary ───────────────────────────────────────────────
echo ""
echo -e "${BOLD}── Install Summary ──────────────────────────${RESET}"
echo -e "  ${GREEN}Skills installed/updated : $installed${RESET}"
[[ $errors -gt 0 ]] && echo -e "  ${RED}Errors                   : $errors${RESET}"
echo -e "  ${CYAN}Skills location          : $SKILLS_DEST${RESET}"
echo ""

# ── Verify ────────────────────────────────────────────────
total="$(find "$SKILLS_DEST" -maxdepth 2 -name "SKILL.md" | wc -l | tr -d ' ')"
echo -e "${BOLD}$total skill(s) available in Claude Code.${RESET}"
echo -e "Start a new Claude Code session — skills are picked up automatically.\n"
