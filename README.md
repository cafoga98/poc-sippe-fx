<div align="center">

# 📈 sip.pe FX Monitor

**A Flutter POC for browsing live currency exchange rates and 30-day historical trends.**

[![Flutter CI](https://github.com/cafoga98/poc-sippe-fx/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/cafoga98/poc-sippe-fx/actions/workflows/flutter-ci.yml)
![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android-lightgrey)
![Tests](https://img.shields.io/badge/tests-57%20passing-brightgreen)
![Domain Coverage](https://img.shields.io/badge/domain%20coverage-82.6%25-brightgreen)

</div>

---

## Overview

sip.pe FX Monitor is a mobile-only Flutter application that lets a user browse every major
world currency's exchange rate against a base currency of their choosing, switch that base on the
fly, search the list, and drill into any currency for a 30-day historical trend with derived
statistics. It's built as a proof of concept to validate an architecture and delivery process —
Clean Architecture, Bloc state management, spec-driven development via
[Spec Kit](https://github.com/github/spec-kit) — end to end against a real public API, not a mock.

Rate data comes from the [Frankfurter](https://frankfurter.dev) API — free, no auth, no API key.

## Features

| # | Story | What it does |
|---|-------|---------------|
| **US1** | View currency rates | Opening the app lists every currency Frankfurter tracks, each with code, name, and today's rate against the base currency (defaults to USD). Loading and error+retry states throughout. |
| **US2** | 30-day trend & stats | Tapping a row opens a detail view with a 30-day sparkline, percentage change, and the period's min/max rate — computed client-side from the time-series endpoint. |
| **US3** | Change the base currency | Tap the base-currency label to open a picker of every currency already on screen; selecting one re-fetches and redisplays all rates against it. The choice persists across app restarts (Hive). |
| **US4** | Search | A search field filters the list by code or name, case-insensitively, entirely client-side (no network call per keystroke) — with a proper "no results" state instead of a blank screen. |

Every screen degrades gracefully: a failed fetch with no prior data shows an error message and a
retry action; a failed *refresh* with prior data on screen keeps that data visible, marked stale,
rather than blanking the UI (FR-019).

## Tech Stack

| Concern | Choice |
|---|---|
| Language / SDK | Dart 3.12 · Flutter 3.44 (stable) |
| State management | `flutter_bloc` (Cubit — one per screen) |
| Networking | `dio`, wrapped by a single centralized `ApiClient` |
| Functional error handling | `fpdart` (`Either<Failure, T>` — no uncaught exceptions cross into the UI) |
| Dependency injection | `get_it` + `injectable` |
| Navigation | `go_router` |
| Models / codegen | `freezed` + `json_serializable` |
| Local persistence | `hive` (the selected base currency is the only thing that needs to survive an app close) |
| Testing | `flutter_test`, `mocktail`, `bloc_test` |

## Architecture

Clean Architecture, feature-first, one Cubit per screen:

```
lib/
├── main.dart                    # Hive init → DI init → go_router → runApp
├── core/
│   ├── design/                  # design_tokens.dart — every Figma value as a named Dart constant
│   ├── network/                 # ApiClient (Dio), Failure union, DI module
│   ├── settings/                # BaseCurrencyStore (Hive-backed)
│   ├── di/                      # get_it + injectable bootstrap
│   ├── router/                  # go_router routes
│   └── widgets/                 # Figma-1:1 shared components (AppButton, CurrencyRow, TrendCard, …)
└── features/
    ├── currency_list/
    │   ├── data/                # DTOs, remote data source, repository impl
    │   ├── domain/               # Currency/ExchangeRate entities, usecases, repository interface
    │   └── presentation/        # Cubit, state, page, page-specific widgets
    └── currency_detail/
        └── (same data/domain/presentation split)
```

- **Domain is pure Dart** — no Flutter or Dio imports, so entities and usecases are unit-tested
  without a widget environment.
- **One network chokepoint** — every Frankfurter call goes through `ApiClient`; every response or
  transport error maps to a typed `Failure` (`network` / `server` / `parsing` / `noData`), never a
  raw exception.
- **Design-token traceability** — every color, spacing, radius, and type value in widget code
  traces back to a named constant in `design_tokens.dart`, itself mirrored from the Figma file.

The full rationale for these choices lives in the project's
[constitution](.specify/memory/constitution.md), and the feature's own spec/plan/task breakdown —
produced with Spec Kit — is under [`specs/001-currency-list-detail/`](specs/001-currency-list-detail/).

## Getting Started

### Prerequisites

- Flutter 3.44 (stable channel) / Dart 3.12 — `flutter --version` to confirm
- An iOS Simulator or Android emulator (this app targets **mobile only** — no desktop/web build
  support)
- Network access to `api.frankfurter.dev` (no auth/API key required)

### Install & run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs   # freezed / json_serializable / injectable codegen
flutter run                                                        # pick a connected device/simulator
```

### Testing

```bash
flutter analyze                        # zero warnings gate
dart format --set-exit-if-changed .    # formatting gate
flutter test --coverage                # 57 unit + widget tests
```

Domain-layer coverage (`lib/features/*/domain/`) is checked against an 80% floor both in
[CI](.github/workflows/flutter-ci.yml) and manually via `coverage/lcov.info` — currently **82.6%**.

## Manual validation

A full click-through script per user story (with expected timings against the spec's success
criteria) lives in
[`specs/001-currency-list-detail/quickstart.md`](specs/001-currency-list-detail/quickstart.md).

## Project status

All four user stories, plus the cross-cutting foundation (networking, persistence, DI, design
system) and a polish/coverage gate, are implemented, tested, and merged to `main`. See
[`tasks.md`](specs/001-currency-list-detail/tasks.md) for the complete, checked-off task
breakdown, and the closed PRs/issues in this repo for the full delivery history.

## Not in scope

Per the feature spec (`spec.md`, FR-015–FR-018): no cryptocurrencies, no currency conversion
calculator for arbitrary amounts, no price alerts/notifications, and no history beyond the last 30
days. These were explicitly excluded to keep this POC focused.
