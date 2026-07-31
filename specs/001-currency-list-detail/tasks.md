---

description: "Task list for Currency List & Detail"
---

# Tasks: Currency List & Detail

**Input**: Design documents from `/specs/001-currency-list-detail/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md, `.specify/memory/constitution.md`

**Tests**: Included — Constitution Principle V ("Testing Discipline", NON-NEGOTIABLE) mandates a unit test for every domain entity/usecase, a `mocktail`-mocked test for every repository implementation, and coverage of every Cubit's state transitions; the user has additionally requested a widget test per page covering the loading state, the error state with retry, and the search filter.

**Organization**: Tasks are grouped by user story (spec.md P1–P4) to enable independent implementation and testing of each story. `CurrencyListCubit`, `CurrencyListPage`, and `currency_list_header.dart` are created in US1 and then extended (not recreated) by US3 and US4, since Constitution Principle II requires exactly one Cubit per screen — later-story tasks touching these files are sequential, not parallel, with earlier ones.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Maps task to a user story (US1–US4) for traceability
- File paths below are relative to the repository root (`lib/`, `test/`)

## Path Conventions

Single Flutter project, feature-first (Constitution Principle I): `lib/core/`, `lib/features/<name>/{data,domain,presentation}/`, mirrored under `test/`. Paths match `plan.md`'s Project Structure exactly.

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization — dependencies and directory skeleton

- [X] T001 Add runtime deps (`flutter_bloc`, `dio`, `fpdart`, `get_it`, `injectable`, `go_router`, `freezed_annotation`, `json_annotation`, `hive`, `hive_flutter`) and dev deps (`mocktail`, `bloc_test`, `build_runner`, `injectable_generator`, `freezed`, `json_serializable`, `hive_generator`) to `pubspec.yaml`, then run `flutter pub get`
- [X] T002 [P] Create the feature-first directory skeleton per `plan.md` Project Structure: `lib/core/{design,network,settings,di,router,widgets}/`, `lib/features/currency_list/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{cubit,pages,widgets}}/`, `lib/features/currency_detail/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{cubit,pages,widgets}}/`, and matching subtrees under `test/`
- [X] T003 [P] Remove the default Flutter counter-app scaffold body from `lib/main.dart` and `test/widget_test.dart` (kept as empty entry points — real bootstrap lands in T036)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Cross-cutting infrastructure every user story needs — networking, persistence, DI, design tokens, and the Figma-1:1 widgets shared by 2+ stories (Constitution Principle IV)

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T004 [P] Create the `Failure` sealed union (`network`/`server`/`parsing`/`noData`, each with a Spanish `message` getter) in `lib/core/network/failure.dart` per `contracts/repository-interfaces.md`
- [X] T005 [P] Create `lib/core/design/design_tokens.dart` mapping every Foundations token from `design-context.md` 1:1 (colors, `Inter` type scale incl. the one-off `fontSizeDisplayHero = 40.0` per research.md §10, spacing, radius, shadows) as named Dart constants
- [X] T006 Create the injectable `@module` Dio provider in `lib/core/network/dio_module.dart` — single `Dio` instance, 15s connect + 15s receive timeouts, base URL `https://api.frankfurter.dev/v2/` (depends on T001)
- [X] T007 Create `ApiClient` in `lib/core/network/api_client.dart` wrapping the shared `Dio`: `getCurrencies()`, `getRates({required String base})`, `getTimeSeries({required String base, required String quotes, required String from})`, each returning `Either<Failure, T>` per `contracts/frankfurter-api.md` (depends on T004, T006)
- [X] T008 [P] `ApiClient` test in `test/core/network/api_client_test.dart` — `mocktail`-mocked `Dio`, asserts 2xx responses map to `Right`, non-2xx/timeout/malformed-JSON map to the correct `Failure` variant (depends on T007)
- [X] T009 [P] Create the `BaseCurrencyStore` domain interface (`read()`, `save(String code)`) in `lib/core/settings/base_currency_store.dart` per `contracts/repository-interfaces.md`
- [X] T010 Implement `HiveBaseCurrencyStore` in `lib/core/settings/hive_base_currency_store.dart` — Hive box `app_settings`, key `selected_base_currency`, defaults to `"USD"` when unset (depends on T009)
- [X] T011 [P] `HiveBaseCurrencyStore` test in `test/core/settings/hive_base_currency_store_test.dart` — `save`/`read` round-trip against an in-memory Hive box, default-to-`"USD"` when the box is empty (depends on T010)
- [X] T012 Create the `get_it` + `injectable` DI bootstrap (`@InjectableInit` entry point, `configureDependencies()`) in `lib/core/di/injection.dart` (depends on T001)
- [X] T013 [P] `AppButton` widget (Primary/Secondary variants, Default/Pressed/Disabled states) in `lib/core/widgets/app_button.dart` per `contracts/widget-components.md` (depends on T005)
- [X] T014 [P] `BottomNavBar` widget (4 destinations, only `Markets` wired later) in `lib/core/widgets/bottom_nav_bar.dart` per `contracts/widget-components.md` (depends on T005)
- [X] T015 [P] `TrendSparkline` `CustomPainter` widget (normalized line through points, positive/negative stroke color) in `lib/core/widgets/trend_sparkline.dart` per research.md §2 (depends on T005)

