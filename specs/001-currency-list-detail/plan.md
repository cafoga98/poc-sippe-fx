# Implementation Plan: Currency List & Detail

**Branches**: One per user story, per constitution Version Control Workflow — `001-us1-currency-list`, `001-us2-currency-detail`, `001-us3-base-currency`, `001-us4-search`, each branched from `main` after the prior story's branch has merged (US3/US4 extend files US1 creates, so they cannot branch from `main` until US1 — and, for US4, US3 — has landed) | **Date**: 2026-07-31 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/001-currency-list-detail/spec.md`

**Note**: This template is filled in by the `/speckit-plan` command; its definition describes the execution workflow.

## Summary

A Flutter mobile app screen pair — currency list and currency detail — backed by the
Frankfurter v2 public API (no auth). The list shows every non-crypto currency's rate against a
persisted base currency (USD by default), with client-side search; tapping a row opens a detail
view with a 30-day historical trend, percentage change, and min/max, computed client-side from
Frankfurter's time-series endpoint (no conversion endpoint exists). Every visual value traces to
the Figma "sip.pe FX Monitor — UI Kit" file via a centralized `design_tokens.dart`, and
`CurrencyRow`, `TrendCard`, `SearchBar`, `BottomNavBar`, and `AppButton` are built as standalone,
Figma-1:1 widgets per constitution Principle IV. Architecture follows Clean
Architecture/feature-first layering (Principle I), Bloc/Cubit-only presentation state
(Principle II), a centralized Dio `ApiClient` with typed `Failure`/`Either` results
(Principle III), and Hive for the one piece of data that must survive an app close — the
selected base currency (Principle V).

## Technical Context

**Language/Version**: Dart 3.12 (SDK constraint `^3.12.2`) / Flutter 3.44 (stable channel)

**Primary Dependencies**: `flutter_bloc` (Bloc/Cubit, Principle II), `dio` (networking,
Principle III), `fpdart` (`Either<Failure, T>`, Principle III — see research.md §1), `get_it` +
`injectable` (DI, Allowed Dependencies), `go_router` (navigation, Allowed Dependencies),
`freezed` + `json_serializable` (models/state, Allowed Dependencies), `hive` + `hive_flutter`
(persisted base currency, Principle V); dev-only: `mocktail` (Principle VI), `bloc_test`
(research.md §3, flagged in Complexity Tracking), `build_runner` (codegen for freezed/hive/
injectable)

**Storage**: Hive — single box `app_settings`, one key `selected_base_currency` (see
research.md §4). No other local persistence; rate/history data is fetched on demand per FR-019's
"refreshed on demand, not background/push" assumption and kept only in Cubit memory for the
stale-data-on-refresh-failure behavior.

**Testing**: `flutter_test` (widget tests) + `mocktail` (data-source/repository mocks) +
`bloc_test` (Cubit state-sequence tests); `flutter test --coverage` gate, ≥80% domain-layer
coverage per Principle VI

**Target Platform**: Mobile app (iOS + Android) via Flutter; single responsive layout, no
tablet/desktop-specific treatment required by the spec

**Project Type**: Mobile app (single Flutter project, feature-first `lib/features/`)

**Performance Goals**: List renders within 3s of app open under normal network (SC-001); base
currency switch redraws all rows within 3s (SC-005); search filter is synchronous/in-memory —
effectively instant, well under SC-002's 5s budget

**Constraints**: Frankfurter API (`https://api.frankfurter.dev/v2/`) is the sole data source, no
auth/API key, 15s connect + 15s receive Dio timeouts (Principle III); no conversion endpoint —
all display values computed client-side from fetched rates; crypto currencies excluded from the
list (FR-015) — Frankfurter's `/v2/currencies` only returns fiat, so this is a pass-through, not
a filter to implement; no conversion calculator, no alerts/notifications, no >30-day history
(FR-016–FR-018)

