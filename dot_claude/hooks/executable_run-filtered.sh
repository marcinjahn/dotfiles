#!/bin/bash

CMD_FILE="$1"

if [ -z "$CMD_FILE" ] || [ ! -f "$CMD_FILE" ]; then
  echo "run-filtered.sh: missing or invalid command file" >&2
  exit 1
fi

OUTPUT_FILE=$(mktemp /tmp/claude-code-run-filtered-hook-build-output-XXXXX)

bash "$CMD_FILE" >"$OUTPUT_FILE" 2>&1
EXIT_CODE=$?

rm -f "$CMD_FILE"

if [ "$EXIT_CODE" -eq 0 ]; then
  rm -f "$OUTPUT_FILE"
  notify-send "SUCCESS"
  echo "The command fully succeeded. The output has been cut to avoid bloat"
  exit 0
fi

OUTPUT=$(cat "$OUTPUT_FILE")
rm -f "$OUTPUT_FILE"

notify-send "RUNNING COPILOT"

SUMMARY=$(copilot --silent --prompt "Build/test output:\n\n$OUTPUT\n\nOnly summarize the above output. Do not investigate, explain causes, or suggest fixes. Just extract and list: specific errors, failing test names, and file/line numbers mentioned in the output." \
  --model claude-haiku-4.5 2>/dev/null)

if [ -z "$SUMMARY" ]; then
  notify-send "run-filtered.sh" "copilot summarization failed"
  echo "$OUTPUT"
else
  echo "The output has been truncated to include only important parts:\n\n$SUMMARY"
fi

exit "$EXIT_CODE"
