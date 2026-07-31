# Research: Currency List & Detail

**Input**: `spec.md` (FR-001..FR-019), `design-context.md` (Figma extraction), `.specify/memory/constitution.md` v1.0.0

This document resolves every open technical decision needed before Phase 1 design. Each
decision is scoped to what this feature actually needs — no speculative infrastructure.

## 1. Either/Failure type: `dartz` vs `fpdart`

- **Decision**: `fpdart`, specifically its `Either<Failure, T>`.
- **Rationale**: Constitution Principle III names both as acceptable. `fpdart` is actively
  maintained (last `dartz` release predates null-safety-era Dart tooling churn), has better
  null-safety-native ergonomics, and is the more common choice in current Flutter/Bloc
  starter kits — lower friction for anyone picking up this codebase later.
- **Alternatives considered**: `dartz` — rejected only on maintenance-recency grounds; either
  would technically satisfy Principle III.

## 2. 30-day trend chart implementation

- **Decision**: Custom `CustomPainter`-based sparkline/line chart (`core/widgets/trend_sparkline.dart`
  used inside `TrendCard` and the Detail chart area), no charting package dependency.
- **Rationale**: The Figma `TrendCard` and Detail chart are flagged in `design-context.md` as
  solid-color placeholder blocks that need a real 30-day line rendered. A 30-point line/area
  chart with min/max and start/end markers is well within `CustomPainter` scope (a `Path`
  through normalized points). Constitution's "Allowed Dependencies" list is deliberately closed
  (`get_it`+`injectable`, `go_router`, `freezed`+`json_serializable`) and any addition outside it
  needs an explicit constitution amendment. Since a hand-rolled painter fully satisfies FR-006
  without expanding the dependency surface, it's the simpler choice over pulling in `fl_chart` or
  similar.
- **Alternatives considered**: `fl_chart` — more features (tooltips, animations) than this
  feature needs; would require a constitution amendment for no functional gain here.

## 3. Testing Bloc/Cubit state emissions: `bloc_test` vs manual stream assertions

- **Decision**: Add `bloc_test` (dev dependency only) for Cubit unit tests.
- **Rationale**: Principle II mandates Bloc/Cubit for all presentation logic and Principle VI
  mandates unit tests with ≥80% domain coverage. `bloc_test` is the `flutter_bloc` team's own
  companion testing package — it doesn't introduce a competing state-management approach or a
  new runtime dependency (it's dev-only, mirrors `mocktail`'s dev-only status under Principle
  VI). Manual `expectLater(cubit.stream, emitsInOrder([...]))` assertions are the alternative
  but are more verbose and error-prone for the multi-state sequences this feature needs
  (loading → loaded / loading → error / loaded → stale-error-kept). Flagged in plan.md
  Complexity Tracking since it is not in the constitution's literal "Allowed Dependencies" list.
- **Alternatives considered**: hand-written stream assertions with `mocktail` only — rejected as
  needlessly verbose for ~15+ Cubit test cases across 2 features.

## 4. Base currency persistence mechanism

- **Decision**: Hive, via a single `core/settings` box (`app_settings`) with key
  `selected_base_currency`.
- **Rationale**: Principle V mandates Hive for "any data that must survive an app close." FR-002
  requires the selected base currency to persist across restarts — it qualifies even though the
  principle's example is the watchlist, not the base currency. Keeping it in its own small box
  (rather than extending it into a general key-value store) avoids scope creep.
- **Alternatives considered**: `shared_preferences` — simpler for a single string, but introduces
  a second local-storage mechanism, which Principle V explicitly exists to avoid.

## 5. Currency list "icon" placeholder (Figma shows an unstyled circle)

- **Decision**: Render a 36×36 circle (`radius-pill`, bg `color-bg-surface-elevated`) containing
  the currency code's first two letters as `Label/SemiBold-12`-styled text, `color-text-secondary`.
  No external icon/flag asset package.
- **Rationale**: `design-context.md` flags the icon as "swap for flag/currency icon... source
  separately" — no icon set is specified by product or Figma. A text-initial avatar keeps the
  component fully data-driven (works for any currency the API returns, including ones without a
  flag asset available) and adds zero new dependencies.
- **Alternatives considered**: A flag-icon package (e.g. country flags) — rejected: currency
  codes don't map 1:1 to countries (EUR, XCD, etc.), and it's an unrequested new dependency.

## 6. Locale of UI copy

