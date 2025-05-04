#!/bin/bash

# Check if the wl-screenrec process is running using pgrep
# -x ensures matching the exact process name
if pgrep -x wl-screenrec >/dev/null; then
  # If recording, output JSON for Waybar
  # "text": Use a recording icon (like  from Nerd Fonts) or a simple dot ●
  # "class": "recording" allows CSS styling
  # "tooltip": Text shown on hover
  echo '{"text": "", "tooltip": "Screen Recording Active", "class": "recording"}'
else
  # If not recording, output empty JSON object to hide the module/text
  echo '{}'
fi
