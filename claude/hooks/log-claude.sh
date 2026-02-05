#!/bin/bash

# Claude Code activity logger
# Logs tool usage and user prompts to daily log files

LOG_DIR="$HOME/.work-logs"
LOG_FILE="$LOG_DIR/$(date +'%Y-%m-%d').log"

# Read JSON input from stdin
INPUT=$(cat)

# Extract common fields
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "Unknown"')
CWD=$(echo "$INPUT" | jq -r '.cwd // "?"')
TIMESTAMP=$(date +'%Y-%m-%d %H:%M:%S')

case "$EVENT" in
  "PreToolUse"|"PostToolUse")
    TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // "?"')

    case "$TOOL_NAME" in
      "Bash")
        COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""' | head -c 200)
        echo "$TIMESTAMP [CLAUDE] [Bash] [$CWD] $COMMAND" >> "$LOG_FILE"
        ;;
      "Edit"|"Write")
        FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')
        echo "$TIMESTAMP [CLAUDE] [$TOOL_NAME] $FILE_PATH" >> "$LOG_FILE"
        ;;
      "Read")
        FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')
        echo "$TIMESTAMP [CLAUDE] [Read] $FILE_PATH" >> "$LOG_FILE"
        ;;
      "Glob"|"Grep")
        PATTERN=$(echo "$INPUT" | jq -r '.tool_input.pattern // ""')
        echo "$TIMESTAMP [CLAUDE] [$TOOL_NAME] $PATTERN" >> "$LOG_FILE"
        ;;
      "Task")
        DESCRIPTION=$(echo "$INPUT" | jq -r '.tool_input.description // ""')
        echo "$TIMESTAMP [CLAUDE] [Task] $DESCRIPTION" >> "$LOG_FILE"
        ;;
      *)
        echo "$TIMESTAMP [CLAUDE] [$TOOL_NAME]" >> "$LOG_FILE"
        ;;
    esac
    ;;
  "UserPromptSubmit")
    PROMPT=$(echo "$INPUT" | jq -r '.prompt // ""' | head -c 200 | tr '\n' ' ')
    echo "$TIMESTAMP [CLAUDE] [Prompt] $PROMPT" >> "$LOG_FILE"
    ;;
  "SessionStart")
    SOURCE=$(echo "$INPUT" | jq -r '.source // "?"')
    echo "$TIMESTAMP [CLAUDE] [Session] Started ($SOURCE)" >> "$LOG_FILE"
    ;;
  "SessionEnd")
    echo "$TIMESTAMP [CLAUDE] [Session] Ended" >> "$LOG_FILE"
    ;;
  "Stop")
    # Extract Claude's response from transcript
    TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // ""')
    POSITION_FILE="$LOG_DIR/.transcript_position_$(basename "$TRANSCRIPT_PATH" .jsonl)"

    if [[ -n "$TRANSCRIPT_PATH" && -f "$TRANSCRIPT_PATH" ]]; then
      # Get last processed line number
      if [[ -f "$POSITION_FILE" ]]; then
        LAST_POS=$(cat "$POSITION_FILE")
      else
        LAST_POS=0
      fi

      CURRENT_LINES=$(wc -l < "$TRANSCRIPT_PATH" | tr -d ' ')

      if [[ $CURRENT_LINES -gt $LAST_POS ]]; then
        # Get new lines since last stop, then find last prompt and get responses after it
        RESPONSE=$(tail -n +$((LAST_POS + 1)) "$TRANSCRIPT_PATH" | jq -s '
          (to_entries | [.[] | select(.value.type == "user" and (.value.message.content | type) == "string")] | last | .key) as $idx |
          (if $idx then .[$idx:] else . end) |
          [.[] | select(.type == "assistant") | .message.content[]? | select(.type == "text") | .text] | join(" ")
        ' 2>/dev/null | head -c 500 | tr '\n' ' ' | sed 's/^"//;s/"$//')

        if [[ -n "$RESPONSE" ]]; then
          echo "$TIMESTAMP [CLAUDE] [Response] $RESPONSE" >> "$LOG_FILE"
        fi
      fi

      # Save current position
      echo "$CURRENT_LINES" > "$POSITION_FILE"
    fi
    ;;
esac

exit 0
