#!/bin/bash

# PreToolUse hook: ファイル編集前にシークレットのハードコードをチェック
# 入力: JSON形式のツール実行情報（stdin）
# 出力: JSON形式で決定を返す（continue/block）

# stdinからJSONを読み取り
input=$(cat)

file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')
new_content=$(echo "$input" | jq -r '.tool_input.content // .tool_input.new_string // empty')

# ファイルパスまたはコンテンツが取得できない場合は続行
if [ -z "$file_path" ] || [ -z "$new_content" ]; then
  echo '{"decision": "continue"}'
  exit 0
fi

# 対象外のファイルをスキップ
case "$file_path" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.env*)
    ;;
  *)
    echo '{"decision": "continue"}'
    exit 0
    ;;
esac

# .env, .env.local, .env.exampleファイルは除外（環境変数ファイルなので）
case "$file_path" in
  *.env|*.env.local|*.env.example|*.env.development|*.env.production|*.env.test)
    echo '{"decision": "continue"}'
    exit 0
    ;;
esac

# テストファイルは除外（モック値が含まれることがある）
case "$file_path" in
  *.test.ts|*.test.tsx|*.spec.ts|*.spec.tsx|*/__tests__/*|*/__mocks__/*)
    echo '{"decision": "continue"}'
    exit 0
    ;;
esac

# シークレットパターンをチェック
# 注意: 誤検知を減らすため、明らかなパターンのみチェック
secrets_found=""

# AWS Access Key ID (AKIA...)
if echo "$new_content" | grep -qE 'AKIA[0-9A-Z]{16}'; then
  secrets_found="$secrets_found\n- AWS Access Key ID detected"
fi

# AWS Secret Access Key (40文字の英数字+記号)
if echo "$new_content" | grep -qE '"[A-Za-z0-9/+=]{40}"'; then
  # 一般的な長い文字列と区別するため、aws/secretの文脈があるかチェック
  if echo "$new_content" | grep -qiE '(aws|secret|key)'; then
    secrets_found="$secrets_found\n- Potential AWS Secret Key detected"
  fi
fi

# Private Key
if echo "$new_content" | grep -qE '-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----'; then
  secrets_found="$secrets_found\n- Private Key detected"
fi

# Generic API Key patterns (明示的なキー代入)
if echo "$new_content" | grep -qiE '(api_key|apikey|api-key)\s*[:=]\s*["\x27][a-zA-Z0-9_-]{20,}["\x27]'; then
  secrets_found="$secrets_found\n- Hardcoded API key detected"
fi

# Firebase/Google service account
if echo "$new_content" | grep -qE '"private_key":\s*"-----BEGIN'; then
  secrets_found="$secrets_found\n- Service account private key detected"
fi

# JWT tokens (長いBase64エンコード文字列、ドット区切り3部構成)
if echo "$new_content" | grep -qE 'eyJ[A-Za-z0-9_-]*\.eyJ[A-Za-z0-9_-]*\.[A-Za-z0-9_-]*'; then
  secrets_found="$secrets_found\n- JWT token detected"
fi

# シークレットが見つかった場合はブロック
if [ -n "$secrets_found" ]; then
  message="Potential secrets detected in the code:$secrets_found\n\nPlease use environment variables instead of hardcoding secrets."
  # JSONエスケープ
  escaped_message=$(echo -e "$message" | jq -Rs '.')
  echo "{\"decision\": \"block\", \"reason\": $escaped_message}"
  exit 0
fi

# 問題なければ続行
echo '{"decision": "continue"}'
exit 0
