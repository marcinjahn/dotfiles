#!/bin/bash

# AWK script to parse 'pactl list cards' output.
# Extracts Card Index, Profile Name, and Profile Description for potential OUTPUT profiles.
awk_parser_script='
BEGIN { FS="\n"; RS="" } # Read paragraph (card) at a time
{
    card_id = ""; profile_name = ""; profile_desc = "";
    card_index = -1;

    # Extract Card Index first
    if ($0 ~ /Card #([0-9]+)/) { match($0, /Card #([0-9]+)/, arr); card_index = arr[1]; }
    if (card_index == -1) next; # Skip if no card index found for this block

    # Use card index as the identifier needed by pactl set-card-profile
    card_id = card_index;

    # Iterate through lines within the card block to find the Profiles section
    in_profiles = 0;
    for (i=1; i<=NF; ++i) {
        line = $i;
        # Detect start/end of Profiles section
        if (line ~ /^[ \t]*Profiles:/) { in_profiles = 1; continue; }
        # Stop searching if we leave the indented profile list
        if (in_profiles && line !~ /^[ \t]+/) { in_profiles = 0; }
        if (!in_profiles) continue;

        # Attempt to extract profile name and description
        # Format usually: <tab><profile_name>:<tab><description><space>(priority/available info)
        if (match(line, /^[ \t]+([a-zA-Z0-9_.:-]+):[ \t]+([^ ].*?)[ \t]+(\(.*\))?$/, p)) {
            profile_name = p[1];
            profile_desc = p[2];
            # Heuristic check if it seems like an output profile (contains output/playback/HiFi/speaker/headphones etc.)
            # This might need tuning based on your exact profile names
            if (profile_name ~ /output|playback|HiFi|speaker|headphone/ && profile_name !~ /input|capture|mic/) {
                 # Output format: Description (Card N)::::CardID::::ProfileName
                 # Adding CardID to description helps if multiple cards have "Speakers" etc.
                 print profile_desc " (Card " card_id ")"::::card_id::::profile_name;
            }
        }
    }
}
'

# Run pactl list cards and pipe its output through the AWK parser script.
mapfile -t profiles < <(pactl list cards | awk "$awk_parser_script")

# Check if the parsing found any potential profiles
if [ ${#profiles[@]} -eq 0 ]; then
    notify-send "Audio Profile Selection" "Pactl parser found no suitable audio output profiles."
    exit 1
fi

# Prepare options for wofi: store Description->CardID/ProfileName mapping
declare -A profile_map # profile_map["Description (Card N)"]="CardID::::ProfileName"
options_string=""
declare -A processed_descs_map # Track descriptions to avoid duplicates

for profile_data in "${profiles[@]}"; do
    if [[ -z "$profile_data" ]]; then continue; fi

    display_desc="${profile_data%%::::*}"             # Extract description (part before first ::::)
    card_and_profile="${profile_data#*::::}"          # Extract CardID::::ProfileName (part after first ::::)
    card_id="${card_and_profile%%::::*}"              # Extract CardID
    profile_name="${card_and_profile#*::::}"          # Extract ProfileName

    # Ensure all parts were extracted correctly
    if [[ -n "$display_desc" && -n "$card_id" && -n "$profile_name" ]]; then
        # Avoid adding duplicate display descriptions (e.g., if parsing finds same profile twice)
        if [[ -z "${processed_descs_map[$display_desc]}" ]]; then
             profile_map["$display_desc"]="$card_id::::$profile_name"
             options_string+="$display_desc\n"
             processed_descs_map["$display_desc"]=1 # Mark as processed
        fi
    else
         echo "Warning: Skipped malformed line from profile parser: $profile_data" >&2
    fi
done

if [ -z "$options_string" ]; then
     notify-send "Audio Profile Selection" "Failed to extract valid profiles after parsing pactl output."
     exit 1
fi

options_string=$(echo -e "$options_string" | sed '$d')

# Display the menu using wofi
chosen_desc=$(echo -e "$options_string" | wofi --dmenu -i -p "Select Audio Profile")

if [ -z "$chosen_desc" ]; then
    exit 1
fi

# Retrieve the CardID and ProfileName associated with the user's chosen description
card_and_profile="${profile_map[$chosen_desc]}"
chosen_card_id="${card_and_profile%%::::*}"
chosen_profile_name="${card_and_profile#*::::}"

# Set the selected card profile using pactl
if [[ -n "$chosen_card_id" && -n "$chosen_profile_name" ]]; then
    pactl set-card-profile "$chosen_card_id" "$chosen_profile_name"
    notify-send "Audio Profile Changed" "Set: $chosen_desc"

    # Optional: Send a signal to Waybar
    # pkill -RTMIN+8 waybar
else
    notify-send "Audio Profile Selection Error" "Could not map '$chosen_desc' back to CardID/Profile."
    exit 1
fi

exit 0