**Checkpoint**: Foundation ready — user story implementation can now begin

---

## Phase 3: User Story 1 - View currency rates against a base currency (Priority: P1) 🎯 MVP

**Goal**: Opening the app shows a list of major world currencies, each with code, name, and today's rate against the default base currency (USD), with loading and error+retry states (FR-001–FR-003, FR-009–FR-011, FR-019).

**Independent Test**: Launch the app with a working network connection. The list of currencies appears with each showing a code, name, and rate against USD, without needing search, base switching, or the detail view.

### Tests for User Story 1 ⚠️

> Write these tests FIRST, ensure they FAIL before implementation

- [X] T016 [P] [US1] `Currency` entity test in `test/features/currency_list/domain/entities/currency_test.dart` — valid 3-letter uppercase code accepted, invalid shapes rejected
- [X] T017 [P] [US1] `GetCurrencyRates` usecase test in `test/features/currency_list/domain/usecases/get_currency_rates_test.dart` — `mocktail`-mocked `CurrencyRepository`; joins currencies+rates into rows, propagates `Failure` from either call
- [X] T018 [P] [US1] `CurrencyRepositoryImpl` test in `test/features/currency_list/data/repositories/currency_repository_impl_test.dart` — `mocktail`-mocked `CurrencyRemoteDataSource`; asserts the synthesized `rate: 1.0` self-entry for `baseCode == quoteCode` and `Failure` pass-through
- [X] T019 [US1] `CurrencyListCubit` test (`bloc_test`) in `test/features/currency_list/presentation/cubit/currency_list_cubit_test.dart` — covers `initial → loading → loaded` (success), `initial → loading → error` (failure, no prior data), and `loaded → loading → staleData` (refresh fails with prior data kept, FR-019)
- [X] T020 [US1] `CurrencyListPage` widget test in `test/features/currency_list/presentation/pages/currency_list_page_test.dart` — loading state renders a progress indicator (no list/error), error state renders the failure message + a retry `AppButton` that re-invokes the load when tapped

### Implementation for User Story 1