- **Decision**: Spanish, mirroring the Figma copy verbatim ("Buscar moneda...", "Actualizado
  hace {n} min", error/retry copy in Spanish). Code identifiers, comments, and this documentation
  stay in English.
- **Rationale**: The user's plan instruction is explicit that Figma is "sign source of truth" and
  components must mirror Figma 1:1; the Figma frames' copy is Spanish throughout (List and
  Detail). Defaulting to what the source of truth actually contains is lower-risk than guessing
  at an English translation product hasn't approved. `design-context.md` flag #5 asks to confirm
  target locale with product — noted here as a residual, non-blocking follow-up.
- **Alternatives considered**: English copy matching the (English) spec prose — rejected because
  the spec's language is incidental to writing the document, not a localization requirement; the
  design file's actual copy is the more direct source of truth per the explicit instruction.

## 7. Detail screen stats: Figma's Compra/Venta/Rango 52 sem. vs spec's %-change/30-day min-max

- **Decision**: Follow the spec (authoritative). The Detail `StatsCard` shows exactly three rows
  driven by FR-007/FR-008: "Cambio 30d" (percentage change over the period), "Mínimo 30d", and
  "Máximo 30d" — reusing the Figma `StatsCard`'s visual styling (bg `color-bg-surface-elevated`,
  `radius-lg`, `spacing-md` padding, label/value row layout) but not its Compra/Venta/52-week
  field semantics.
