---
name: triage-issue
description: Triage a bug or issue by exploring the codebase and analyzing logs to find root cause.
disable-model-invocation: false
---

# Triage Issue

You are a part of PSE team.
Investigate reported problem described in Jira task $0. Find root cause and propose solutions.

## Products

You work for eSky travel company that sells travel packages (flight+hotel) and hotels via website.
Our products consists of a few microservices, and the issue might span a couple of them, or just one.

### Packages Product

We have the following applications:

- [jan](https://github.com/eskygroup/workspace/tree/master/apps/jan) - a frontend application, usually the bugs seen by users are manifested in this app (although
  source of bug might be somewhere else).
- [esky-hotway](https://github.com/eskygroup/esky-hotway) - a BFF for jan. It mostly collects data from other microservices to build response for
  JAN. It also handles other use-cases like providing package/hotel data to other clients (within
  company usually though)
- [esky-hotels-packages-flexsearch-api](https://github.com/eskygroup/esky-hotels-packages-flexsearch/)- API that PSE team maintains. It is used mostly to return
  packages search results. It mostly is a "proxy" that
  calls the following services to collect search results:
  - esky-hotels-packages-hotelindex-api
  - esky-packages-api
  - esky-hotels-revenue-api
    Hotway uses flexsearch to get search results
- [esky-hotels-packages-hotelindex-api](https://github.com/eskygroup/esky-hotels-packages-hotelindex/) - API that has catalogues of hotels and will return applicable
  hotels for given search criteria. It has very limited knowledge about hotels availability.
- [esky-packages-api](https://github.com/eskygroup/esky-packages) - an actual source of offers. Maintained by a different team (INV).
  flexsearch-api sends list of hotels it got from hotelindex to this service to get actual offers.
- [esky-hotels-revenue-api](https://github.com/eskygroup/esky-hotels-revenue/) - service that calculates final price of offers and discounts.

The services above are **CRITICAL** - they provide the core functionality of our packages product.

Other services:

- [esky-hotels-wishlist-api](https://github.com/eskygroup/esky-hotels-wishlist/) - manages wishlists
  that users can create. Users save favourite offers to their wishlist. It's used by Hotway.

### Hotels Product

- [hot](https://github.com/eskygroup/workspace/tree/master/apps/hot) - a frontend application, usually the bugs seen by users are manifested in this app (although
  source of bug might be somewhere else).
- [esky-hotway](https://github.com/eskygroup/esky-hotway) - a BFF for hot. It mostly collects data from other microservices to build response for
  JAN. It also handles other use-cases like providing package/hotel data to other clients (within
  company usually though)

## Process

### 1. Check if some files in `/home/mnj/triage-issues/$0-*` already exist. It means that some agent

already worked on this project, and you should continue to work from where they left off. Read
markdown files if you find any there. If not, clear that issue directory and start analysis from scratch.
If you're continuing previous work, treat the steps below more as a suggestion, because you will
more likely want to follow up on the notes left by previous agent.

### 2. Capture the Problem

Read details about the Jira task (use `/read-jira-task` skill).

### 3. Explore and diagnose

Use the information in the Jira task to decide which application could be involved in the issue.
If it's clear from task description alone, explore the appropriate codebase.
You can clone the application into some temp directory in `/home/marcin/triage-issues`.
You should create a new directory there to keep all things you do as part of resolving this issue.
Name the directory after Jira task number and add max 3 words summarizing the issue, for example
`PSE-1234-hotway-search-bug`.

You might want to look at application logs to see if the issue is manifested in logs or traces. You
will want to use `/check-production-logs` skill for that.

If the data available to you via source code and logs is not enough to learn some detail you need in
your work, ask me for help. I might be able to provide the missing information.

### 4. Propose Solution(s)

When you have a clear idea of what caused the problem, propose a solution, or alternative solutions
if you think problem could be resolved in many ways.

### 5. (Optional) Document your Findings

If you found the root cause and solution, document it in new markdown file in the issue's directory.
Even if you didn't finish your job, but found some valuable information, document it for future agents.
You can document your work as you go, if you feel you found something particularly interesting.

## Tips

### App Builds

When you analyze production logs with stack traces and find it difficult to pinpoint where a given error occurs in app's source (mostly JS/TS apps), consider pulling
docker image of the build that was failing in production to look at the source there.
stack traces.
