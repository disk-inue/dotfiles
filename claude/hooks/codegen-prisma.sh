#!/bin/bash

# PostToolUse hook: Prismaスキーマ変更後にPrisma generate実行
# 入力: JSON形式のツール実行情報（stdin）

set -e

# stdinからJSONを読み取り、ファイルパスを取得
file_path=$(jq -r '.tool_input.file_path // empty')

# ファイルパスが取得できない場合は終了
if [ -z "$file_path" ]; then
  exit 0
fi

# schema.prismaファイルのみ対象
case "$file_path" in
  */schema.prisma|*/*.prisma)
    ;;
  *)
    exit 0
    ;;
esac

cd "$CLAUDE_PROJECT_DIR"

# backendアプリのPrisma generateを実行
if [[ "$file_path" == *"/apps/backend/"* ]]; then
  cd apps/backend
  pnpm codegen 2>/dev/null || true
fi

exit 0
