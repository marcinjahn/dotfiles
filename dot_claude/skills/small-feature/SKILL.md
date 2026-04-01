---
description: Implement a new feature as described
disable-model-invocation: true
model: sonnet
---

Implement the new feature.

## Feature Requirements

$ARGUMENTS

## Your Work Style Requirements

- Make sure to use appropriate coding subagent to delegate the work to.
- Make sure the code builds and tests pass
- ask if if anything is unclear regarding requirements or implementation decisions.

### After the coding is done

Use separate subagent to review all the work done so far for the feature.
The subagent should assess the work and tell if there's something that should be changed of
improved. If some critical thing should be improved, directly spin up appropriate subagent to do the
work. For less important ideas, ask me first if the change is truly needed.
After potential improvements are made, repeat the process of review and assessment.
If reviewer does not see anything that needs to change, just consider the work done.

### After the whole work is done

- update existing AGENTS.MD or CLAUDE.MD file in the project to reflect the changes that were mode (unless the change you made was not that impactful and future agents agents do not need to know about it)
