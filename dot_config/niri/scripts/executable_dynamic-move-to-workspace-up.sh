#!/bin/bash

# By default, niri will not create a new workspace before the first one
# when moving window "up". This script simulates the behavior of dynamic
# workspace being screated at the top of current stack on demand.
# The trick is, it moves the window down to the bottom workspace (which is always empty,
# and then moves the whole new workspace up to the first index)

set -euo pipefail

workspaces_state=$(niri msg --json workspaces)

focused_workspace=$(echo "$workspaces_state" | jq '.[] | select(.is_focused == true)')
focused_idx=$(echo "$focused_workspace" | jq -r '.idx')

if [ "$focused_idx" -ne 1 ]; then
  niri msg action move-window-up-or-to-workspace-up
  exit 0
fi

focused_id=$(echo "$focused_workspace" | jq -r '.id')

windows_state=$(niri msg --json windows)
window_count=$(echo "$windows_state" | jq --argjson id "$focused_id" '[.[] | select(.workspace_id == $id)] | length')

if [ "$window_count" -eq 1 ]; then
  exit 0
fi

focused_output=$(echo "$focused_workspace" | jq -r '.output')
last_workspace_idx=$(echo "$workspaces_state" | jq --arg output "$focused_output" '.[] | select(.output == $output) | .idx' | sort -n | tail -n 1)

niri msg action move-window-to-workspace --focus false "$last_workspace_idx"
niri msg action move-workspace-to-index --reference "$last_workspace_idx" 1
niri msg action focus-workspace-up
