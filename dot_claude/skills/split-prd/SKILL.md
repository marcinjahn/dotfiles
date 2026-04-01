---
name: split-prd
description: Turn a PRD into a multi-phase implementation plan using tracer-bullet vertical slices, saved as markdown files. Use when user wants to break down a PRD, create an implementation plan, plan phases from a PRD.
disable-model-invocation: false
---

# PRD to Tasks

We're discussing PRD `./my-prds/$0/PRD.md`.

Break a PRD into a phased implementation plan using vertical slices (tracer bullets). Output is a set of markdown files (one per task) in `./my-prds/$0/{HERE}`.
Task files should be numbered in a recommended implementation order. It could be that the PRD cannot
be broken down into any smaller tasks. It's OK, and you should communicate that!

## Process

### 1. Confirm the PRD is in context

The PRD should already be in the conversation. If it isn't, ask the user to paste it or point you to the file.

### 2. Explore the codebase

If you have not already explored the codebase, do so to understand the current architecture, existing patterns, and integration layers.

### 3. Identify durable architectural decisions

Before slicing, identify high-level decisions that are unlikely to change throughout implementation:

- Route structures / URL patterns
- Database schema shape
- Key data models
- Authentication / authorization approach
- Third-party service boundaries

### 4. Draft vertical slices

Break the PRD into **tracer bullet** phases. Each phase is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
- Do NOT include specific file names, function names, or implementation details that are likely to change as later phases are built
- DO include durable decisions: route paths, schema shapes, data model names
</vertical-slice-rules>

### 5. Quiz Me

Present the proposed breakdown as a numbered list. For each phase show:

- **Title**: short descriptive name
- **User stories covered**: which user stories from the PRD this addresses

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Should any phases be merged or split further?

Iterate until the user approves the breakdown.

### 6. Write the plan file

Create file for a task if it doesn't exist. Write the plan as a Markdown file. Name should start
form task number (tasks should be in some implementation order) and include max 3-word summary of
the task.

<plan-template>
# Plan: <Feature Name>

> Source PRD: <brief identifier or link>

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation. Reference specific sections of the parent PRD rather than duplicating content.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- Blocked by <task-number (if any, mention other tasks numbers that you'd create)

Or "None - can start immediately" if no blockers.

## User stories addressed

Reference by number from the parent PRD:

- User story 3
- User story 7

</plan-template>
