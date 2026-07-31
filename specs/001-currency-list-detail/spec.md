# Feature Specification: Currency List & Detail

**Feature Branch**: `001-currency-list-detail`

**Created**: 2026-07-31

**Status**: Draft

**Input**: User description: "As a user, I want to see a list of major world currencies with their current exchange rate against a base currency, and when I tap one, see its detail with a historical trend, percentage change, and min/max over the last 30 days."

## Clarifications

### Session 2026-07-31

- Q: Should the app remember the user's last-selected base currency the next time they open the app, or should it always reset to USD on launch? → A: Persist the selected base currency across app restarts
- Q: When the app already has previously-loaded rate data and a later refresh fails (e.g. lost network), should it keep showing the last-known data or always switch to the error+retry state? → A: Keep showing the last-known data (marked as possibly stale); only show the error+retry state when there is no data yet to fall back on

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View currency rates against a base currency (Priority: P1)

As a user, I want to open the app and immediately see a list of major world
currencies with their current exchange rate against a base currency (USD by
default), so I can quickly check how currencies compare today.

**Why this priority**: This is the core value of the app — an "FX Monitor" is
useless without a live list of rates. Every other capability (detail, search,
base switching) is a refinement of this list.

**Independent Test**: Launch the app with a working network connection. The
list of currencies appears with each showing a code, name, and rate against
USD, without needing search, base switching, or the detail view.

**Acceptance Scenarios**:

1. **Given** the app is opened for the first time, **When** the currency list
   loads successfully, **Then** the user sees a list of major world currencies
   (including at least USD, EUR, GBP, JPY, BRL, MXN, and any other currencies
   available from the data source), each showing its code, name, and current
   rate against USD, the default base currency.
2. **Given** the currency list is loading, **When** the user is waiting for
   data, **Then** a loading indicator is shown instead of an empty or broken
   list.
3. **Given** the currency list fails to load (e.g. no network), **When** the
   error occurs, **Then** the user sees a clear error message and a retry
   action, and tapping retry re-attempts loading the list.

---

### User Story 2 - View a currency's 30-day trend and statistics (Priority: P2)

As a user, I want to tap a currency in the list and see its historical trend,
percentage change, and minimum/maximum rate over the last 30 days, so I can
understand how that currency has been moving, not just its rate today.

**Why this priority**: Once a user can see today's rates (US1), the next most
valuable capability is understanding recent movement — this is what turns a
static rate list into a "monitor."

**Independent Test**: From a loaded currency list, tap any currency. A detail
view opens showing a 30-day historical trend, the percentage change over that
period, and the minimum/maximum rate reached — independently of search or
base-currency switching.

**Acceptance Scenarios**:

1. **Given** the currency list is loaded, **When** the user taps a currency
   list item, **Then** the app navigates to a detail view for that currency.
2. **Given** the detail view is loading historical data, **When** the user is
   waiting, **Then** a loading indicator is shown.
3. **Given** the detail view has loaded successfully, **When** the user views
   it, **Then** it shows: the rate trend for the last 30 days, the percentage
   change in rate between the start and end of that period, and the minimum
   and maximum rate observed during that period.
4. **Given** the detail data fails to load, **When** the error occurs,
   **Then** the user sees a clear error message and a retry action, and
   tapping retry re-attempts loading the detail data.

---

### User Story 3 - Change the base currency (Priority: P3)

As a user, I want to change the base currency (for example, from USD to EUR),
so I can compare all currencies against the base that matters to me.

**Why this priority**: Valuable and central to an "FX Monitor," but the app
is already useful with USD as a fixed base (US1); switching base currency is
an enhancement on top of a working list.

**Independent Test**: From a loaded currency list defaulted to USD, select a
different base currency (e.g. EUR). All list rates update to reflect the new
base, without needing search or the detail view.

**Acceptance Scenarios**:

1. **Given** the currency list is showing rates against USD, **When** the
   user selects a different base currency (e.g. EUR), **Then** the list
   recalculates and redisplays every currency's rate against the new base
   currency.
2. **Given** the base currency has just been changed, **When** the new rates
   are being fetched, **Then** a loading indicator is shown and the previous
   base's rates are not left on screen looking current.
3. **Given** the base currency change fails to load new rates, **When** the
   error occurs, **Then** the user sees a clear error message and a retry
   action.

---

### User Story 4 - Search the currency list (Priority: P4)

As a user, I want to filter the currency list by typing a currency code or
name, so I can quickly find a specific currency without scrolling.

**Why this priority**: A convenience on top of an already-useful, browsable
list (US1) — valuable once the list can be long, but not required for the
app's core purpose.

**Independent Test**: From a loaded currency list, type a currency code (e.g.
"JPY") or name (e.g. "yen") into the search field. The list filters to
matching currencies only, independently of base-currency switching or the
detail view.

**Acceptance Scenarios**:

1. **Given** the currency list is loaded, **When** the user types a currency
   code into the search field, **Then** the list shows only currencies whose
   code matches the typed text.
2. **Given** the currency list is loaded, **When** the user types a currency
   name (or part of it) into the search field, **Then** the list shows only
   currencies whose name matches the typed text.
3. **Given** the user has typed a search query, **When** no currency matches
   it, **Then** the user sees a clear "no results" indication instead of an
   empty, unexplained list.
4. **Given** the user clears the search field, **When** the field becomes
   empty, **Then** the full currency list is shown again.

---

### Edge Cases

