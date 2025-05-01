#!/bin/bash

# Check the current mako mode
# We specifically look for the 'do-not-disturb' mode.
# The '-q' option makes grep quiet, it only sets the exit status.
if makoctl mode | grep -q 'do-not-disturb'; then
  # Do Not Disturb mode is active - Notifications are OFF
  ICON="󰂛" # nf-md-bell_off (Strikethrough Bell)
  TOOLTIP="Notifications Disabled (Do Not Disturb)"
  CLASS="disabled"
else
  # No 'do-not-disturb' mode found - Notifications are ON
  ICON="󰂚" # nf-md-bell (Bell)
  TOOLTIP="Notifications Enabled"
  CLASS="enabled"
fi

# Output in Waybar's JSON format
# Escape quotes in tooltip for valid JSON
TOOLTIP_ESCAPED=$(printf '%s' "$TOOLTIP" | sed 's/"/\\"/g')
printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$TOOLTIP_ESCAPED" "$CLASS"
