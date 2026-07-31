<!--
Sync Impact Report
- Version change: (none — template) → 1.0.0
- Modified principles: N/A (initial ratification)
- Added sections:
  - Core Principles: I. Clean Architecture & Feature-First Organization,
    II. Bloc/Cubit-Only State Management, III. Centralized, Typed Networking,
    IV. Figma-Traceable Design System, V. Local Persistence via Hive,
    VI. Testing Discipline, VII. Code Conventions & Quality Gates
  - Allowed Dependencies
  - Version Control Workflow
  - Governance
- Removed sections: none (placeholders replaced)
- Templates requiring updates:
  - ✅ .specify/templates/plan-template.md (generic Constitution Check gate, no
    principle names hardcoded — compatible as-is)
  - ✅ .specify/templates/spec-template.md (no constitution-specific references)
  - ✅ .specify/templates/tasks-template.md (generic phase structure — task
    categories for domain testing, repository mocks, and design-token
    traceability should be included by /speckit-tasks when generating
    feature-specific tasks, per Principles VI and IV)
  - ✅ .claude/skills/speckit-*/SKILL.md (agent-agnostic, no stale references)
- Follow-up TODOs: none
-->

# sip.pe FX Monitor Constitution

## Core Principles

### I. Clean Architecture & Feature-First Organization

Every feature MUST live under `lib/features/<name>/` split into `data`,
`domain`, and `presentation` layers. The `domain` layer MUST be pure Dart with
no Flutter SDK import, so it can be unit-tested without a widget environment.
Layers MUST communicate only through interfaces (repository pattern) — the
`presentation` layer MUST NOT reach into `data` directly, and `data` MUST NOT
depend on `presentation`.

**Rationale**: Isolating business logic from Flutter and from I/O concerns
keeps the domain layer fast to test, makes the data source swappable (mock →
Frankfurter API), and prevents the "screen that does everything" anti-pattern
common in quick POCs.

### II. Bloc/Cubit-Only State Management

All presentation logic MUST be implemented with Bloc/Cubit. Widgets MUST NOT
contain business logic (calculations, branching on domain state, API/usecase
calls) — they only dispatch events/calls and render state. Each screen or
distinct logical flow MUST have exactly one Cubit/Bloc owning its state.

**Rationale**: A single, consistent state-management pattern makes the
codebase predictable across features and keeps widgets declarative and
testable in isolation from business rules.

### III. Centralized, Typed Networking

All HTTP communication MUST go through Dio via a single, centralized
`ApiClient` in `core/network` — features MUST NOT instantiate their own HTTP
clients. Every network exception MUST be mapped to a `Failure` and surfaced as
`Either<Failure, T>` (dartz or fpdart), never as an uncaught exception crossing
into `presentation`. Connect and receive timeouts MUST both be 15 seconds. The
Frankfurter API (`https://api.frankfurter.dev/v2/`) requires no auth/API key
and MUST be treated as the sole exchange-rate data source.

**Rationale**: A single network chokepoint gives one place to enforce
timeouts, error mapping, and (future) auth, and typed `Failure`/`Either`
results force every call site to handle the error path instead of relying on
try/catch sprinkled through the UI.

### IV. Figma-Traceable Design System

The Figma file "sip.pe FX Monitor — UI Kit"
(`https://www.figma.com/design/qLfN6nCLnmNPF0rMEJPM7X`), pages
🎨 Foundations, 🧩 Components, 📱 Screens, is the design source of truth. Every
color, spacing, radius, and typography value used in widget code MUST trace
back to a Foundations variable/style — no hardcoded hex values or magic
numbers in widget code. These values MUST be mirrored in a centralized
`design_tokens.dart` (or an equivalent `ThemeExtension`) so the mapping from
Figma variable name to Dart constant is explicit and auditable. The Figma
components `CurrencyRow`, `TrendCard`, `SearchBar`, `BottomNavBar`, and the
primary `AppButton` MUST exist as their own standalone Flutter widgets
matching the Figma component boundaries 1:1 — they MUST NOT be inlined into
page/screen widgets.

**Rationale**: Tracing every visual value back to Figma prevents design drift
between the UI Kit and the shipped app, and 1:1 component boundaries keep
Figma updates translatable into targeted code diffs instead of page-wide
rewrites.

### V. Local Persistence via Hive

Any data that must survive an app close — e.g. the currency watchlist — MUST
be persisted with Hive.

**Rationale**: Standardizing on one local-storage mechanism avoids mixing
SharedPreferences, files, and databases for the same class of problem in a
small POC.

### VI. Testing Discipline

Every domain entity and every usecase MUST have a unit test. Every repository
MUST have a test that mocks its data sources with `mocktail`. Domain-layer
coverage MUST be at least 80%.

**Rationale**: The domain layer is where business rules live and is the
cheapest layer to test (pure Dart, no widget pump); enforcing coverage there
catches regressions before they reach the UI.

### VII. Code Conventions & Quality Gates

File names MUST be `snake_case`; class names MUST be `PascalCase`. A widget
MUST be broken into private subwidgets once it exceeds ~150 lines. The
`flutter_lints` linter MUST report zero warnings before merge. Every commit
MUST be formatted with `dart format` before being created.

**Rationale**: Consistent naming and size limits keep files reviewable and
prevent "god widgets"; a clean lint/format baseline keeps diffs focused on
substance rather than style bikeshedding.

## Allowed Dependencies

- Dependency injection: `get_it` + `injectable`.
- Navigation: `go_router`.
- Code generation: `freezed` + `json_serializable` for models.

Introducing a dependency outside this list (or outside Principles I–VII, e.g.
a different Bloc/Cubit alternative, a different HTTP client, a different local
storage engine) requires an explicit constitution amendment — it MUST NOT be
added silently inside a feature branch.

## Version Control Workflow

- No commits are made directly to `main` except the initial project bootstrap
  (scaffold, `.gitignore`, CI config).
- Every feature phase (per user story) MUST be implemented on its own branch,
  named after the feature number and story (e.g. `001-us1-currency-list`).
- Every pull request MUST pass CI (analyze, tests, coverage) before merge.
- Merges to `main` are always a manual, human decision — never automatic.

## Governance

This constitution supersedes all other project practices, templates, and
ad-hoc conventions for the sip.pe FX Monitor POC. Where a Spec Kit template
(plan, spec, tasks, checklist) is silent or ambiguous, the rules in this
document govern.

**Amendment procedure**: Amendments are proposed by editing this file (via
`/speckit-constitution` or direct PR), must state the version bump and
rationale in a Sync Impact Report comment at the top of the file, and require
human review/approval before merge to `main` — the same as any other change
under Version Control Workflow above.

**Versioning policy**: This document follows semantic versioning:
- MAJOR: backward-incompatible principle removal or redefinition.
- MINOR: a new principle or materially expanded guidance is added.
- PATCH: clarifications, wording, or typo fixes with no rule change.

**Compliance review**: Every pull request MUST be checked against the
principles above (architecture layering, state management, networking,
design-token traceability, persistence, testing, and code conventions) before
merge. Any deviation MUST be justified in the PR description or, for
plan-level tradeoffs, in the plan's Complexity Tracking table. Unjustified
complexity or a MUST-rule violation is grounds for blocking the merge.

**Version**: 1.0.0 | **Ratified**: 2026-07-31 | **Last Amended**: 2026-07-31
