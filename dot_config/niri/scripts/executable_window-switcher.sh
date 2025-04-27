#!/bin/bash

# Script to list windows using 'niri msg windows' and switch focus using wofi
# Entries show ONLY the Window Title

# 1. Get window list directly from niri
window_data=$(niri msg windows)

# Check if niri command was successful
if [ $? -ne 0 ]; then
  command -v notify-send >/dev/null &&
    notify-send --urgency=critical "Window Switcher Error" "Failed to execute 'niri msg windows'. Is Niri running?"
  exit 1
fi

# 2. Parse the text output using awk
window_list=$(echo "$window_data" | awk '
BEGIN { RS = ""; FS = "\n" }
{
    window_id = ""; title = ""; app_id = ""; is_focused = 0; # app_id is read but not used for display

    # Process each line in the window block
    for (i = 1; i <= NF; i++) {
        line = $i;
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", line); # Trim whitespace

        if (match(line, /^Window ID ([0-9]+)( \(focused\))?:/, arr)) {
            window_id = arr[1];
            if (arr[2] != "") { is_focused = 1; } # Check if focused
        } else if (match(line, /^Title: "(.*)"$/, arr)) {
            title = arr[1];
        } else if (match(line, /^App ID: "(.*)"$/, arr)) {
            app_id = arr[1]; # Still parse App ID in case needed later, but ignore for display
        }
    }

    # --- MODIFIED SECTION: Construct the display string (TITLE ONLY) ---
    if (window_id != "") {
        display_string = "";
        has_title = (title != "");

        if (has_title) {
            # Use the window title directly
            display_string = title;
        } else {
            # Fallback if title is empty (App ID is explicitly ignored for display)
            display_string = "[Untitled Window]";
        }
        # --- END OF MODIFIED SECTION ---

        # Optional: Skip the currently focused window from the list?
        # Uncomment the next line to hide the already focused window
        # if (is_focused == 1) next;

        # Print in "ID:::Description" format. Wofi shows Description,
        # but the full line is passed back on selection.
        print display_string;
    }
}
')

# Check if awk produced a list. Exit silently if empty.
if [[ -z "$window_list" ]]; then
  exit 0
fi

# 3. Pipe the list to wofi
selected_entry=$(echo "$window_list" | wofi --dmenu --prompt "Switch Window:")

# 4. Exit if nothing selected
if [[ -z "$selected_entry" ]]; then
  exit 0
fi

# 5. Extract the window ID (the part before :::)
window_id=$(echo "$selected_entry" | cut -d':' -f1)

# 6. Focus the selected window using niri msg
niri msg focus-window "${window_id}"

exit 0
