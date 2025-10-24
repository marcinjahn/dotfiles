#!/bin/bash

# Toggles between browser window and previously focused window
# Opens a new browser instance if none is there.

set -e

BROWSER_APP_ID="app.zen_browser.zen"
STATE_FILE="/tmp/niri-browser-toggle-state"

WINDOWS=$(niri msg --json windows)

CURRENT_WINDOW_ID=$(echo "$WINDOWS" | jq -r '.[] | select(.is_focused == true) | .id')
CURRENT_APP_ID=$(echo "$WINDOWS" | jq -r '.[] | select(.is_focused == true) | .app_id')

BROWSER_WINDOW_ID=$(echo "$WINDOWS" | jq -r ".[] | select(.app_id == \"$BROWSER_APP_ID\") | .id" | head -n1)

if [ "$CURRENT_APP_ID" == "$BROWSER_APP_ID" ]; then
  # Currently on browser, switch back to previous window if stored
  if [ -f "$STATE_FILE" ]; then
    PREVIOUS_WINDOW=$(cat "$STATE_FILE")
    # Check if the previous window still exists
    if niri msg --json windows | jq -e ".[] | select(.id == $PREVIOUS_WINDOW)" >/dev/null 2>&1; then
      niri msg action focus-window --id "$PREVIOUS_WINDOW"
      rm "$STATE_FILE"
    else
      # Previous window no longer exists, just remove the state file
      rm "$STATE_FILE"
    fi
  fi
else
  # Not on browser, switch to browser
  if [ -n "$BROWSER_WINDOW_ID" ]; then
    # Save current window ID before switching
    echo "$CURRENT_WINDOW_ID" >"$STATE_FILE"
    niri msg action focus-window --id "$BROWSER_WINDOW_ID"
  else
    # Browser not open, spawn it (and save current window)
    echo "$CURRENT_WINDOW_ID" >"$STATE_FILE"
    niri msg action spawn -- flatpak run "$BROWSER_APP_ID"
  fi
fi
