---
name: create-pr
description: Create a GitHub PR. Only invoke when the user explicitly asks to create a PR.
user_invocable: true
---

Use the `create-pr` command (available in PATH) to create a GitHub PR. **Only run this when the user explicitly asks you to create a PR.** If you do not know the Jira task number, ask user.

## Usage

```
create-pr --task PSE-123 --ai <1|2|3|4|5> [--draft]
create-pr --title "Some title" --ai <1|2|3|4|5> [--description "Details"] [--draft] [--add-description]
```

Either `--task` or `--title` is required. `--ai` is always required.

## Arguments

- `--task TASK` — Jira task key (e.g. PSE-123). The script fetches the task from Jira, gets the code diff, and uses copilot to generate PR title, description, and branch name automatically.
- `--title "Title"` — Manual PR title (use when there's no Jira task).
- `--description "Details"` — Manual PR description (only with `--title`).
- `--add-description` — Auto-generate description from code diff using copilot (only with `--title`, mutually exclusive with `--description`).
- `--draft` — Create the PR as a draft.
- `--ai <1-5>` — AI contribution level label:
  - 1 = `ai-1-no-ai`
  - 2 = `ai-2-assisted`
  - 3 = `ai-3-collab`
  - 4 = `ai-4-native` (prefer this option when in doubt)
  - 5 = `ai-5-full-ai`

## How to invoke

Prefer the `--title` and `--description` options instead of `--task`. Use the `--task` option only
if you have no idea what the work was about. However, if you did work on the task, prepare title and
description yourself and provide them to the `create-pr` command.

The title should be succinct, and start from Jira task numebr. The description should explain how the change was implemented, concisely. Only go into detail for non-obvious parts. Plain text or markdown. Do not include any test plan checklists.

1. Run the script via Bash. Example:

   ```sh
   create-pr --task PSE-123 --ai 4
   ```

2. Report the resulting PR URL back to the user.
