---
name: frontend-ui
description: Build or improve frontend UI — pages, dashboards, landing/hero sections, modals, forms, cards, tables, app layouts, components — so it looks intentionally designed and ships clean, non-redundant code. Use when creating new UI, polishing existing UI, or when the user says the UI looks bland, generic, unfinished, "AI-generated," or wants it to feel like a real, premium product. Covers design direction (avoiding templated/AI-slop looks), reuse-first implementation, accessibility, responsiveness, and complete loading/empty/error states.
---

# Frontend UI

Turn functional UI into product-quality UI that feels like a deliberate design
choice — without bloated or redundant code. Two failure modes to avoid at once:
UI that looks like a default AI-generated template, and code that reinvents
primitives the project already has.

General code-quality, React, and safety rules live in `senior-engineering`;
this skill adds the design judgment and UI-specific engineering on top.

## First: existing system or greenfield?

Always inspect before designing. Read the project's design tokens / Tailwind
config / theme, existing components, layout patterns, and the pages that already
look good.

- **There is a design system** (shadcn/ui, a component library, or established
  tokens): respect it. Reuse existing primitives before building new ones,
  compose them cleanly, keep Radix/shadcn accessibility intact, use theme tokens
  rather than one-off colors/spacing, and match the established visual language.
  Do not introduce a different look unless the user asked for a redesign. This
  is the common case and the priority.
- **Greenfield, no system**: you get to set direction. Make distinctive,
  subject-grounded choices (below), and create the *minimum* set of reusable
  primitives — don't hand-roll a parallel design system.

## Designing to avoid AI slop

The point isn't to add more visual effects — it's to make choices that fit *this*
product. Decoration that doesn't carry meaning is what makes UI read as
machine-generated.

**Ground every choice in the subject.** Palette, type, and layout should come
from what the product actually is and who uses it — not a generic "modern SaaS"
default. If the brief doesn't pin the subject down, pin it yourself and say so.

**Avoid the current AI-default looks.** Generated UI clusters around a few tells;
don't reach for these unless the brief specifically calls for one:

- Cream/off-white background + high-contrast serif headline + terracotta accent.
- Near-black background with a single acid-green or vermilion accent.
- The "big number + tiny label + gradient blob" hero on a blank background.
- Reflexively sprinkling gradients, glows, glass panels, and animated blobs to
  fill empty space.
- Numbered eyebrows (01 / 02 / 03) on content that isn't actually a sequence.

Structure should encode something true (a real sequence, a real hierarchy), not
decorate.

**Spend boldness in one place.** Pick one signature element — the thing the page
is remembered by — and keep everything around it quiet and disciplined. Cut any
decoration that doesn't serve the brief. Restraint reads as premium; clutter
reads as generated. (Chanel's rule: before leaving, remove one accessory.)

**Typography carries personality.** Set a clear type scale with intentional
weights and spacing. Strong headings, readable body, muted supporting text. The
type treatment should be a deliberate part of the design, not a neutral default.

**Motion is deliberate, not ambient.** A considered page-load or scroll reveal,
or restrained hover micro-interactions, beats scattered effects. Over-animation
is itself an AI-slop tell. Respect `prefers-reduced-motion`.

**Plan, then critique, then build.** Sketch a compact direction (palette as 4–6
named hex values, 2 type roles, a layout concept, one signature element). Before
coding, ask: "would I produce this exact thing for any similar prompt?" If yes,
change the part that's generic and say why. Critique again after building.

## Optimal, non-redundant code

Premium UI with bloated code is still a failure. Keep it lean:

- **Reuse before you create.** Check for an existing component/variant before
  writing a new one. Don't duplicate a button, card, or input that already
  exists.
- **Tokens, not magic values.** Use theme/Tailwind tokens for color, spacing,
  radius, and shadow. Avoid random one-off hex values and arbitrary pixel
  values. Keep responsive utilities intentional, not copy-pasted.
- **No useless wrappers.** Don't wrap a simple component in an extra abstraction,
  and don't add a one-off abstraction with a single caller.
- **Watch CSS specificity.** Don't generate selectors that cancel each other out
  (a type-based `.section` fighting an element-based `.cta` over the same
  margin). Keep spacing logic in one place per section.
- **Derive, don't store.** Compute view values instead of holding redundant
  state; keep `useEffect` out of simple derived state. Memoize only for a real
  reason.

## Always handle real states

UI must survive real data. Before finishing, make sure the page works with: real
data, **empty** data, **loading**, **error**, and **long text**. Each of these
has standard patterns — see `references/ui-checklists.md` for the per-component
detail (forms, modals, tables/dashboards, hero, empty/loading/error states).

## Quality floor (non-negotiable)

- Responsive down to mobile; layout doesn't break on tablet/desktop.
- Visible keyboard focus; hover/focus/disabled states present.
- One obvious primary action per view; secondary actions visually quieter.
- Accessible names/labels on inputs and controls.
- Dark mode honored if the project supports it.
- Don't show raw technical errors to end users (developer tools excepted).

## Self-review before finishing

Ask, and keep going if any answer is no: Does it look better than before? Is the
primary action obvious? Could it pass as a shipped product rather than a
wireframe? Is spacing consistent and the type scale clear? Is mobile good? Are
empty/loading/error states handled? Did the design make a real choice for this
subject, or fall back to a default? Did I reuse existing components and tokens
instead of duplicating them?