- [X] T021 [P] [US1] `Currency` entity (`code`, `name`, code-format validation) in `lib/features/currency_list/domain/entities/currency.dart`
- [X] T022 [P] [US1] `ExchangeRate` entity (`baseCode`, `quoteCode`, `rate`, `asOf`) in `lib/features/currency_list/domain/entities/exchange_rate.dart`
- [X] T023 [US1] `CurrencyRepository` abstract interface (`getAvailableCurrencies()`, `getLatestRates({required String baseCode})`) in `lib/features/currency_list/domain/repositories/currency_repository.dart` (depends on T021, T022)
- [X] T024 [P] [US1] `CurrencyDto` (freezed + json_serializable) in `lib/features/currency_list/data/models/currency_dto.dart` (depends on T021)
- [X] T025 [P] [US1] `RatesResponseDto` (freezed + json_serializable) in `lib/features/currency_list/data/models/rates_response_dto.dart` (depends on T022)
- [X] T026 [US1] `CurrencyRemoteDataSource` in `lib/features/currency_list/data/datasources/currency_remote_data_source.dart` — calls `ApiClient.getCurrencies()` / `getRates(base: ...)` (depends on T007, T024, T025)
- [X] T027 [US1] `CurrencyRepositoryImpl` in `lib/features/currency_list/data/repositories/currency_repository_impl.dart` — maps DTOs to domain entities, synthesizes the base-against-itself `ExchangeRate(rate: 1.0)` (depends on T023, T026)
- [X] T028 [US1] `GetCurrencyRates` usecase in `lib/features/currency_list/domain/usecases/get_currency_rates.dart` — combines `getAvailableCurrencies` + `getLatestRates`, joined by `code`, into `CurrencyRowData` (depends on T023)
- [X] T029 [US1] `CurrencyListState` freezed union (`initial`, `loading`, `loaded`, `error`, `staleData`) in `lib/features/currency_list/presentation/cubit/currency_list_state.dart` per data-model.md
- [X] T030 [US1] `CurrencyListCubit` in `lib/features/currency_list/presentation/cubit/currency_list_cubit.dart` — on init reads `BaseCurrencyStore.read()` then loads rates; failure with no prior data → `error`, failure with prior data → `staleData` (depends on T028, T009, T029)
- [X] T031 [P] [US1] `CurrencyRow` widget in `lib/core/widgets/currency_row.dart` per `contracts/widget-components.md` (depends on T005)
- [X] T032 [P] [US1] `TrendCard` widget in `lib/core/widgets/trend_card.dart` — Positive/Negative variant derived from `deltaPercent.sign`, tinted badge per research.md §9 (depends on T005, T015)
- [X] T033 [US1] Page-specific composition `currency_list_header.dart` (title + subtitle) and `trend_row.dart` (2× `TrendCard`) in `lib/features/currency_list/presentation/widgets/` (depends on T032)
- [X] T034 [US1] `CurrencyListPage` in `lib/features/currency_list/presentation/pages/currency_list_page.dart` — `BlocBuilder<CurrencyListCubit, CurrencyListState>` rendering loading/loaded (`CurrencyRow` list)/error+retry(`AppButton`)/staleData, composes header, trend row, `BottomNavBar` (depends on T030, T031, T033, T013, T014)
- [X] T035 [US1] `go_router` setup in `lib/core/router/app_router.dart` with the `/list` route → `CurrencyListPage` (depends on T034)
- [X] T036 [US1] App bootstrap in `lib/main.dart` — `Hive.initFlutter()`, register the `app_settings` box, `configureDependencies()`, `runApp(MaterialApp.router(routerConfig: appRouter))` (depends on T012, T035, T010)

**Checkpoint**: User Story 1 is fully functional and independently testable (MVP)

---

## Phase 4: User Story 2 - View a currency's 30-day trend and statistics (Priority: P2)

**Goal**: Tapping a currency opens a detail view with a 30-day historical trend, percentage change, and min/max, with loading and error+retry states (FR-005–FR-011, FR-019).

**Independent Test**: From a loaded currency list, tap any currency. A detail view opens showing a 30-day historical trend, the percentage change over that period, and the minimum/maximum rate reached — independently of search or base-currency switching.

### Tests for User Story 2 ⚠️

> Write these tests FIRST, ensure they FAIL before implementation

- [ ] T037 [P] [US2] `HistoricalRateSeries` entity test in `test/features/currency_detail/domain/entities/historical_rate_series_test.dart` — `percentChange`/`minRate`/`maxRate`/`isPositiveTrend` correctness, including a single-point series and non-contiguous dates (non-trading-day gaps, Edge Case)
- [ ] T038 [P] [US2] `GetHistoricalRateSeries` usecase test in `test/features/currency_detail/domain/usecases/get_historical_rate_series_test.dart` — `mocktail`-mocked `HistoryRepository`; empty `points` list surfaces `Failure.noData`, never reaches `percentChange`/`minRate`/`maxRate` unguarded
- [ ] T039 [P] [US2] `HistoryRepositoryImpl` test in `test/features/currency_detail/data/repositories/history_repository_impl_test.dart` — `mocktail`-mocked `HistoryRemoteDataSource`; maps the date-keyed response into ascending `RatePoint`s
- [ ] T040 [US2] `CurrencyDetailCubit` test (`bloc_test`) in `test/features/currency_detail/presentation/cubit/currency_detail_cubit_test.dart` — covers `loading → loaded`, `loading → error` (no prior data), `loaded → loading → staleData` (refresh fails with prior data kept, FR-019)
- [ ] T041 [US2] `CurrencyDetailPage` widget test in `test/features/currency_detail/presentation/pages/currency_detail_page_test.dart` — loading state renders a progress indicator, error state renders the failure message + a retry `AppButton` that re-invokes the load when tapped

### Implementation for User Story 2

