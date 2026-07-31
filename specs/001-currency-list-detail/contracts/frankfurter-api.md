# Contract: Frankfurter v2 API (external dependency)

This app is a consumer, not a provider, of this contract — documented here because it's the
external interface the whole feature is built against, and because `core/network/api_client.dart`
must match these shapes exactly. No auth, no API key, base URL `https://api.frankfurter.dev/v2/`.

## GET /v2/currencies

Used by: `currency_list` data source, to build the full `Currency` list (code + name), FR-001.

**Request**: no params.

**Response 200**:
```json
{ "USD": "US Dollar", "EUR": "Euro", "JPY": "Japanese Yen", "...": "..." }
```
`Map<String, String>` — key is ISO code, value is display name. Maps 1:1 to `List<Currency>`.

## GET /v2/rates?base={base}

Used by: `currency_list` data source, for "today's rate for every currency against the active
base" (FR-001, FR-003, FR-004). `base` is the current `BaseCurrencySelection.code`.

**Request params**: `base` (required, ISO code, e.g. `USD`).

**Response 200**:
```json
{ "amount": 1.0, "base": "USD", "date": "2026-07-30", "rates": { "EUR": 0.92, "GBP": 0.79, "...": "..." } }
```
- `rates` excludes `base` itself (Frankfurter never returns the base against itself) — the app
  must synthesize `ExchangeRate(baseCode: base, quoteCode: base, rate: 1.0, asOf: date)` to satisfy
  the Edge Case "base currency itself... MUST still appear, showing a rate of 1."
- `date` may be a prior business day (weekend/holiday) — mapped directly to `ExchangeRate.asOf`.

**Response 4xx/5xx or network failure**: mapped to `Failure.network` / `Failure.server` by
`ApiClient`; never surfaced as a raw exception past `data/`.

## GET /v2/rates?from={30-days-ago}&base={base}&quotes={quote}

Used by: `currency_detail` data source, for the 30-day historical series of one pair (FR-006).
`base` = the base active when the user navigated to the detail screen; `quote` = the tapped
currency's code; `{30-days-ago}` computed client-side as `today - 30 days`, formatted `YYYY-MM-DD`.

**Request params**: `from` (required, `YYYY-MM-DD`), `base` (required), `quotes` (required, single
code — comma-separated for multiple, but this app always requests exactly one).

**Response 200**:
```json
{
  "amount": 1.0, "base": "USD", "start_date": "2026-07-01", "end_date": "2026-07-30",
  "rates": { "2026-07-01": { "PEN": 3.71 }, "2026-07-02": { "PEN": 3.70 }, "...": "..." }
}
```
`rates` is a date-keyed map, each value a single-entry map (since `quotes` requested one code) —
mapped to `List<RatePoint>` sorted by date ascending. Missing dates (non-trading days) are simply
absent keys — the app does not request or expect a fill value (Edge Case).

**Empty `rates` (e.g. invalid/unsupported quote for the range)**: mapped to `Failure.noData` by
the usecase layer (see `data-model.md` HistoricalRateSeries validation) — never passed to
`percentChange`/`minRate`/`maxRate` unguarded.

## Not used by this feature

- `GET /v2/rate/{base}/{quote}` (single-pair current rate) — superseded by `/v2/rates?base=...`
  which the List screen already needs for every currency at once; not called separately.
- Any conversion endpoint — **does not exist**. `amount * rate` is always computed client-side,
  and per FR-016 this app doesn't even expose a conversion calculator UI.
