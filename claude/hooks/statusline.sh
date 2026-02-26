#!/bin/bash
# Claude Code Statusline Script
# Based on: statusline-command.sh + claude-hud (https://github.com/jarrodwatts/claude-hud)
#
# Layout (up to 3 lines):
#   Line 1: [Opus | Max] ████░░░░░░ 45% │ project main ●… ↑2 │ 📄2 📋5 🔌3 🪝6
#   Line 2: ◐ Bash │ ✓ Read(3) │ ✓ Grep(2) │ ✓ Glob(1)
#   Line 3: ▸ Implement auth system (2/5)

input=$(cat)

# === Working directory (working_dir > cwd fallback) ===
cwd=$(echo "$input" | jq -r '.working_dir // .cwd // .workspace.current_dir // "."')
dir_name=$(basename "$cwd")
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

# === Colors ===
BLUE='\033[34m'
GRAY='\033[38;5;248m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
CYAN='\033[36m'
MAGENTA='\033[35m'
DIM='\033[2m'
RESET='\033[0m'

# === Separator ===
SEP=" ${DIM}│${RESET} "

# ============================================================
# Line 1: Model/Plan | Context | Project/Git | Metadata counts
# ============================================================

# --- Model name + Plan type ---
model_name=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
plan_type=$(echo "$input" | jq -r '.plan.type // empty')

if [ -n "$plan_type" ]; then
    # Capitalize first letter
    plan_label="$(echo "${plan_type:0:1}" | tr '[:lower:]' '[:upper:]')${plan_type:1}"
    printf "${CYAN}[%s | %s]${RESET}" "$model_name" "$plan_label"
else
    printf "${CYAN}[%s]${RESET}" "$model_name"
fi

# --- Context usage (progress bar) ---
# Prefer used_percentage (Claude Code v2.1.6+), fallback to manual calc
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

if [ -n "$used_pct" ]; then
    pct=$(printf '%.0f' "$used_pct")
elif [ -n "$ctx_size" ] && [ "$ctx_size" -gt 0 ]; then
    usage=$(echo "$input" | jq -r '.context_window.current_usage')
    input_tokens=$(echo "$usage" | jq -r '.input_tokens // 0')
    cache_creation=$(echo "$usage" | jq -r '.cache_creation_input_tokens // 0')
    cache_read=$(echo "$usage" | jq -r '.cache_read_input_tokens // 0')
    used=$((input_tokens + cache_creation + cache_read))
    pct=$((used * 100 / ctx_size))
fi

if [ -n "$pct" ]; then
    bar_width=10
    filled=$((pct * bar_width / 100))
    [ "$filled" -gt "$bar_width" ] && filled=$bar_width
    empty=$((bar_width - filled))

    if [ "$pct" -lt 70 ]; then
        color="$GREEN"
    elif [ "$pct" -lt 85 ]; then
        color="$YELLOW"
    else
        color="$RED"
    fi

    bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done

    printf " ${color}%s${RESET} ${color}%d%%${RESET}" "$bar" "$pct"
fi

printf "$SEP"

# --- Project dir + Git info ---
printf "${BLUE}%s${RESET}" "$dir_name"

if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
    status=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" status --porcelain 2>/dev/null)

    indicators=""
    echo "$status" | grep -q '^[MADRCU]' && indicators+="●"
    echo "$status" | grep -q '^.[MADRCU]' && indicators+="+"
    echo "$status" | grep -q '^??' && indicators+="…"
    [ -z "$status" ] && indicators="ok"

    printf " ${GRAY}%s %s${RESET}" "$branch" "$indicators"

    # Git ahead/behind (1s timeout)
    rev_count=$(git -C "$cwd" rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)
    if [ -n "$rev_count" ]; then
        behind=$(echo "$rev_count" | awk '{print $1}')
        ahead=$(echo "$rev_count" | awk '{print $2}')
        ab_text=""
        [ "$ahead" -gt 0 ] 2>/dev/null && ab_text+=" ${GREEN}↑${ahead}${RESET}"
        [ "$behind" -gt 0 ] 2>/dev/null && ab_text+=" ${RED}↓${behind}${RESET}"
        [ -n "$ab_text" ] && printf "%s" "$ab_text"
    fi
fi

# --- Metadata counts ---

# CLAUDE.md count
claude_md_count=0
[ -f "$HOME/.claude/CLAUDE.md" ] && ((claude_md_count++))
[ -f "$cwd/CLAUDE.md" ] && ((claude_md_count++))
[ -f "$cwd/CLAUDE.local.md" ] && ((claude_md_count++))
[ -f "$cwd/.claude/CLAUDE.md" ] && ((claude_md_count++))
[ -f "$cwd/.claude/CLAUDE.local.md" ] && ((claude_md_count++))

meta_parts=""
if [ "$claude_md_count" -gt 0 ]; then
    meta_parts+=$(printf "${YELLOW}📄%d${RESET}" "$claude_md_count")
fi

