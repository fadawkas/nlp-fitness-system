# UI Checklists (per component)

Detailed, practical checklists referenced by the `frontend-ui` skill. Load when
working on the specific component type. These are defaults to adapt, not a
recipe to apply mechanically — the skill's design judgment still governs, and
the project's existing design system always wins over the numbers here.

## Foundations (apply to everything)

Component checklists verify what's *present*; these decide whether it looks
*designed*. Get these right first.

- **Spacing:** one scale (e.g. 4/8-based), used consistently. No arbitrary
  one-off pixel values. Be generous — cramped reads as unfinished, whitespace is
  a choice.
- **Type:** a real scale with clear jumps between levels (not five near-identical
  sizes); limit to ~2–3 weights. Body ~16px+, line length ~60–75 characters.
  Headings lead through hierarchy, not just boldness.
- **Color:** drive everything from semantic tokens (background, surface, border,
  muted, foreground, primary, destructive). One restrained accent for the main
  action; reserve red/green for status, not decoration. Keep most of the page
  neutral so the accent actually draws the eye.
- **Depth & shape:** one consistent radius and a restrained shadow system (1–2
  elevations). A subtle border *or* a soft shadow to separate things — not both
  stacked on every card.
- **Hierarchy:** exactly one primary action per screen, clearly the loudest
  element; secondary actions quieter. If two things shout, neither wins.
- **Signature:** spend boldness in one place — one memorable element that fits
  the subject — and keep everything around it quiet. Then remove one thing that
  doesn't earn its place.

## The AI-slop tells to avoid

If the design has these, it reads as generated. Check against them before
finishing:

- Filler decoration: gradient blobs, glows, glassmorphism, animated background
  shapes added to fill space rather than to mean something.
- The default palettes reached for by reflex: cream + serif + terracotta;
  near-black + one acid-green/vermilion accent. Fine if the brief asks; a tell
  if it appears regardless of subject.
- Numbered eyebrows (01 / 02 / 03) on content that isn't an actual sequence.
- Everything bold at once: competing accents, every card shadowed, every section
  a gradient — no hierarchy, so nothing leads.
- Uniform everything: one shadow, one weight, evenly spaced — a wireframe, not a
  designed page.
- Emoji as iconography, lorem-flavored copy, the "big stat + tiny label +
  gradient blob" hero, and motion on every element.

## Layout

- Group related content into clear sections; use max-width containers for
  readable line lengths.
- Generous, consistent spacing on a single scale. Align elements cleanly on a
  grid.
- Use cards only when they genuinely improve grouping. Avoid border overload and
  plain white boxes floating on empty backgrounds.
- Use subtle gradients, background grids, glows, or blurred shapes only when
  they support the design — never as filler.

## Forms

- Every input has a clear label or accessible name; helper text where useful.
- Show validation errors near the field, in the interface's voice (say what
  happened and how to fix it).
- Prevent duplicate submissions; show a loading state on submit.
- Primary and secondary actions are visually distinct; the primary action is
  obvious.

## Modals and overlays

- Proper dimmed backdrop.
- Clear title, description, body, and actions.
- Responsive width; never cramped. Close/cancel behavior is obvious.

## Tables, lists, and dashboards

- Use a table only when tabular comparison actually matters; otherwise prefer
  cards/lists.
- Summary cards for key metrics; status badges for states.
- Keep search/filter visible and easy to reach.
- Consistent row actions. Avoid dense, unreadable tables.
- Provide an empty state with a helpful next action.

## Empty states

Every empty state needs: a simple title, a one-line explanation, an optional
next action, and an optional icon/visual. Treat emptiness as an invitation to
act, not dead space.

## Loading states

- Skeletons for content-heavy pages; button loading states for actions.
- Avoid layout shift between loading and loaded.

## Error states

- Make errors understandable and actionable: what went wrong, what to do next.
- Errors don't apologize and aren't vague. Don't surface raw stack traces to end
  users (developer tools are the exception).

## Hero sections

A strong hero usually pairs a clear headline, short supporting line, a primary
CTA (and a secondary CTA when useful), and a visual anchor — a product preview,
mockup, image, stats, or a deliberate graphic. Avoid hero sections that are just
text on a blank background. Lead with the most characteristic thing in the
subject's world; the generic "big stat + gradient" hero is a last resort, not a
default.

## Quality floor (non-negotiable)

- Responsive from ~360px up; nothing overflows or clips on mobile.
- Visible keyboard focus on every interactive element; logical tab order.
- Hover, focus, active, and disabled states all present and distinct.
- Contrast meets WCAG AA (≈4.5:1 text, 3:1 large text/UI). Don't rely on color
  alone to convey meaning. Touch targets ~44px.
- Honor dark mode if the project has it, and `prefers-reduced-motion`.

## Reference patterns (extract, don't copy)

Use references for direction only when you can actually view them (browser/search
available), and always adapt to the project's own visual language — never copy
branding, proprietary assets, or a full layout wholesale. Match the reference to
the surface:

- **App UI** (dashboards, forms, settings, data, flows): study systems with
  strong, consistent, usable design — shadcn/ui, Tailwind UI, Linear, Vercel,
  Stripe, Notion, Raycast, Supabase — and real shipped app screens on Mobbin.
  These teach layout, hierarchy, spacing, and interaction without pushing toward
  decoration.
- **Expressive surfaces** (landing, hero, marketing, portfolio): curated
  galleries like Godly, Land-book, and siteInspire are good for distinctive
  direction and escaping templated defaults.

Caution: galleries (especially Awwwards and Dribbble) bias toward maximalist,
heavily animated, sometimes unbuildable concepts — a *different* flavor of slop.
Extract the idea (a layout move, a type pairing, a signature element), not the
animation budget. Usability and the project's design system still govern, and
the "spend boldness in one place" rule still applies.