#!/bin/bash

# Displays notification with window name on focus change

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <niri_action>"
  exit 1
fi

NIRI_ACTION="$1"

PREV_FOCUSED_WINDOW_JSON=$(niri msg --json focused-window)

niri msg action "$NIRI_ACTION"

CURRENT_FOCUSED_WINDOW_JSON=$(niri msg --json focused-window)

if [ "$CURRENT_FOCUSED_WINDOW_JSON" != "null" ] && [ "$PREV_FOCUSED_WINDOW_JSON" != "$CURRENT_FOCUSED_WINDOW_JSON" ]; then
  WINDOW_TITLE=$(echo "$CURRENT_FOCUSED_WINDOW_JSON" | jq -r '.title')
  notify-send --expire-time=500 --app-name=niri --category=niri-window-title "$WINDOW_TITLE"
fi
