---
name: read-jira-task
description: Read details about Jira task
---

When user mentions a Jira task number, use the acli CLI to read task details.
Task numbers look like this:

- PSE-1234 - task of PSE team
- INV-384 - task of INV team
- etc...

Invoke:

```sh
acli jira workitem view "$TASK"
```