- [ ] T042 [P] [US2] `RatePoint` entity (`date`, `rate`) in `lib/features/currency_detail/domain/entities/rate_point.dart`
- [ ] T043 [P] [US2] `HistoricalRateSeries` entity (`baseCode`, `quoteCode`, `points`, derived getters `percentChange`/`minRate`/`maxRate`/`isPositiveTrend`) in `lib/features/currency_detail/domain/entities/historical_rate_series.dart` (depends on T042)
- [ ] T044 [US2] `HistoryRepository` abstract interface (`getThirtyDayHistory({required baseCode, required quoteCode, DateTime? asOfDate})`) in `lib/features/currency_detail/domain/repositories/history_repository.dart` (depends on T043)
- [ ] T045 [P] [US2] `TimeSeriesResponseDto` (freezed + json_serializable) in `lib/features/currency_detail/data/models/time_series_response_dto.dart`
- [ ] T046 [US2] `HistoryRemoteDataSource` in `lib/features/currency_detail/data/datasources/history_remote_data_source.dart` — calls `ApiClient.getTimeSeries(base:, quotes:, from:)` with `from = (asOfDate ?? now) - 30 days` formatted `YYYY-MM-DD` (depends on T007, T045)
- [ ] T047 [US2] `HistoryRepositoryImpl` in `lib/features/currency_detail/data/repositories/history_repository_impl.dart` — maps the date-keyed DTO into ascending `RatePoint`s (depends on T044, T046)
- [ ] T048 [US2] `GetHistoricalRateSeries` usecase in `lib/features/currency_detail/domain/usecases/get_historical_rate_series.dart` — empty series → `Failure.noData` guard (depends on T044)
- [ ] T049 [US2] `CurrencyDetailState` freezed union (`loading`, `loaded`, `error`, `staleData`) in `lib/features/currency_detail/presentation/cubit/currency_detail_state.dart`
- [ ] T050 [US2] `CurrencyDetailCubit` in `lib/features/currency_detail/presentation/cubit/currency_detail_cubit.dart` — loads on init with the base+quote passed at navigation time, `refresh()` re-invokes the same params for retry (FR-011) (depends on T048, T049)
- [ ] T051 [P] [US2] `StatsCard` widget in `lib/features/currency_detail/presentation/widgets/stats_card.dart` — 3 rows: "Cambio 30d" / "Mínimo 30d" / "Máximo 30d" per research.md §7 (depends on T005)
- [ ] T052 [US2] `CurrencyDetailPage` in `lib/features/currency_detail/presentation/pages/currency_detail_page.dart` — `BlocBuilder<CurrencyDetailCubit, CurrencyDetailState>`, hero rate at `fontSizeDisplayHero`, 180px `TrendSparkline` chart, `StatsCard`, `AppButton` retry on error, `BottomNavBar` (depends on T050, T051, T015, T013, T014)
- [ ] T053 [US2] Extend `lib/core/router/app_router.dart` with `/detail/:baseCode/:quoteCode` → `CurrencyDetailPage`; wire `CurrencyRow.onTap` in `CurrencyListPage` to navigate (depends on T035, T052, T031)

**Checkpoint**: User Stories 1 AND 2 both work independently

---

## Phase 5: User Story 3 - Change the base currency (Priority: P3)

**Goal**: The user can select a different base currency; the list reloads and redisplays every rate against the new base, with loading and error+retry states, and the choice persists across restarts (FR-002, FR-004, FR-009–FR-011, FR-019).

**Independent Test**: From a loaded currency list defaulted to USD, select a different base currency (e.g. EUR). All list rates update to reflect the new base, without needing search or the detail view.

### Tests for User Story 3 ⚠️

> Write these tests FIRST, ensure they FAIL before implementation. These extend the existing test files from T019/T020 with new `group`s — do not remove US1's cases.

- [ ] T054 [US3] Extend `test/features/currency_list/presentation/cubit/currency_list_cubit_test.dart` — `changeBaseCurrency` transitions: `loaded → loading → loaded` (new base, `BaseCurrencyStore.save` called), `loaded → loading → error`/`staleData` on failure (depends on T019)
- [ ] T055 [US3] Extend `test/features/currency_list/presentation/pages/currency_list_page_test.dart` — selecting a new base currency shows a loading state then rows reflecting the new base, with no stale-base rows left on screen mid-transition (depends on T020)

### Implementation for User Story 3

