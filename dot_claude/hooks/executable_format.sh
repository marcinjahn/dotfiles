#!/bin/bash

# Formatter script that runs after evey file edit or creation.
# It reuses my Neovim Conform configuration to format the file, it actually runs a new headless
# Neovim session just for this need. It takes about ~450ms to execute.

FILE_PATH=$(cat | jq -r '.tool_input.file_path // empty')
[ -n "$FILE_PATH" ] && [ -f "$FILE_PATH" ] && nvim --headless "$FILE_PATH" +"lua require('conform').format({async=false, lsp_format='fallback'})" +wq 2>/dev/null || true
