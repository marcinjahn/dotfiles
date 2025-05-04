#!/bin/bash

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
  echo "Warning: Could not parse App ID from niri output. Opening Alacritty in default directory." >&2
  alacritty &
  exit 0
fi

if [ "$app_id" = "Alacritty" ]; then
  pid=$(echo "$output" | sed -n 's/.*PID: \([0-9]*\).*/\1/p')
  child_pid=$(pgrep -P "$pid")

  if cwd=$(readlink "/proc/$child_pid/cwd" 2>/dev/null); then
    if [ -n "$cwd" ]; then
      alacritty --working-directory "$cwd" &
    else
      alacritty &
    fi
  else
    alacritty &
  fi
else
  alacritty &
fi

exit 0