- [ ] T056 [US3] Add `changeBaseCurrency(String code)` to `CurrencyListCubit` in `lib/features/currency_list/presentation/cubit/currency_list_cubit.dart` — `loading` immediately (no mixed-base rows, Edge Case), `BaseCurrencyStore.save(code)`, re-invoke `GetCurrencyRates`, failure → `error`/`staleData` per FR-019 (depends on T030)
- [ ] T057 [US3] Add a base-currency selector affordance to `lib/features/currency_list/presentation/widgets/currency_list_header.dart` — tapping the base code opens a lightweight picker (e.g. modal sheet) listing the already-loaded currencies, selecting one calls `cubit.changeBaseCurrency(code)`; no dedicated Figma component exists for this control (design-context.md is silent on it), so keep it visually minimal and built only from `design_tokens.dart` values (depends on T033, T056)

**Checkpoint**: User Stories 1, 2, AND 3 all work independently

---

## Phase 6: User Story 4 - Search the currency list (Priority: P4)

**Goal**: A search field filters the currency list by code or name, case-insensitively, with a "no results" state (FR-012–FR-014).

**Independent Test**: From a loaded currency list, type a currency code (e.g. "JPY") or name (e.g. "yen") into the search field. The list filters to matching currencies only, independently of base-currency switching or the detail view.

### Tests for User Story 4 ⚠️

> Write these tests FIRST, ensure they FAIL before implementation. T059/T060 extend the existing test files from T019/T020 with new `group`s.

- [ ] T058 [P] [US4] `FilterCurrencies` usecase test in `test/features/currency_list/domain/usecases/filter_currencies_test.dart` — case-insensitive match, partial code match, partial name match, empty query returns the full list, no-match returns an empty list
- [ ] T059 [US4] Extend `test/features/currency_list/presentation/cubit/currency_list_cubit_test.dart` — `search(query)` transitions: `loaded` rows narrow to matches, empty-match yields a "no results" indication in state, clearing the query restores the full list (depends on T019, T054)
- [ ] T060 [US4] Extend `test/features/currency_list/presentation/pages/currency_list_page_test.dart` — typing a matching query narrows the rendered rows, typing a non-matching query renders a "no results" message (not a blank list), clearing the field restores the full list (depends on T020, T055)

### Implementation for User Story 4

- [ ] T061 [P] [US4] `FilterCurrencies` usecase (pure function: case-insensitive, partial code/name match) in `lib/features/currency_list/domain/usecases/filter_currencies.dart` (depends on T021)
- [ ] T062 [P] [US4] `AppSearchBar` widget in `lib/core/widgets/app_search_bar.dart` per `contracts/widget-components.md` (depends on T005)
- [ ] T063 [US4] Add `search(String query)` to `CurrencyListCubit` in `lib/features/currency_list/presentation/cubit/currency_list_cubit.dart` — re-runs `FilterCurrencies` against the already-fetched list (no network call per keystroke, research.md §11), updates `searchQuery`/`rows` in `loaded` state (depends on T030, T056, T061)
- [ ] T064 [US4] Wire `AppSearchBar` into `lib/features/currency_list/presentation/widgets/currency_list_header.dart`, `onChanged` calling `cubit.search(query)`; render a "no results" state in `CurrencyListPage` when `rows` is empty and `searchQuery` is non-empty (depends on T034, T057, T062, T063)

**Checkpoint**: All four user stories are independently functional

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final quality gates across all stories (Constitution Principles VI–VII)

- [ ] T065 [P] Run `flutter analyze` (zero warnings) and `dart format --set-exit-if-changed .` across all files added/changed above
- [ ] T066 [P] Run `flutter test --coverage` and confirm domain-layer coverage (`lib/features/*/domain/`) is ≥80% per Principle VI, inspecting `coverage/lcov.info`
- [ ] T067 Run `flutter pub run build_runner build --delete-conflicting-outputs` for a final regeneration of all `freezed`/`json_serializable`/`injectable`/`hive` codegen once every annotated class above exists
- [ ] T068 Execute the manual validation scenarios in `quickstart.md` end to end (US1–US4 plus the three Edge Cases spot-checks)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately
- **Foundational (Phase 2)**: Depends on Setup — BLOCKS all user stories
- **User Story 1 (Phase 3)**: Depends on Foundational only
- **User Story 2 (Phase 4)**: Depends on Foundational; T053 also depends on US1's router (T035) and `CurrencyRow` (T031)
- **User Story 3 (Phase 5)**: Depends on Foundational; every task depends on US1's `CurrencyListCubit` (T030) and header (T033) already existing, since it extends rather than recreates them
- **User Story 4 (Phase 6)**: Depends on Foundational; every task depends on US1's `CurrencyListCubit`/`CurrencyListPage`/header, and — since each story is its own branch (`001-us4-search` branches from `main` after `001-us3-base-currency` merges) — on US3's cubit/header edits (T056, T057) landing on `main` first to avoid re-diffing the same files
- **Polish (Phase 7)**: Depends on all desired user stories being complete

