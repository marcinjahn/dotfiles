#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
tokens=$(echo "$input" | jq -r '
  (.context_window.current_usage // {}) as $u |
  ((($u.input_tokens // 0) + ($u.cache_creation_input_tokens // 0) + ($u.cache_read_input_tokens // 0)))
')

parts=""

if [ -n "$model" ]; then
  parts="${model}"
fi

if [ -n "$used" ]; then
  bar_width=15
  filled=$((used * bar_width / 100))
  empty=$((bar_width - filled))
  bar="["
  for i in $(seq 1 $filled); do bar="${bar}#"; done
  for i in $(seq 1 $empty); do bar="${bar}-"; done
  bar="${bar}]"

  [ -n "$parts" ] && parts="${parts} | "
  parts="${parts}${bar} ${used}%"
fi

if [ -n "$tokens" ] && [ "$tokens" -gt 0 ] 2>/dev/null; then
  if [ "$tokens" -ge 200000 ]; then
    color=$'\033[38;5;196m' # red
  elif [ "$tokens" -ge 150000 ]; then
    color=$'\033[38;5;202m' # deep orange
  elif [ "$tokens" -ge 100000 ]; then
    color=$'\033[38;5;208m' # orange
  elif [ "$tokens" -ge 80000 ]; then
    color=$'\033[38;5;220m' # deep yellow
  elif [ "$tokens" -ge 50000 ]; then
    color=$'\033[38;5;226m' # yellow
  else
    color=$'\033[38;5;46m' # green
  fi
  reset=$'\033[0m'

  if [ "$tokens" -ge 1000 ]; then
    formatted=$(awk -v t="$tokens" 'BEGIN { printf "%.1fk", t/1000 }')
  else
    formatted="${tokens}"
  fi

  [ -n "$parts" ] && parts="${parts} | "
  parts="${parts}${color}${formatted}${reset}"
fi

printf '%s' "$parts"
