#!/bin/bash

VIDEO_DIR="$HOME/Videos/Screencasts"
mkdir -p "$VIDEO_DIR"

# This file stores the filename of the video currently being recorded.
# It will allow to build proper notification once the recording gets stopped.
TMP_FILE="/tmp/wl-screenrec-lastfile.txt"

if pkill wl-screenrec; then

  pkill -SIGRTMIN+8 waybar # hide recording indicator on waybar

  LAST_FILE=$(cat "$TMP_FILE")
  LAST_DIR=$(dirname "$LAST_FILE")

  ACTION_CLICKED=$(notify-send -t 6000 \
    --action=default="Open Folder" \
    "Screen Recording Stopped" \
    "Saved to: $LAST_DIR\nFile: ${LAST_FILE##*/}")

  if [[ "$ACTION_CLICKED" == "default" ]]; then
    xdg-open "$LAST_DIR" &
  fi

  rm "$TMP_FILE"
else
  FILENAME="$VIDEO_DIR/$(date +'Screencast From %Y-%m-%d %H-%M-%S.mp4')"

  echo "$FILENAME" >"$TMP_FILE"

  if geometry=$(slurp); then
    wl-screenrec -g "$geometry" -f "$FILENAME" -b "2 MB" --encode-resolution 1920x1080 &
    sleep 0.1
    pkill -SIGRTMIN+8 waybar # display recording indicator on waybar
  else
    rm "$TMP_FILE"
  fi
fi
