#!/bin/bash

# PreToolUse hook: main/developブランチへの直接コミットをブロック
# 入力: JSON形式のツール実行情報（stdin）
# 出力: JSON形式で決定を返す（continue/block）

# stdinからJSONを読み取り
input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // empty')

# Bashツールの場合のみチェック
if [ "$tool_name" != "Bash" ]; then
  echo '{"decision": "continue"}'
  exit 0
fi

command=$(echo "$input" | jq -r '.tool_input.command // empty')

# git commitコマンドかチェック
if ! echo "$command" | grep -qE '^\s*git\s+commit'; then
  echo '{"decision": "continue"}'
  exit 0
fi

# 現在のブランチを取得（worktree内でも正しく検出するためpwdベースで取得）
current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# main または develop ブランチの場合はブロック
case "$current_branch" in
  main|develop)
    echo "{\"decision\": \"block\", \"reason\": \"$current_branch ブランチへの直接コミットは禁止されています。新しいブランチを作成してから作業してください。\\n\\n例: git checkout -b feature/your-feature-name\"}"
    exit 0
    ;;
esac

echo '{"decision": "continue"}'
exit 0
