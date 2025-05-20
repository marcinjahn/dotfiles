#!/bin/bash

# Displays notification with window name on focus change

set -e

NOTIFICATION_ID_FILE="/tmp/niri_move_focus_notification_id.txt"

# Function to dismiss the currently displayed notification
dismiss_current_notification() {
  if [ -f "$NOTIFICATION_ID_FILE" ]; then
    PREVIOUS_NOTIFICATION_ID=$(cat "$NOTIFICATION_ID_FILE")
    if [ -n "$PREVIOUS_NOTIFICATION_ID" ]; then
      makoctl dismiss "$PREVIOUS_NOTIFICATION_ID" >/dev/null 2>&1 || true
    fi
  fi
}

if [ -z "$1" ]; then
  echo "Usage: $0 <niri_action>"
  exit 1
fi

NIRI_ACTION="$1"

PREV_FOCUSED_WINDOW_JSON=$(niri msg --json focused-window)

niri msg action "$NIRI_ACTION"

CURRENT_FOCUSED_WINDOW_JSON=$(niri msg --json focused-window)

if [ "$CURRENT_FOCUSED_WINDOW_JSON" == "null" ]; then
  dismiss_current_notification
  # Clear the stored ID as there's no active notification
  echo "" >"$NOTIFICATION_ID_FILE"
elif [ "$PREV_FOCUSED_WINDOW_JSON" != "$CURRENT_FOCUSED_WINDOW_JSON" ]; then
  WINDOW_TITLE=$(echo "$CURRENT_FOCUSED_WINDOW_JSON" | jq -r '.title')

  dismiss_current_notification

  # -p prints notification ID
  notify-send -p --expire-time=1000 --app-name=niri --category=niri-window-title "$WINDOW_TITLE" >"$NOTIFICATION_ID_FILE"
fi
