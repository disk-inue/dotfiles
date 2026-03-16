#!/bin/bash

# PostToolUse hook: ファイル編集後にPrettierでフォーマット
# 入力: JSON形式のツール実行情報（stdin）

set -e

# stdinからJSONを読み取り、ファイルパスを取得
file_path=$(jq -r '.tool_input.file_path // empty')

# ファイルパスが取得できない場合は終了
if [ -z "$file_path" ]; then
  exit 0
fi

# 対象外のファイルをスキップ
case "$file_path" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css|*.scss|*.md|*.mdx|*.yaml|*.yml)
    ;;
  *)
    exit 0
    ;;
esac

# node_modules, .git, distなどは除外
if [[ "$file_path" == *"/node_modules/"* ]] || \
   [[ "$file_path" == *"/.git/"* ]] || \
   [[ "$file_path" == *"/dist/"* ]] || \
   [[ "$file_path" == *"/.next/"* ]]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# ファイルパスからappを判断
if [[ "$file_path" == *"/apps/ec/"* ]]; then
  cd apps/ec
elif [[ "$file_path" == *"/apps/backend/"* ]]; then
  cd apps/backend
elif [[ "$file_path" == *"/apps/hubspot/"* ]]; then
  cd apps/hubspot
else
  # ルートレベルのファイルの場合
  :
fi

# Prettierを実行
pnpm format --write "$file_path" 2>/dev/null || true

exit 0
