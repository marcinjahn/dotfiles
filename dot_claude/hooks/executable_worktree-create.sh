#!/bin/bash
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r .cwd)
NAME=$(echo "$INPUT" | jq -r .name)
DIR="$HOME/code/worktrees/$NAME"

mkdir -p "$(dirname "$DIR")"
cd "$CWD" && jj workspace add "$DIR" >&2
PROJECT=$(basename "$CWD")
(cd "$DIR" && puff link "$PROJECT" >&2 || true)
echo "$DIR"
