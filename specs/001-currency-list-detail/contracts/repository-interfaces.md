# Contract: Domain Repository Interfaces

These are the boundaries between `domain` and `data` (Principle I) — the interfaces `presentation`
Cubits actually depend on (via `domain/usecases`), never the `data` implementations directly.
Every method returns `Future<Either<Failure, T>>` per Principle III; nothing here throws.

## `CurrencyRepository` (`features/currency_list/domain/repositories/currency_repository.dart`)

```dart
abstract class CurrencyRepository {
  /// All available fiat currencies (code + name). Backed by GET /v2/currencies.
  Future<Either<Failure, List<Currency>>> getAvailableCurrencies();

  /// Today's rate of every available currency against [baseCode].
  /// Synthesizes a 1.0 self-rate entry for baseCode itself (see contracts/frankfurter-api.md).
  Future<Either<Failure, List<ExchangeRate>>> getLatestRates({required String baseCode});
}
```

**Consumed by**: `GetCurrencyRates` usecase (`currency_list/domain/usecases`), which combines
both calls into the `List<CurrencyRowData>` the List Cubit needs (name + code from
`getAvailableCurrencies`, rate from `getLatestRates`, joined by `code`).

**Failure cases the Cubit must handle**: `Failure.network` (no connection), `Failure.server`
(non-2xx), `Failure.parsing` (unexpected shape) — all funnel into `CurrencyListState.error` (no
prior data) or `.staleData` (prior data exists), per FR-010/FR-019.

## `BaseCurrencyStore` (`core/settings/base_currency_store.dart`)

```dart
abstract class BaseCurrencyStore {
  /// Currently selected base currency code, "USD" if never set.
  String read();

  /// Persists [code] as the new base currency selection (Hive write, FR-002).
  Future<void> save(String code);
}
```

**Consumed by**: `CurrencyListCubit` on init (`read()`) and whenever the user picks a new base
(`save(code)` then re-invoke `GetCurrencyRates`). Synchronous `read()` is intentional — Hive reads
from an already-open box are synchronous, and the app-launch sequence opens the box before
`runApp` (see `quickstart.md`), so no loading state is needed just to read the persisted base.

## `HistoryRepository` (`features/currency_detail/domain/repositories/history_repository.dart`)

```dart
abstract class HistoryRepository {
  /// 30-day daily series for [quoteCode] against [baseCode].
  /// [asOfDate] is injectable (defaults to DateTime.now()) so tests can pin "today".
  Future<Either<Failure, HistoricalRateSeries>> getThirtyDayHistory({
    required String baseCode,
    required String quoteCode,
    DateTime? asOfDate,
  });
}
```

**Consumed by**: `GetHistoricalRateSeries` usecase (`currency_detail/domain/usecases`), which also
owns the empty-series → `Failure.noData` guard documented in `data-model.md`.

**Failure cases the Cubit must handle**: same `Failure` union as `CurrencyRepository`, plus
`Failure.noData` (empty series) — funnels into `CurrencyDetailState.error`/`.staleData` per
FR-010/FR-019.

## `Failure` (`core/network/failure.dart`)

```dart
sealed class Failure {
  const factory Failure.network() = NetworkFailure;      // no connectivity / timeout
  const factory Failure.server(int statusCode) = ServerFailure;  // non-2xx response
  const factory Failure.parsing() = ParsingFailure;       // unexpected JSON shape
  const factory Failure.noData() = NoDataFailure;         // empty result set, not a transport error

  /// Human-readable, Spanish, ready to show directly in an error state (FR-010).
  String get message;
}
```

Every screen's error/staleData UI renders `failure.message` directly — no per-widget switch
statements duplicating copy (keeps FR-010's "clear, human-readable error message" consistent
across List and Detail).
