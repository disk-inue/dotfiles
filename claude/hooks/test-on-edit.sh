#!/bin/bash

# PostToolUse hook: テストファイル編集後にそのテストを実行
# 入力: JSON形式のツール実行情報（stdin）

set -e

# stdinからJSONを読み取り、ファイルパスを取得
file_path=$(jq -r '.tool_input.file_path // empty')

# ファイルパスが取得できない場合は終了
if [ -z "$file_path" ]; then
  exit 0
fi

# テストファイルのみ対象（.test.ts, .test.tsx, .spec.ts, .spec.tsx）
case "$file_path" in
  *.test.ts|*.test.tsx|*.spec.ts|*.spec.tsx)
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

# ファイルパスからappを判断してテストを実行
if [[ "$file_path" == *"/apps/ec/"* ]]; then
  cd apps/ec
  pnpm test "$file_path" 2>/dev/null || true
elif [[ "$file_path" == *"/apps/backend/"* ]]; then
  cd apps/backend
  pnpm test "$file_path" 2>/dev/null || true
fi

exit 0
