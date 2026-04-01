---
description: Writing and reviewing C# code. Use whenever you write or review C#
model: sonnet
---

When writing or reviewing C# code, make sure you use the latest standards and modern syntax.

## Good Practices

- Write code that is readable and maintainable, keeping up with good OOP practices like
  encapsulation, separation of concerns and single responsibility principle.

## Functional Style

- prefer declarative, functional style over imperative when possible
- use LINQ
- if solution uses CSharpFunctionalExtensions, use its Maybe and Result<T, E> types and methods

## Architecture

- if the app follows clean architecture, make sure you put your code in the right layers and follows
  existing patterns.
- when working on the Domain layer, adhere to DDD principles, making sure the domain clearly states
  the business requirements of the sub-domain.

## Syntax

- prefer collection expressions
- prefer switch expressions
- always use `{}` braces, in every IF and FOREACH statement
- use `=>` syntax for methods where possible, unless it's better for performance not to do it.

## NuGet

- when adding new packages, make sure you install the latest stable version

## Testing

- Use XUnit framework
- Do NOT use FluentAssertions unless editing test files that already use it

## Performance

- use structs where it makes sense
- use Span<T> and Memory<T> where it makes sense
- avoid allocations where it gives noticeable performance benefits (especially hot paths)
- if you see ways to implement some code in much more performant way that could decrease
  readability, mention that as an option, and await for user's choice.
