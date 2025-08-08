if pgrep -x "wiremix" >/dev/null; then pkill -x "wiremix"; else
  alacritty -e wiremix &
  disown
fi
