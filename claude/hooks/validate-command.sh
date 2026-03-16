#!/bin/bash
# Security validation hook for PreToolUse (Bash)
# Exit code 0: allow, Exit code 2: block

COMMAND=$(jq -r '.tool_input.command' < /dev/stdin)

# Block rm -rf commands
if echo "$COMMAND" | grep -q 'rm -rf'; then
  echo "Blocked: rm -rf commands are not allowed" >&2
  exit 2
fi

# Block direct production access
if echo "$COMMAND" | grep -qE '\bprod\b'; then
  echo "Blocked: production access is not allowed" >&2
  exit 2
fi

# Block env/secret file access via cat/less/more
if echo "$COMMAND" | grep -qE '(cat|less|more|head|tail).*\.(env|pem|key)'; then
  echo "Blocked: reading sensitive files is not allowed" >&2
  exit 2
fi

exit 0
