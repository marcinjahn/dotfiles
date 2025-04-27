#!/bin/bash

# Run the niri command to get focused window details
output=$(niri msg focused-window)
exit_status=$?

# Check if the niri command was successful
if [ $exit_status -ne 0 ]; then
  echo "Error: Failed to execute 'niri msg focused-window'. Exit status: $exit_status" >&2
  # Optional: Open a default Alacritty anyway? Or just exit?
  # alacritty &
  exit 1
fi

# Try to parse the App ID from the output
# Uses sed: -n suppresses default output, s/.../.../ substitutes, \1 refers to the captured group \(...\), p prints the result
app_id=$(echo "$output" | sed -n 's/.*App ID: "\(.*\)"/\1/p')

# Check if we successfully parsed the App ID
if [ -z "$app_id" ]; then
  echo "Warning: Could not parse App ID from niri output. Opening Alacritty in default directory." >&2
  alacritty &
  exit 0
fi

# Check if the focused application is Alacritty
if [ "$app_id" = "Alacritty" ]; then
  # It is Alacritty. Try to find its PID.
  # Uses sed: Captures the sequence of digits after "PID: "
  pid=$(echo "$output" | sed -n 's/.*PID: \([0-9]*\).*/\1/p')
  child_pid=$(pgrep -P $pid)

  if cwd=$(readlink "/proc/$child_pid/cwd" 2>/dev/null); then
    # Check if readlink actually returned a path
    if [ -n "$cwd" ]; then
      alacritty --working-directory "$cwd" &
    else
      # readlink succeeded but returned empty - unusual, but handle it.
      alacritty &
    fi
  else
    # Failed to readlink (process might have exited, permissions issue, etc.)
    alacritty &
  fi
else
  # Focused window is not Alacritty, just open a new default Alacritty window
  alacritty &
fi

# Exit successfully
exit 0
