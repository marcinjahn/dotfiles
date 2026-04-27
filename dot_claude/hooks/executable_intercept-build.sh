#!/bin/bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ "${CLAUDE_BYPASS_BUILD_SUMMARY:-0}" = "1" ]; then
  exit 0
fi

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Skip if RTK already rewrote this command
case "$COMMAND" in rtk\ *) exit 0 ;; esac

# Strip leading whitespace, then any leading "cd <dir> &&" chains
TRIMMED=$(echo "$COMMAND" | sed 's/^[[:space:]]*//')
while echo "$TRIMMED" | grep -qE '^cd[[:space:]]+[^&]+&&'; do
  NEW=$(echo "$TRIMMED" | sed -E 's/^cd[[:space:]]+[^&]+&&[[:space:]]*//')
  [ "$NEW" = "$TRIMMED" ] && break
  TRIMMED="$NEW"
done

# Strip a leading "limited " prefix (CPU/memory limiter wrapper)
TRIMMED=$(echo "$TRIMMED" | sed -E 's/^limited[[:space:]]+//')

matches=0

case "$TRIMMED" in
cargo\ build* | cargo\ test* | cargo\ check* | cargo\ clippy*)
  matches=1
  ;;
dotnet\ build* | dotnet\ test*)
  matches=1
  ;;
npm\ test* | npm\ run\ test* | npm\ build* | npm\ run\ build*)
  matches=1
  ;;
pnpm\ test* | pnpm\ run\ test* | pnpm\ build* | pnpm\ run\ build* | pnpm\ run\ jan:build* | pnpm\ run\ hot:build* | pnpm\ run\ jan:test* | pnpm\ run\ hot:test* | pnpm\ nx\ build*)
  matches=1
  ;;
yarn\ test* | yarn\ build* | yarn\ run\ test* | yarn\ run\ build*)
  matches=1
  ;;
pytest* | python\ -m\ pytest*)
  matches=1
  ;;
go\ build* | go\ test*)
  matches=1
  ;;
just\ build* | just\ test*)
  matches=1
  ;;
esac

if [ "$matches" -eq 0 ]; then
  exit 0
fi

TMPFILE=$(mktemp /tmp/claude-code-intercept-build-hook-build-cmd-XXXXX)
echo "$COMMAND" >"$TMPFILE"

jq -n --arg cmd "$HOME/.claude/hooks/run-filtered.sh $TMPFILE" \
  '{"hookSpecificOutput": {"hookEventName": "PreToolUse", "permissionDecision": "allow", "updatedInput": {"command": $cmd}}}'
