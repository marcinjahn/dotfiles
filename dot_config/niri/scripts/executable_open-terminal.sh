#!/bin/bash

# The terminal emulator to use.
TERMINAL="alacritty"
# The app_id for the terminal.
# To find the app_id, focus the terminal and run:
# niri msg windowris
TERMINAL_APP_ID="Alacritty"

# Opens a new alacritty window, trying to retain cwd from
# the previously focused alacritty window

output=$(niri msg focused-window)
exit_status=$?

if [ $exit_status -ne 0 ]; then
  echo "Error: Failed to execute 'niri msg focused-window'. Exit status: $exit_status" >&2
  exit 1
fi

app_id=$(echo "$output" | sed -n 's/.*App ID: "\(.*\)"/\1/p')

if [ -z "$app_id" ]; then
  echo "Warning: Could not parse App ID from niri output. Opening Terminal in default directory." >&2
  $TERMINAL &
  exit 0
fi

if [ "$app_id" = "$TERMINAL_APP_ID" ]; then
  pid=$(echo "$output" | sed -n 's/.*PID: \([0-9]*\).*/\1/p')
  child_pid=$(pgrep -P "$pid")

  if cwd=$(readlink "/proc/$child_pid/cwd" 2>/dev/null); then
    if [ -n "$cwd" ]; then
      $TERMINAL --working-directory="$cwd" &
      # alacritty --working-directory "$cwd" &
    else
      $TERMINAL &
    fi
  else
    $TERMINAL &
  fi
else
  $TERMINAL &
fi

exit 0
