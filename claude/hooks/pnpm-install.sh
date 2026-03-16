#!/bin/bash

# PostToolUse hook: package.json変更後にpnpm install実行
# 入力: JSON形式のツール実行情報（stdin）

set -e

# stdinからJSONを読み取り、ファイルパスを取得
file_path=$(jq -r '.tool_input.file_path // empty')

# ファイルパスが取得できない場合は終了
if [ -z "$file_path" ]; then
  exit 0
fi

# package.jsonファイルのみ対象
case "$file_path" in
  */package.json)
    ;;
  *)
    exit 0
    ;;
esac

# node_modules, .gitなどは除外
if [[ "$file_path" == *"/node_modules/"* ]] || \
   [[ "$file_path" == *"/.git/"* ]]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# pnpm installを実行（monorepo全体で依存関係を解決）
pnpm install 2>/dev/null || true

exit 0
