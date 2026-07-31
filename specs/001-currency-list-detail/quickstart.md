# Quickstart: Validating Currency List & Detail

Prerequisites, run/test commands, and a manual scenario per user story — for verifying the
feature works end-to-end once implemented per `tasks.md`. This is a validation guide, not an
implementation walkthrough; see `data-model.md` and `contracts/` for the actual shapes.

## Prerequisites

- Flutter 3.44 (stable) / Dart 3.12 SDK installed (`flutter --version` to confirm).
- Network access to `api.frankfurter.dev` (no auth/API key needed — sanity-check with `curl`):
  ```bash
  curl -s "https://api.frankfurter.dev/v2/rates?base=USD&quotes=EUR,GBP,JPY,BRL,MXN"
  ```
- From repo root:
  ```bash
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs   # freezed / json_serializable / injectable / hive codegen
  ```

## Run

```bash
flutter run   # pick a connected device/simulator, or `-d chrome` for a quick manual check
```

## Automated checks (must pass before merge, per CI `44204a2` and Principle VI)

```bash
flutter analyze                                  # zero warnings, Principle VII
dart format --set-exit-if-changed .              # formatting gate, Principle VII
flutter test --coverage                          # unit + widget tests
# domain-layer coverage must be >= 80% (Principle VI) — check lcov.info for lib/features/*/domain
```

## Manual validation per user story

### US1 — View currency rates against a base currency (P1)

1. Start a stopwatch and launch the app with network on. **Expect**: loading indicator, then a
   list showing at least USD, EUR, GBP, JPY, BRL, MXN (plus every other currency Frankfurter
   returns), each with code, name, and rate against USD. **Pass/Fail (SC-001)**: stop the
   stopwatch when the list finishes rendering — pass if ≤3s under normal network conditions,
   fail if not.
2. Turn off network, force-quit, relaunch. **Expect**: error message + retry button (no
   indefinite spinner, no crash). Turn network back on, tap retry. **Expect**: list loads.

### US2 — 30-day trend and statistics (P2)

1. From the loaded list, tap any currency row. **Expect**: navigation to a detail view; a brief
   loading indicator, then a 30-day trend line, a percentage-change figure, and min/max values —
   all on one screen, no further navigation needed (SC-003).
2. With network off, tap a different currency row from the list (list still loaded). **Expect**:
   detail view shows its own error + retry state (list underneath is unaffected).

### US3 — Change the base currency (P3)

1. From the loaded list (base = USD), start a stopwatch and switch the base to EUR. **Expect**:
   brief loading indicator, then every row's rate recalculated against EUR — no USD-based rates
   left on screen mid-transition. **Pass/Fail (SC-005)**: stop the stopwatch when every row
   shows a EUR-based rate — pass if ≤3s under normal network conditions, fail if not.
2. Force-quit and relaunch the app. **Expect**: base currency is still EUR (FR-002 persistence —
   confirms the Hive write in `contracts/repository-interfaces.md`'s `BaseCurrencyStore.save`
   actually took effect, not just in-memory state).
3. With network off, attempt to switch base again. **Expect**: error + retry shown for the
   base-change request specifically.

### US4 — Search the currency list (P4)

1. Start a stopwatch and type `"JPY"` into the search field. **Expect**: list narrows to
   Japanese Yen only. **Pass/Fail (SC-002)**: stop the stopwatch when the filtered list
   settles — pass if ≤5s, fail if not.
2. Clear the field, type `"yen"` (lowercase, partial name). **Expect**: same result — confirms
   case-insensitive partial match (FR-013).
3. Type `"zzz"` (no match). **Expect**: clear "no results" state, not an empty blank list
   (FR-014).
4. Clear the field. **Expect**: full list reappears.

### Edge cases to spot-check

- Base currency itself appears in its own list at rate `1.0` (e.g. base = USD → a USD row showing
  rate 1).
- Rapidly switching base currency twice in a row does not leave a list mixing rates from both
  bases (in-flight request from the first switch must not overwrite the second's result).
- If the previously loaded list is on screen and a background refresh fails, the old data stays
  visible marked stale (FR-019) — not replaced by the full error+retry state (that state is only
  for "no data yet").

## Where to look when something fails

- Wrong/missing rates → check the request against `contracts/frankfurter-api.md` (params,
  especially `base`/`quotes`/`from` formatting).
- Crash on rendering a color/spacing/radius → check `lib/core/design/design_tokens.dart` against
  `design-context.md` for a missing or misnamed token.
- A component doesn't match Figma → check `contracts/widget-components.md` for the intended
  states/styling and compare against the live Figma file
  (`https://www.figma.com/design/qLfN6nCLnmNPF0rMEJPM7X`).
