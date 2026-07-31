# Data Model: Currency List & Detail

Source: `spec.md` Key Entities section, resolved against Frankfurter v2's actual response shapes
and the decisions in `research.md`. Entities below are **domain** types (pure Dart, no Flutter/
Dio imports) per constitution Principle I; each has a corresponding DTO in `data/models/`
(`freezed` + `json_serializable`) that a repository maps into the domain type — the mapping step
is where DTO→domain validation happens, so domain constructors can assume valid input.

## Currency

Identified by ISO code; represents one fiat currency the app can display or use as a base.

| Field | Type | Notes |
|---|---|---|
| `code` | `String` | ISO 4217, e.g. `"USD"`. Always 3 uppercase letters — validated at DTO→domain mapping (from `/v2/currencies` keys). |
| `name` | `String` | Full display name, e.g. `"US Dollar"` (from `/v2/currencies` values). |

**Validation**: `code.length == 3 && code == code.toUpperCase()`; constructed only from
`/v2/currencies` entries, so no crypto-exclusion filter is needed at this layer — Frankfurter's
`/v2/currencies` is fiat-only, satisfying FR-015 as a pass-through — an untested, accepted risk
documented in research.md §13.

**Source of truth**: `GET /v2/currencies` → `Map<String, String>` (code → name).

## ExchangeRate

The rate of one currency against the active base currency on the most recent available date —
the unit shown in each `CurrencyRow` (FR-003).

| Field | Type | Notes |
|---|---|---|
| `baseCode` | `String` | The base currency active when this rate was fetched. |
| `quoteCode` | `String` | The currency this rate is *for* (matches a `Currency.code`). |
| `rate` | `double` | Units of `quoteCode` per 1 `baseCode`. `1.0` when `quoteCode == baseCode` (Edge Case: base appears in its own list). |
| `asOf` | `DateTime` | Date Frankfurter published the rate for (`date` field in the response — may be a prior business day on weekends/holidays, per spec Assumptions). |

**Derived (presentation-only, not stored)**: `CurrencyRow`'s "delta" badge is **not** derivable
from a single `ExchangeRate` — Frankfurter's `/v2/rates` latest endpoint returns only today's
rate, no prior-day comparison. Scoping note: the spec's FRs (FR-001–FR-004) only require
"today's rate" in the list, not a day-over-day delta; the Figma `CurrencyRow` delta slot is
populated by the *detail* screen's data when navigated from there, but on the List screen itself
there is no FR requiring a delta per row. **Decision**: `CurrencyRow` renders its delta slot only
when a delta is supplied (nullable `String? deltaLabel`, `bool? isPositive`); the List screen
passes `null` (slot hidden/collapsed) since no FR provides list-level deltas, avoiding
fabricated data.

**Source of truth**: `GET /v2/rates?base={base}` → `{ base, date, rates: { CODE: rate, ... } }`.

## HistoricalRateSeries

The 30-day daily series for one currency pair, and the derived statistics FR-006–FR-008 require.

| Field | Type | Notes |
|---|---|---|
| `baseCode` | `String` | Base currency active at navigation time (FR-006). |
| `quoteCode` | `String` | The tapped currency. |
| `points` | `List<RatePoint>` | Chronologically ordered, one entry per date Frankfurter actually returned (non-trading days simply absent — Edge Case: computed from available rates only, no synthetic fill). |

**`RatePoint`**: `{ date: DateTime, rate: double }`.

**Derived getters (domain-layer, pure functions — unit-tested directly, no widget needed)**:

- `percentChange` → `(points.last.rate - points.first.rate) / points.first.rate * 100` (FR-007).
  Requires `points.isNotEmpty`; if Frankfurter returns zero points for the range (fully empty
  series), the usecase surfaces this as an error state, not a `NaN`/crash (Edge Case).
- `minRate` → `points.map((p) => p.rate).reduce(min)` (FR-008).
- `maxRate` → `points.map((p) => p.rate).reduce(max)` (FR-008).
- `isPositiveTrend` → `percentChange >= 0` — drives `TrendCard`/Detail accent color
  (`color-accent-positive` vs `color-accent-negative`).

**Validation**: usecase (`GetHistoricalRateSeries`) treats an empty `points` list as a domain
error (`Failure.noData`), never lets `percentChange`/`minRate`/`maxRate` execute against an empty
list — satisfies the Edge Case "without crashing or showing broken values."

**Source of truth**: `GET /v2/rates?base={base}&quotes={quote}&from={today-30d}` →
`{ base, start_date, end_date, rates: { "YYYY-MM-DD": { CODE: rate }, ... } }`. The 30-day window
is computed client-side as `DateTime.now().subtract(Duration(days: 30))` for the `from` param;
`quotes` is a single code (the tapped currency) per the "single pair" time-series call documented
in the API args.

## BaseCurrencySelection

The single, app-wide chosen base currency (FR-002, FR-004).

| Field | Type | Notes |
|---|---|---|
| `code` | `String` | Defaults to `"USD"` on first launch (no persisted value yet). |

**Persistence**: Hive box `app_settings`, key `selected_base_currency` (research.md §4) — not a
`freezed` entity requiring a DTO; it's a single primitive value read/written directly by
`HiveBaseCurrencyStore` (implements domain interface `BaseCurrencyStore`).

**State transitions**:

```
[no stored value] --first launch--> code = "USD" (in-memory default, not yet written to Hive)
code = X --user selects Y--> code = Y, persisted to Hive immediately, CurrencyListCubit
                              re-fetches rates for base=Y (FR-004)
[app restart] --Hive has stored value V--> code = V (restored, FR-002)
[app restart] --Hive empty--> code = "USD" (default, FR-002)
```

## Cubit State Shapes (presentation, for reference — not persisted)

Modeled as `freezed` sealed unions so every state transition in the spec (FR-009, FR-010,
FR-019) is exhaustively handled by `BlocBuilder`/`when()`, and to satisfy Principle II (no
implicit/boolean-flag state in widgets).

**`CurrencyListState`**:
- `initial()`
- `loading()` — FR-009, first load or base-currency change with no prior data
- `loaded({required List<CurrencyRowData> rows, required String baseCode, required String searchQuery})` — FR-001, FR-004; `rows` already reflects `searchQuery` filtering (research.md §11)
- `error({required Failure failure})` — FR-010, only reachable when no prior `loaded` data exists
- `staleData({required List<CurrencyRowData> rows, required String baseCode, required String searchQuery, required Failure lastFailure})` — FR-019: refresh failed but prior data is kept, marked stale

**`CurrencyDetailState`**:
- `loading()` — FR-009
- `loaded({required HistoricalRateSeries series})` — FR-006–FR-008
- `error({required Failure failure})` — FR-010
- `staleData({required HistoricalRateSeries series, required Failure lastFailure})` — FR-019

Both `error` and `staleData` variants carry the same `Failure` type from `core/network/failure.dart`
so the retry action (FR-011) is uniform across both screens: `onRetry: () => cubit.refresh()`
re-invokes the same usecase call that failed, keyed off the last-requested params (base code, or
base+quote pair) rather than any UI-guessed state.
