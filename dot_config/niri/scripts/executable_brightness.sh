#!/bin/bash

# Script to increase or decrease brightness using brightnessctl

BRIGHTNESSCTL_CMD="brightnessctl"

ACTION="$1"
PERCENTAGE="$2"

case "$ACTION" in
increase)
  $BRIGHTNESSCTL_CMD set "+${PERCENTAGE}%"
  ;;
decrease)
  $BRIGHTNESSCTL_CMD set "${PERCENTAGE}%-"
  ;;
*)
  echo "Error: Invalid action '$ACTION'."
  echo "Action must be 'increase' or 'decrease'."
  exit 1
  ;;
esac

exit 0
