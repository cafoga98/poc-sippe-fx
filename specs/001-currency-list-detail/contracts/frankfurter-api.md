# Contract: Frankfurter v2 API (external dependency)

This app is a consumer, not a provider, of this contract — documented here because it's the
external interface the whole feature is built against, and because `core/network/api_client.dart`
must match these shapes exactly. No auth, no API key, base URL `https://api.frankfurter.dev/v2/`.

> **Verified against the live API** (2026-07-31, via `curl`) after implementation revealed the
> originally documented shapes here were wrong — the real API returns flat JSON **arrays** for
> every endpoint below, not the nested objects/maps first assumed. `ApiClient` and the DTOs were
> fixed to match; this doc now reflects what was actually observed.

## GET /v2/currencies

Used by: `currency_list` data source, to build the full `Currency` list (code + name), FR-001.

**Request**: no params.

**Response 200**:
```json
[
  {"iso_code": "USD", "iso_numeric": "840", "name": "US Dollar", "symbol": "$", "start_date": "...", "end_date": "..."},
  {"iso_code": "EUR", "iso_numeric": "978", "name": "Euro", "symbol": "€", "start_date": "...", "end_date": "..."}
]
```
`List<Map<String, dynamic>>` — one object per currency. Only `iso_code`/`name` are used by
`CurrencyDto`; the rest (`iso_numeric`, `symbol`, `start_date`, `end_date`) are ignored.

## GET /v2/rates?base={base}

Used by: `currency_list` data source, for "today's rate for every currency against the active
base" (FR-001, FR-003, FR-004). `base` is the current `BaseCurrencySelection.code`.

**Request params**: `base` (required, ISO code, e.g. `USD`).

**Response 200**:
```json
[
  {"date": "2026-07-31", "base": "USD", "quote": "EUR", "rate": 0.86983},
  {"date": "2026-07-31", "base": "USD", "quote": "USD", "rate": 1.0}
]
```
`List<Map<String, dynamic>>` — one entry per quote currency (`RateEntryDto`), maps directly to
`ExchangeRate`. The base-against-itself entry (`quote == base`, `rate: 1.0`) **is already included**
by the live API — `CurrencyRepositoryImpl` still synthesizes it defensively if a response ever
omits it, satisfying the Edge Case "base currency itself... MUST still appear, showing a rate of 1"
without depending on that being guaranteed forever.

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
[
  {"date": "2026-07-01", "base": "USD", "quote": "PEN", "rate": 3.4126},
  {"date": "2026-07-02", "base": "USD", "quote": "PEN", "rate": 3.4098}
]
```
Same flat shape as `/v2/rates?base=...` — `List<Map<String, dynamic>>`, one entry per date for the
single requested quote (`RateEntryDto`, a separate copy of the same shape in `currency_detail`'s
own data layer per plan.md's feature-independence boundary). Mapped to `List<RatePoint>` sorted by
date ascending. Missing dates (non-trading days) are simply absent entries — the app does not
request or expect a fill value (Edge Case).

**Empty array response** (e.g. invalid/unsupported quote for the range): mapped to `Failure.noData`
by the usecase layer (see `data-model.md` HistoricalRateSeries validation) — never passed to
`percentChange`/`minRate`/`maxRate` unguarded.

## Not used by this feature

- `GET /v2/rate/{base}/{quote}` (single-pair current rate) — superseded by `/v2/rates?base=...`
  which the List screen already needs for every currency at once; not called separately.
- Any conversion endpoint — **does not exist**. `amount * rate` is always computed client-side,
  and per FR-016 this app doesn't even expose a conversion calculator UI.
