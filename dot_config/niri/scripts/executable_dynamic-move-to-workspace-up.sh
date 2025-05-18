#!/bin/bash

set -euo pipefail

workspaces_state=$(niri msg --json workspaces)

focused_workspace=$(echo "$workspaces_state" | jq '.[] | select(.is_focused == true)')
focused_idx=$(echo "$focused_workspace" | jq -r '.idx')
focused_output=$(echo "$focused_workspace" | jq -r '.output')

if [ "$focused_idx" -ne 1 ]; then
  niri msg action move-window-up-or-to-workspace-up
  exit 0
else
  last_workspace_idx=$(echo "$workspaces_state" | jq --arg output "$focused_output" '.[] | select(.output == $output) | .idx' | sort -n | tail -n 1)

  niri msg action move-window-to-workspace "$last_workspace_idx"
  niri msg action move-workspace-to-index 1
fi