- **Rationale**: Constitution governance states specs are authoritative when a Spec Kit artifact
  is silent or ambiguous vs. ad-hoc design; here there's a direct content conflict (52-week range
  is explicitly out of scope per FR-018: "MUST NOT show historical data beyond the last 30 days").
  Buy/sell (Compra/Venta) rates aren't in any FR and Frankfurter doesn't expose bid/ask spreads
  (it's a single midpoint rate), so they aren't buildable from the given API regardless.
- **Alternatives considered**: Building Compra/Venta as a cosmetic derived spread — rejected,
  would fabricate data not returned by the API and directly contradicts FR-018.

## 8. "Agregar a favoritos" button on Detail screen

- **Decision**: Out of scope for this feature. The `AppButton` component is still built as a
  standalone widget (used elsewhere — e.g. the retry action in error states), but the Detail
  screen does not render a favorites button and no favoriting logic is implemented.
- **Rationale**: No FR covers favoriting/watchlisting; FR-017 explicitly excludes
  alerts/notifications, and favoriting is adjacent, unrequested scope. `design-context.md` flag #2
  already calls this out as needing confirmation before building.
- **Alternatives considered**: Building a non-functional/disabled favorite button for visual
  parity — rejected as dead UI with no acceptance criteria behind it (violates "no half-finished
  implementations").

## 9. TrendCard badge contrast (Figma sample shows badge bg = badge text = same accent color)

- **Decision**: Badge background uses the accent color (`color-accent-positive` /
  `color-accent-negative`) at 16% opacity; badge text uses the full-opacity accent color. Padding,
  radius (`radius-pill`), and type style (11px SemiBold) stay exactly as specified.
- **Rationale**: `design-context.md` explicitly flags the literal token mapping as producing
  text unreadable against a same-color background ("likely needs on-accent white or a lighter
  tint bg"). A tinted background is the standard pattern for this exact semantic-badge shape and
  keeps both bg and text traceable to the same Figma accent token (just at two different alpha
  values), preserving Principle IV's traceability requirement.
- **Alternatives considered**: White text on solid accent bg (`color-text-on-accent`) — also
  viable and closer to the Button component's pattern, but the Figma badge shape (small pill,
  11px text) reads as a tinted-chip pattern elsewhere in the kit (Button uses solid, chips
  typically don't); tint keeps it visually distinct from the Button component.

## 10. Detail "Display" rate value rendered at 40px vs Foundations Display/Bold-32 token

- **Decision**: Add a one-off constant `fontSizeDisplayHero = 40.0` (Bold, Inter) in
  `design_tokens.dart`, clearly commented as the Detail-frame hero-rate one-off, distinct from
  `Display/Bold-32` (`fontSizeDisplay`). Both constants are kept, not merged.
- **Rationale**: `design-context.md` flag #6 notes this as an unresolved discrepancy between the
  Foundations type scale and the actual Detail frame. Renaming/resizing the shared `Display`
  token to 40px would silently change any other future use of `Display/Bold-32`; keeping both
  named constants keeps the Figma→Dart mapping traceable (Principle IV) without guessing at
  design intent.
- **Alternatives considered**: Redefine `Display/Bold-32` as 40px — rejected, changes a
  Foundations-level token based on a single frame's rendering, risking drift the next time
  Foundations is read from Figma.

## 11. Search filtering: client-side vs API-backed

- **Decision**: Client-side filtering of the already-fetched currency list (pure Dart function in
  `domain`, e.g. `filterCurrencies(List<Currency>, query)`), no network call per keystroke.
- **Rationale**: Frankfurter's `/v2/currencies` and `/v2/rates` endpoints return the full set in
  one call; US4's acceptance scenarios (instant filter, case-insensitive, partial match) are a
  pure in-memory operation. This is also the only interpretation consistent with SC-002
  ("narrow ... in under 5 seconds") without depending on network latency per keystroke.
- **Alternatives considered**: Debounced API refetch per keystroke — rejected as unnecessary
  network load; Frankfurter has no server-side name/code search endpoint anyway.

## 12. HTTP mocking strategy for Dio in tests

- **Decision**: `mocktail` to mock the `Dio` instance / a thin `ApiClient` interface directly
  (no separate HTTP-mocking package like `http_mock_adapter`).
- **Rationale**: Principle VI already mandates `mocktail` for repository data-source mocks.
  `ApiClient` is a small, centralized wrapper (Principle III) with a handful of methods
  (`getRates`, `getTimeSeries`, `getCurrencies`) — mocking the wrapper's methods directly is
  simpler than mocking Dio's adapter layer, and keeps tests decoupled from Dio internals.
- **Alternatives considered**: `http_mock_adapter` (mocks at the Dio transport layer) — more
  realistic but unnecessary complexity when `ApiClient`'s own interface is already the seam
  Principle III wants tests to mock against.

## 13. Cryptocurrency exclusion (FR-015): verified vs. assumed

- **Decision**: Treat crypto-exclusion as a pass-through of Frankfurter's `/v2/currencies`
  response (fiat-only, per Frankfurter's public API) rather than adding a defensive
  code-level filter/denylist in `CurrencyRepositoryImpl`.
- **Rationale**: Frankfurter is a fiat-rate service with no cryptocurrency support in its API
  surface. A hardcoded crypto-code denylist would be the only data-shape guard of this kind in
  the codebase — `data-model.md`'s other validations are format checks (e.g.
  `code.length == 3 && code == code.toUpperCase()`), not denylists against external API drift —
  and doesn't fit this POC's scope (plan.md Scale/Scope: "POC scope, not a multi-team
  codebase").
- **Accepted risk**: This is an **untested, conscious assumption**, not a verified guarantee.
  If Frankfurter ever adds crypto assets to `/v2/currencies`, nothing in this codebase would
  catch it — no test asserts the exclusion, and `CurrencyRepositoryImpl`'s test (T018)
  exercises the currency+rate join and the base-against-itself synthesis, not currency-content
  filtering. No task in `tasks.md` builds a runtime filter or a contract test against
  Frankfurter's live response for this.
- **Alternatives considered**: A defensive filter (hardcoded known-crypto-code denylist) in
  `CurrencyRepositoryImpl`, plus a unit test asserting exclusion even when the mocked data
  source returns a crypto code — rejected for now as speculative complexity for a case the
  API's current contract structurally rules out; revisit if Frankfurter's API scope ever
  changes.

## Summary of resolved unknowns (was "NEEDS CLARIFICATION")

| Item | Resolution |
|---|---|
| Either/Failure library | `fpdart` |
| Chart rendering | Custom `CustomPainter` sparkline, no chart package |
| Bloc test tooling | `bloc_test` (dev-only, flagged in Complexity Tracking) |
| Base currency persistence | Hive box `app_settings`, key `selected_base_currency` |
| Currency row icon | Text-initials avatar, no icon/flag package |
| UI copy locale | Spanish, mirrors Figma verbatim |
| Detail stats fields | FR-007/FR-008 (% change, 30-day min/max) — not Compra/Venta/52-week |
| Favorites button | Out of scope, not built into Detail screen |
| TrendCard badge contrast | Tinted (16%) accent bg + full-opacity accent text |
| Detail hero rate size | New `fontSizeDisplayHero = 40.0` constant, `Display/Bold-32` unchanged |
| Search | Client-side, pure-Dart filter function |
| Dio test mocking | `mocktail` against `ApiClient` interface directly |
| Crypto exclusion (FR-015) | Pass-through assumption, **untested** — accepted risk, not a code guard (§13) |
