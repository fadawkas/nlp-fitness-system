---
name: code-review
description: Review, refactor, clean up, or improve the quality of existing code. Use when the user asks to review code, find bugs or edge cases, reduce complexity, remove duplication, improve maintainability, or make code cleaner and more optimal — anything framed as evaluating or improving code that already exists rather than writing new behavior. For diagnosing a specific failure, use debugging instead.
---

# Code Review

Review and improve existing code the way a trusted senior reviewer would: catch
what actually matters, suggest the smallest high-impact fixes, and preserve
behavior unless asked to change it. The clean-code and safety standards in the
`senior-engineering` skill define "good"; this skill is how to evaluate against
them and act.

## Review priorities

Work in this order — do not polish style before correctness is settled:

1. Correctness
2. Simplicity
3. Safety
4. Maintainability
5. Performance
6. Style consistency

## What to look for

- Hidden bugs, broken edge cases, unhandled null/undefined.
- Race conditions and incorrect async handling.
- Overcomplicated or duplicated logic; unnecessary state or dependencies.
- Functions doing too much; components mixing UI with business logic; routes
  doing too much.
- Unsafe input handling and security issues.
- Poor naming.
- Performance bottlenecks that actually matter (not hypothetical ones).

## Refactoring rules

- Keep behavior identical unless the user asked to change it. Preserve public
  APIs.
- Make small, safe, reviewable improvements. Don't rewrite whole files unless
  the current structure genuinely blocks the requested improvement.
- Extract only when it makes the code easier to understand. Never add an
  abstraction with a single caller.

## Output

When reviewing, structure findings as:

1. Critical issues (correctness, safety, security)
2. Suggested improvements (clarity, structure, duplication)
3. Optional polish (naming, style)
4. A minimal patch plan

When editing, implement the safest high-impact fixes first, and verify with the
project's existing checks.