**Scale/Scope**: 2 screens (List, Detail), 4 user stories (P1–P4), 5 standalone Figma-mirrored
widgets (`CurrencyRow`, `TrendCard`, `AppSearchBar`, `BottomNavBar`, `AppButton`), 2 features
(`currency_list`, `currency_detail`) plus shared `core/` infrastructure — POC scope, not a
multi-team codebase

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Check | Status |
|---|---|---|
| I. Clean Architecture & Feature-First | `currency_list` and `currency_detail` each get `data`/`domain`/`presentation`; domain is pure Dart (entities, repository interfaces, usecases); presentation depends on domain only, data implements domain interfaces | PASS |
| II. Bloc/Cubit-Only | `CurrencyListCubit` and `CurrencyDetailCubit`, one per screen; widgets only call cubit methods and render `BlocBuilder` states; no business logic (rate math, filtering) in widgets — lives in domain usecases | PASS |
| III. Centralized, Typed Networking | Single `ApiClient` in `core/network` wrapping `Dio`, used by both features' remote data sources; all Frankfurter calls mapped to `Failure`/`Either`; 15s/15s timeouts configured once on the shared `Dio` instance | PASS |
| IV. Figma-Traceable Design System | `design_tokens.dart` mirrors every token in `design-context.md` 1:1 by Figma name; `CurrencyRow`, `TrendCard`, `AppSearchBar` (Figma `SearchBar`), `BottomNavBar`, `AppButton` built as standalone widgets in `core/widgets/`, composed (not inlined) into page widgets | PASS |
| V. Local Persistence via Hive | Selected base currency (the only data required to survive an app close, FR-002) persisted via Hive `app_settings` box | PASS |
| VI. Testing Discipline | Every entity/usecase gets a unit test; `CurrencyRepositoryImpl`/`HistoryRepositoryImpl` tested with `mocktail`-mocked data sources; ≥80% domain coverage enforced by existing CI gate (`44204a2`) | PASS |
| VII. Code Conventions & Quality Gates | `snake_case` files, `PascalCase` classes, widgets split past ~150 lines, zero `flutter_lints` warnings, `dart format` before commit | PASS |

**Result**: No unjustified violations. One item — `bloc_test` — sits outside the constitution's
literal "Allowed Dependencies" list; captured below in Complexity Tracking rather than silently
added, per the constitution's own escalation rule.

*Post-Phase-1 re-check: see bottom of this document.*

## Project Structure

### Documentation (this feature)

```text
specs/001-currency-list-detail/
├── plan.md              # This file (/speckit-plan command output)
├── research.md          # Phase 0 output (/speckit-plan command)
├── data-model.md        # Phase 1 output (/speckit-plan command)
├── quickstart.md        # Phase 1 output (/speckit-plan command)
├── contracts/           # Phase 1 output (/speckit-plan command)
├── design-context.md    # Figma extraction (pre-existing input to this plan)
├── checklists/
│   └── requirements.md
└── tasks.md              # Phase 2 output (/speckit-tasks command - NOT created by /speckit-plan)
```

### Source Code (repository root)

```text
lib/
├── main.dart                          # app bootstrap: Hive.init, injection.init, MaterialApp.router
├── core/
│   ├── design/
│   │   └── design_tokens.dart         # every Figma token as a Dart const (colors, type, spacing, radius, shadow)
│   ├── network/
│   │   ├── api_client.dart            # Dio wrapper: getRates, getTimeSeries, getCurrencies
│   │   ├── failure.dart               # sealed Failure types (network, server, parsing, cache)
│   │   └── dio_module.dart            # injectable @module: Dio instance + 15s/15s timeouts
│   ├── settings/
│   │   ├── base_currency_store.dart   # domain interface: watch()/read()/save(code)
│   │   └── hive_base_currency_store.dart  # Hive-backed impl, box `app_settings`
│   ├── di/
│   │   └── injection.dart             # get_it + injectable getIt, injection.config.dart (generated)
│   ├── router/
│   │   └── app_router.dart            # go_router: /list, /detail/:baseCode/:quoteCode
│   └── widgets/                       # the 5 Figma-1:1 standalone components
│       ├── currency_row.dart
│       ├── trend_card.dart
│       ├── trend_sparkline.dart       # CustomPainter line chart (research.md §2), used by TrendCard + Detail
│       ├── app_search_bar.dart
│       ├── bottom_nav_bar.dart
│       └── app_button.dart
├── features/
│   ├── currency_list/
│   │   ├── data/
│   │   │   ├── datasources/currency_remote_data_source.dart   # GET /v2/rates?base=...
│   │   │   ├── models/currency_dto.dart, rates_response_dto.dart  # freezed + json_serializable
│   │   │   └── repositories/currency_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/currency.dart, exchange_rate.dart
│   │   │   ├── repositories/currency_repository.dart          # abstract interface
│   │   │   └── usecases/get_currency_rates.dart, filter_currencies.dart
│   │   └── presentation/
│   │       ├── cubit/currency_list_cubit.dart, currency_list_state.dart  # freezed union: loading/loaded/error/staleError
│   │       ├── pages/currency_list_page.dart
│   │       └── widgets/currency_list_header.dart, trend_row.dart   # page-specific composition only
│   └── currency_detail/
│       ├── data/
│       │   ├── datasources/history_remote_data_source.dart    # GET /v2/rates?from=...&quotes=...
│       │   ├── models/time_series_response_dto.dart
│       │   └── repositories/history_repository_impl.dart
│       ├── domain/
│       │   ├── entities/historical_rate_series.dart, rate_point.dart
│       │   ├── repositories/history_repository.dart
│       │   └── usecases/get_historical_rate_series.dart        # computes % change + min/max
│       └── presentation/
│           ├── cubit/currency_detail_cubit.dart, currency_detail_state.dart
│           ├── pages/currency_detail_page.dart
│           └── widgets/stats_card.dart
└── ...

test/
├── core/
│   ├── network/api_client_test.dart
│   └── settings/hive_base_currency_store_test.dart
├── features/
│   ├── currency_list/
│   │   ├── domain/usecases/get_currency_rates_test.dart, filter_currencies_test.dart
│   │   ├── data/repositories/currency_repository_impl_test.dart
│   │   └── presentation/cubit/currency_list_cubit_test.dart
│   └── currency_detail/
│       ├── domain/usecases/get_historical_rate_series_test.dart
│       ├── data/repositories/history_repository_impl_test.dart
│       └── presentation/cubit/currency_detail_cubit_test.dart
└── widget_test.dart                    # existing scaffold smoke test
```