- What happens when the historical data source has no rate for one or more of
  the last 30 days (e.g. non-trading days)? The trend, percentage change, and
  min/max MUST be computed from the rates that are available, without
  crashing or showing broken values.
- How does the system behave if the user opens the app with no network
  connection at all? The list MUST show the error-and-retry state rather than
  an indefinite loading indicator.
- How does the system behave if the user changes the base currency while the
  currency list is still loading, or taps a currency while the list is
  reloading? The in-progress request MUST NOT produce a list that mixes rates
  from two different base currencies.
- What happens if the user searches for text that matches neither any
  currency code nor any currency name (e.g. random characters)? The "no
  results" state from User Story 4 applies.
- What happens if the selected base currency is itself present in the list?
  It MUST still appear, showing a rate of 1 against itself.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display a list of major world currencies — at
  minimum USD, EUR, GBP, JPY, BRL, MXN, plus every other non-crypto currency
  available from the data source — each showing its current exchange rate
  against the selected base currency.
- **FR-002**: System MUST default the base currency to USD the first time the
  app is opened, and MUST persist the user's selected base currency across
  app restarts thereafter, restoring it as the active base on subsequent
  launches.
- **FR-003**: Each currency list item MUST show the currency code, the
  currency's full name, and today's rate against the current base currency.
- **FR-004**: System MUST allow the user to select a different base currency
  from the currencies available, and MUST recalculate and redisplay every list
  item's rate against the newly selected base currency.
- **FR-005**: System MUST allow the user to tap any currency list item to
  navigate to a detail view for that currency.
- **FR-006**: The detail view MUST show the historical exchange rate trend for
  the last 30 days for the selected currency against the base currency active
  at the time of navigation.
- **FR-007**: The detail view MUST show the percentage change in rate between
  the start and end of the last-30-days period.
- **FR-008**: The detail view MUST show the minimum and maximum rate observed
  during the last 30 days.
- **FR-009**: System MUST display a loading indicator while currency list
  data, base-currency-change data, or currency detail data is being fetched.
- **FR-010**: System MUST display a clear, human-readable error message and a
  retry action whenever list data, base-currency-change data, or detail data
  fails to load and no previously loaded data exists yet to show instead.
- **FR-011**: Retrying after an error MUST re-attempt the same data fetch that
  failed.
- **FR-019**: If a refresh (list load, base-currency change, or detail load)
  fails while previously loaded data for that same view is already on screen,
  the system MUST keep showing that last-known data, marked as possibly
  stale, rather than replacing it with the error+retry state.
- **FR-012**: System MUST provide a search field that filters the currency
  list by currency code or currency name as the user types.
- **FR-013**: The search filter MUST be case-insensitive and MUST match
  partial code/name text.
- **FR-014**: When a search query matches no currency, the system MUST
  clearly indicate that no results were found.
- **FR-015**: System MUST exclude cryptocurrencies from the currency list.
- **FR-016**: System MUST NOT provide a currency conversion calculator for
  arbitrary custom amounts as part of this feature.
- **FR-017**: System MUST NOT provide rate-change alerts or notifications as
  part of this feature.
- **FR-018**: System MUST NOT show historical data beyond the last 30 days as
  part of this feature.

### Key Entities

- **Currency**: A tradable fiat currency available from the data source;
  identified by its code (e.g. "USD") and full name (e.g. "US Dollar").
- **Exchange Rate**: The rate of one currency against a base currency on a
  given date; used both for "today's rate" in the list and as the unit that
  makes up the historical series in the detail view.
- **Historical Rate Series**: The set of daily exchange rates for a given
  currency against a given base currency over the last 30 days; used to
  derive the trend, percentage change, and min/max shown in the detail view.
- **Base Currency Selection**: The currency the user has currently chosen as
  the comparison base for the whole list (defaults to USD on first launch);
  changing it affects every currency's displayed rate, and the choice is
  persisted locally so it survives an app restart.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A user can view current rates for all available major
  currencies against the default base currency within 3 seconds of opening
  the app under normal network conditions.
- **SC-002**: A user can narrow the currency list to a specific currency using
  search in under 5 seconds.
- **SC-003**: A user can see a currency's 30-day trend, percentage change, and
  minimum/maximum rate on a single detail view, with no further navigation
  required.
- **SC-004**: 100% of list, detail, and base-currency-change load failures
  present the user with an error message and a working retry option — no
  silent failures and no crashes.
- **SC-005**: Switching the base currency updates all displayed rates within 3
  seconds under normal network conditions, with no stale rates left on screen
  from the previous base.
- **SC-006**: A new user can, without external help, find a specific currency
  and view its 30-day trend end to end.

## Assumptions

- "Major world currencies" means every non-crypto currency available from the
  exchange-rate data source, not a fixed curated subset; USD, EUR, GBP, JPY,
  BRL, and MXN in the feature description are illustrative examples, not an
  exhaustive list.
- Base currency selection is a single, app-wide setting — not configurable
  per currency — consistent with "the whole list recalculates against the new
  base."
- "Today's rate" is the most recent rate the data source publishes, which may
  reflect the prior business day on weekends/holidays when no same-day rate
  is published.
- The historical trend is presented as a visual chart of daily rates over the
  last 30 calendar days; the exact visual treatment follows the Figma
  "FX Monitor / Detail" frame referenced for this feature.
- This feature is read-only and public — no user authentication or
  authorization is required to view currency rates.
- List and detail data are refreshed on demand (app open, retry, base-currency
  change), not via background or push updates, consistent with alerts and
  notifications being out of scope.
