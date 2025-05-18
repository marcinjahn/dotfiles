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
focused_output=$(echo "$focused_workspace" | jq -r '.output')

if [ "$focused_idx" -ne 1 ]; then
  niri msg action move-window-up-or-to-workspace-up
  exit 0
else
  last_workspace_idx=$(echo "$workspaces_state" | jq --arg output "$focused_output" '.[] | select(.output == $output) | .idx' | sort -n | tail -n 1)

  niri msg action move-window-to-workspace "$last_workspace_idx"
  niri msg action move-workspace-to-index 1
fi
