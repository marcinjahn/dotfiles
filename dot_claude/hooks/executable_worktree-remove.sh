#!/bin/bash
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r .cwd)
WPATH=$(echo "$INPUT" | jq -r .worktree_path)

[ -z "$WPATH" ] || [ ! -d "$WPATH" ] && exit 0

WSNAME=$(basename "$WPATH")
(cd "$CWD" && jj workspace forget "$WSNAME")
rm -rf "$WPATH"