# Rules count
rules_count=0
if [ -d "$HOME/.claude/rules" ]; then
    rules_count=$((rules_count + $(find "$HOME/.claude/rules" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')))
fi
if [ -d "$cwd/.claude/rules" ]; then
    rules_count=$((rules_count + $(find "$cwd/.claude/rules" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')))
fi

if [ "$rules_count" -gt 0 ]; then
    [ -n "$meta_parts" ] && meta_parts+=" "
    meta_parts+=$(printf "${YELLOW}📋%d${RESET}" "$rules_count")
fi

# MCPs count
mcp_count=0
if [ -f "$HOME/.claude.json" ]; then
    global_mcps=$(jq -r '.mcpServers // {} | keys | length' "$HOME/.claude.json" 2>/dev/null || echo 0)
    mcp_count=$((mcp_count + global_mcps))
fi
if [ -f "$cwd/.mcp.json" ]; then
    project_mcps=$(jq -r '.mcpServers // {} | keys | length' "$cwd/.mcp.json" 2>/dev/null || echo 0)
    mcp_count=$((mcp_count + project_mcps))
fi

if [ "$mcp_count" -gt 0 ]; then
    [ -n "$meta_parts" ] && meta_parts+=" "
    meta_parts+=$(printf "${MAGENTA}🔌%d${RESET}" "$mcp_count")
fi

# Hooks count
hooks_count=0
if [ -f "$HOME/.claude/settings.json" ]; then
    hooks_count=$(jq -r '[.hooks // {} | to_entries[] | .value | length] | add // 0' "$HOME/.claude/settings.json" 2>/dev/null || echo 0)
fi

if [ "$hooks_count" -gt 0 ]; then
    [ -n "$meta_parts" ] && meta_parts+=" "
    meta_parts+=$(printf "${CYAN}🪝%d${RESET}" "$hooks_count")
fi

if [ -n "$meta_parts" ]; then
    printf "$SEP"
    printf "%b" "$meta_parts"
fi

# ============================================================
# Line 2: Running tools + completed tool counts (from transcript)
# ============================================================
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
    line2_parts=""

    # Running tools (most recent, max 2)
    running_tools=$(tac "$transcript_path" 2>/dev/null | \
        grep -m 5 '"type":"tool_use"' | \
        grep -o '"name":"[^"]*"' | \
        sed 's/"name":"\([^"]*\)"/\1/' | \
        head -2)

    if [ -n "$running_tools" ]; then
        while IFS= read -r tool_name; do
            [ -z "$tool_name" ] && continue
            [ -n "$line2_parts" ] && line2_parts+=$(printf "$SEP")
            line2_parts+=$(printf "${YELLOW}◐${RESET} ${CYAN}%s${RESET}" "$tool_name")
        done <<< "$running_tools"
    fi

    # Completed tool counts (top 4)
    tool_counts=$(grep -o '"type":"tool_use"[^}]*"name":"[^"]*"' "$transcript_path" 2>/dev/null | \
        sed 's/.*"name":"\([^"]*\)".*/\1/' | \
        grep -v '^Task$' | grep -v '^TodoWrite$' | grep -v '^TaskCreate$' | grep -v '^TaskUpdate$' | grep -v '^TaskList$' | \
        sort | uniq -c | sort -rn | head -4)

    if [ -n "$tool_counts" ]; then
        while read -r count name; do
            [ -z "$name" ] && continue
            [ -n "$line2_parts" ] && line2_parts+=$(printf "$SEP")
            line2_parts+=$(printf "${GREEN}✓${RESET} %s(%d)" "$name" "$count")
        done <<< "$tool_counts"
    fi

    if [ -n "$line2_parts" ]; then
        printf "\n%b" "$line2_parts"
    fi

    # ============================================================
    # Line 3: Todo progress (from transcript)
    # ============================================================
    todo_data=$(grep 'TodoWrite' "$transcript_path" 2>/dev/null | tail -1 | \
        grep -o '"todos":\[[^]]*\]' | head -1)

    if [ -n "$todo_data" ]; then
        total=$(echo "$todo_data" | grep -o '"status":"[^"]*"' | wc -l | tr -d ' ')
        completed=$(echo "$todo_data" | grep -o '"status":"completed"' | wc -l | tr -d ' ')

        if [ "$total" -gt 0 ]; then
            current_task=$(grep 'TodoWrite' "$transcript_path" 2>/dev/null | tail -1 | \
                grep -oE '"content":"[^"]{1,50}"[^}]*"status":"in_progress"' | head -1 | \
                sed 's/"content":"\([^"]*\)".*/\1/')

            printf "\n"
            if [ "$completed" -eq "$total" ]; then
                printf "${GREEN}✓ All todos complete (%d/%d)${RESET}" "$completed" "$total"
            elif [ -n "$current_task" ]; then
                printf "${YELLOW}▸ %s (%d/%d)${RESET}" "$current_task" "$completed" "$total"
            else
                printf "${YELLOW}▸ Todo (%d/%d)${RESET}" "$completed" "$total"
            fi
        fi
    fi
fi
