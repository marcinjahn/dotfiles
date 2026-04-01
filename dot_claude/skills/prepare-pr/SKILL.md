---
description: Create Pull Request
disable-model-invocation: true
model: haiku
---

Do the following, use only commands mentioned here, do not use any other commands!
Note that I do not use git, I use jj commands instead.
Do not ask for confirmation unless you try to do something different than listed in instructions
below.

## Fetch Task From Jira

Fetch data about the task $1 from Jira, using command:

```sh
acli jira workitem view $1
```

## Name the commit

Prepare commit title and description.

Base it on Jira task's summary and description (that you fetched) and
code implementing the change. If you do not know the code that is being
added, use `jj diff --from master` to see the diff.

The title should be concise and inform on high level what was done, following best practices for commit messages. Always start commit title with task number ($1).
Commit title example: "PSE-123 Adds /abc/def endpoint".

The description should inform how it was implemented, going into details only when something could
be unclear or odd.
Do not mention CLAUDE.md or AGENTS.md being updated.

Use jj for it, with command:

```sh
jj describe -m '$1 {the rest of the title}'\n\n'{commit description}'
```

## Create a branch and push it

Create a branch, name it as a combination of: task number ($1) and one or two words describing the
task in general, separated by "-". Example: "pse-4673-fix-auth".

```sh
jj bookmark create {branch-name} && jj git push -b {branch-name}
```

## Create GitHub PR

Use command:

```sh
gh pr create --head {name of branch you created} --fill
```
