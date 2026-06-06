#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/Sanjai05122006/Codex-Skills.git"
CLONE_DIR=".codex-skills-install"

echo ""
echo "========================================"
echo " Installing Codex Skills Workflow"
echo "========================================"
echo ""

if [ -d "$CLONE_DIR" ]; then
rm -rf "$CLONE_DIR"
fi

git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

echo ""
echo "Copying workflow files..."
echo ""

# .codex

if [ -d "$CLONE_DIR/.codex" ]; then
cp -r "$CLONE_DIR/.codex" .
echo "✓ .codex installed"
fi

# .agents

if [ -d "$CLONE_DIR/.agents" ]; then
cp -r "$CLONE_DIR/.agents" .
echo "✓ .agents installed"
fi

# docs/ui

if [ -d "$CLONE_DIR/docs/ui" ]; then
mkdir -p docs
cp -r "$CLONE_DIR/docs/ui" docs/
echo "✓ docs/ui installed"
fi

rm -rf "$CLONE_DIR"

echo ""
echo "========================================"
echo " Installation Complete"
echo "========================================"
echo ""
echo "Installed:"
echo "  .codex/"
echo "  .agents/"
echo "  docs/ui/"
echo ""
echo "Project-specific files were NOT modified:"
echo "  AGENTS.md"
echo "  ARCHITECTURE.md"
echo "  REQUIREMENTS.md"
echo "  AGENT_TASKS.md"
echo "  Backlog.md"
echo ""