### User Story Dependencies

- **US1 (P1)**: Independent — only needs Foundational
- **US2 (P2)**: Independent business logic (own entities/repo/usecase/cubit); its final task (T053) integrates with US1's router and `CurrencyRow`
- **US3 (P3)**: Extends US1's `CurrencyListCubit`/header rather than introducing new files — not independently *buildable* before US1 exists, but independently *testable* once it does (per its Independent Test criterion)
- **US4 (P4)**: Same relationship to US1 as US3; also has a soft ordering dependency on US3 if both extend the same files sequentially

### Within Each User Story

- Tests written and failing before implementation
- Entities → repository interface → DTOs → data source → repository impl → usecase → Cubit state → Cubit → widgets → page → routing/bootstrap

### Parallel Opportunities

- All `[P]` Setup tasks (T002, T003) run together after T001
- All `[P]` Foundational tasks run together once their individual dependency (T001/T005 etc.) is met — e.g. T004, T005, T009, T013, T014, T015 in one wave
- Within US1: T016–T018 (tests) in parallel; T021–T022 (entities) in parallel; T024–T025 (DTOs) in parallel; T031–T032 (widgets) in parallel
- Within US2: T037–T039 (tests) in parallel; T042–T043 (entities, T043 after T042) — T042 and T045 in parallel
- US4's T058, T061, T062 are parallel to each other and to any US3 task not touching the same file
- US1 and US2 can be staffed to different developers in parallel on their own branches (`001-us1-currency-list`, `001-us2-currency-detail`) once Foundational is done, since neither extends the other's files. US3 (`001-us3-base-currency`) and US4 (`001-us4-search`) both extend US1's `CurrencyListCubit`/header, so per the Version Control Workflow each MUST branch from `main` only after the prior story in priority order has merged — they are not parallelizable with each other the way US1/US2 are

---

## Parallel Example: User Story 1

```bash
# Tests together:
Task: "Currency entity test in test/features/currency_list/domain/entities/currency_test.dart"
Task: "GetCurrencyRates usecase test in test/features/currency_list/domain/usecases/get_currency_rates_test.dart"
Task: "CurrencyRepositoryImpl test in test/features/currency_list/data/repositories/currency_repository_impl_test.dart"

# Entities together:
Task: "Currency entity in lib/features/currency_list/domain/entities/currency.dart"
Task: "ExchangeRate entity in lib/features/currency_list/domain/entities/exchange_rate.dart"

# Widgets together:
Task: "CurrencyRow widget in lib/core/widgets/currency_row.dart"
Task: "TrendCard widget in lib/core/widgets/trend_card.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (blocks everything else)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: run T016–T020's tests, then the US1 section of `quickstart.md`
5. Demo — a working, launchable rate list against USD

### Incremental Delivery

1. Setup + Foundational → foundation ready
2. Add US1 → validate independently → MVP demo
3. Add US2 → validate independently (tap-through to detail) → demo
4. Add US3 → validate independently (base switch + persistence across restart) → demo
5. Add US4 → validate independently (search narrow/no-results/clear) → demo
6. Phase 7 Polish → merge-ready

---

## Notes

- `[P]` tasks touch different files with no unmet dependency
- `[Story]` label maps every Phase 3+ task to its user story for traceability
- Every usecase, every Cubit's state transitions, and every repository implementation (via `mocktail`) has an explicit unit test task; `CurrencyListPage` and `CurrencyDetailPage` each have a widget test covering loading and error-with-retry, and `CurrencyListPage`'s widget test is extended in US4 to cover the search filter (Constitution Principle VI, NON-NEGOTIABLE)
- Re-run `flutter pub run build_runner build --delete-conflicting-outputs` after adding any `freezed`/`json_serializable`/`injectable`/`hive` annotated class, not only at T067 — T067 is the final confirmation pass, not the only invocation
- Commit after each task or logical group, formatted per Principle VII
- Stop at any checkpoint to validate a story independently before moving on
