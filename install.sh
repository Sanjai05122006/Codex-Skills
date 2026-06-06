#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/Sanjai05122006/Codex-Skills.git"
CLONE_DIR=".codex-skills-install"

echo ""
echo "========================================"
echo " Installing Codex Skills Workflow"
echo "========================================"
echo ""

# Cleanup previous run

if [ -d "$CLONE_DIR" ]; then
rm -rf "$CLONE_DIR"
fi

# Clone template repo

git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

echo ""
echo "Copying workflow files..."
echo ""

# ------------------------------------------------------------------

# .codex

# ------------------------------------------------------------------

if [ -d "$CLONE_DIR/.codex" ]; then
cp -r "$CLONE_DIR/.codex" .
echo "✓ .codex installed"
fi

# ------------------------------------------------------------------

# .agents

# ------------------------------------------------------------------

if [ -d "$CLONE_DIR/.agents" ]; then
cp -r "$CLONE_DIR/.agents" .
echo "✓ .agents installed"
fi

# ------------------------------------------------------------------

# docs

# ------------------------------------------------------------------

if [ -d "$CLONE_DIR/docs" ]; then
mkdir -p docs
cp -r "$CLONE_DIR/docs/." docs/
echo "✓ docs installed"
fi

# ------------------------------------------------------------------

# Project Documentation (copy only if missing)

# ------------------------------------------------------------------

copy_if_missing() {
local SOURCE="$1"
local TARGET="$2"

```
if [ -f "$SOURCE" ] && [ ! -f "$TARGET" ]; then
    cp "$SOURCE" "$TARGET"
    echo "✓ $(basename "$TARGET") installed"
elif [ -f "$TARGET" ]; then
    echo "→ $(basename "$TARGET") already exists — skipped"
fi
```

}

copy_if_missing "$CLONE_DIR/AGENTS.md" "AGENTS.md"
copy_if_missing "$CLONE_DIR/ARCHITECTURE.md" "ARCHITECTURE.md"
copy_if_missing "$CLONE_DIR/REQUIREMENTS.md" "REQUIREMENTS.md"
copy_if_missing "$CLONE_DIR/AGENT_TASKS.md" "AGENT_TASKS.md"
copy_if_missing "$CLONE_DIR/Backlog.md" "Backlog.md"
copy_if_missing "$CLONE_DIR/README.md" "README.md"

# ------------------------------------------------------------------

# Cleanup

# ------------------------------------------------------------------

rm -rf "$CLONE_DIR"

echo ""
echo "========================================"
echo " Installation Complete"
echo "========================================"
echo ""

echo "Installed:"
echo "  .codex/"
echo "  .agents/"
echo "  docs/"

echo ""
echo "Installed if missing:"
echo "  AGENTS.md"
echo "  ARCHITECTURE.md"
echo "  REQUIREMENTS.md"
echo "  AGENT_TASKS.md"
echo "  Backlog.md"
echo "  README.md"

echo ""
echo "Existing project files were not overwritten."
echo ""
