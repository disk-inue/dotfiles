#!/bin/bash

# SessionStart hook: セッション開始時に環境情報を表示
# Git状態、バージョン情報、利用可能ツールを確認

cd "$CLAUDE_PROJECT_DIR" || exit 0

echo "=== Development Environment ==="
echo ""

# Git情報
current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
uncommitted=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
last_commit=$(git log -1 --pretty=format:'%h %s' 2>/dev/null)

echo "[Git]"
echo "  Branch: $current_branch"
echo "  Uncommitted changes: $uncommitted"
echo "  Last commit: $last_commit"

# ブランチ警告
case "$current_branch" in
  main|develop)
    echo ""
    echo "  WARNING: $current_branch ブランチで作業中です。新しいブランチを作成してから作業を開始してください。"
    ;;
esac

echo ""

# バージョン情報
echo "[Versions]"
node_version=$(node --version 2>/dev/null || echo "not found")
pnpm_version=$(pnpm --version 2>/dev/null || echo "not found")
echo "  Node.js: $node_version"
echo "  pnpm: $pnpm_version"

echo ""

# Docker状態
echo "[Docker]"
if docker compose ps --format '{{.Name}}: {{.Status}}' 2>/dev/null | head -5; then
  :
else
  echo "  Docker Compose is not running"
fi

echo ""
echo "=================================="