**Structure Decision**: Single Flutter project (mobile app), feature-first under `lib/features/`
per Principle I. `Currency` (entity) and its remote fetch live in `currency_list`; `currency_detail`
imports `Currency` from `currency_list/domain` rather than duplicating it — both features already
sit in one app, and duplicating the entity risks the two definitions drifting (e.g. one gaining a
field the other doesn't get). Base-currency persistence is cross-cutting infrastructure (used by
`currency_list` to fetch and by `currency_detail` implicitly via the base passed at navigation
time), so it lives in `core/settings/`, not inside either feature. The 5 Figma-mirrored components
live in `core/widgets/` (not one feature) since `CurrencyRow` is list-only but `AppButton` and
`BottomNavBar` are used by both screens.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| `bloc_test` dev dependency (not in the constitution's literal "Allowed Dependencies" list) | Principle II mandates Bloc/Cubit for all presentation state and Principle VI mandates unit tests for every usecase/repository; testing multi-step Cubit emission sequences (loading → loaded, loading → error, loaded → stale-error-kept per FR-019) needs proper stream-sequence assertions | Hand-written `expectLater(cubit.stream, emitsInOrder([...]))` per test — technically possible, but verbose and easy to get subtly wrong across ~15+ Cubit test cases; `bloc_test` is the `flutter_bloc` team's own zero-risk companion package, not a competing pattern |

---

## Post-Phase-1 Constitution Re-check

Re-evaluated after `research.md`, `data-model.md`, `contracts/`, and `quickstart.md` were
written — design decisions didn't introduce anything the initial gate missed:

| Principle | Post-design check | Status |
|---|---|---|
| I. Clean Architecture | `data-model.md` entities are pure Dart with no Flutter/Dio types; `contracts/repository-interfaces.md` interfaces live in `domain`, implementations in `data`; `Currency` shared from `currency_list` into `currency_detail` is a cross-feature domain import, not a layering violation | PASS |
| II. Bloc/Cubit-Only | `data-model.md`'s Cubit state shapes are exhaustive `freezed` unions; all rate/percent/min-max math lives in domain usecases (`GetCurrencyRates`, `GetHistoricalRateSeries`), not in Cubits or widgets | PASS |
| III. Centralized, Typed Networking | `contracts/frankfurter-api.md` confirms exactly one base URL, one `ApiClient`, and every response maps into the single `Failure` union in `contracts/repository-interfaces.md` — no per-feature HTTP client introduced | PASS |
| IV. Figma-Traceable Design System | `contracts/widget-components.md` ties every styling value on all 5 components (+ the supporting `TrendSparkline`) back to a named token; research.md §6, §9, §10 resolve the 3 places design-context.md flagged ambiguity, without inventing new hex/spacing/radius values | PASS |
| V. Local Persistence via Hive | `data-model.md`'s `BaseCurrencySelection` and `contracts/repository-interfaces.md`'s `BaseCurrencyStore` confirm Hive is the only persistence mechanism introduced, scoped to the one value that needs it | PASS |
| VI. Testing Discipline | `quickstart.md`'s automated-checks section wires `flutter test --coverage` + the ≥80% domain gate; `test/` tree in Project Structure has a unit test file per usecase/repository/cubit named in `data-model.md`/`contracts/` | PASS |
| VII. Code Conventions | All new file names in Project Structure are `snake_case`; no file is sketched over ~150 lines of responsibility (widgets, cubits, usecases are each single-purpose) | PASS |

**Result**: No new violations surfaced during design. Complexity Tracking's single entry
(`bloc_test`) stands unchanged — it's a testing-only dependency, doesn't affect runtime
architecture, and directly serves Principle VI's coverage mandate.
