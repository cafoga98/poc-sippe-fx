# Contract: Standalone Figma-1:1 Widget Components

Per constitution Principle IV, these 5 components must exist as standalone widgets in
`lib/core/widgets/`, matching the Figma component boundaries — not inlined into page/screen
widgets. Every visual value below is a `design_tokens.dart` constant name, not a literal
(traceability requirement); token values themselves are in `design-context.md` and get mirrored
into `design_tokens.dart` during implementation.

## `AppButton` (Figma node 8:17, "Button")

```dart
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,   // null => Disabled state
    this.variant = AppButtonVariant.primary,  // primary | secondary
  });
}
```

**States**: Default / Pressed / Disabled — Pressed via `InkWell`/`GestureDetector` state, Disabled
when `onPressed == null`. **Styling**: `spacing.lg` horizontal / `spacing.md` vertical padding,
`spacing.xs` gap, `radius.md`, label style `Title/SemiBold-16`. Primary: bg
`colorBrandPrimary`/pressed `colorBrandPrimaryPressed`/disabled `colorBrandPrimary` @ 40%, label
`colorTextOnAccent`. Secondary: bg `colorBgSurfaceElevated`, 1px border `colorBorderDefault`, label
`colorTextPrimary`, pressed bg `colorBgSurface`.

**Used by**: retry actions in List/Detail error states (both variants available; retry uses
Primary). Not used for "Agregar a favoritos" — out of scope, research.md §8.

## `AppSearchBar` (Figma node 10:11, "SearchBar")

```dart
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.controller,
    required this.onChanged,
    this.placeholder = 'Buscar moneda...',
  });
}
```

**States**: Default / Focused (via `Focus`/`FocusNode` listener). **Styling**: height 44,
`radius.pill`, `spacing.md`/`spacing.sm` padding, `spacing.xs` gap, leading 16×16 search icon
(`colorTextTertiary`). Default: bg `colorBgSurfaceElevated`, 1px border `colorBorderDefault`,
placeholder `colorTextTertiary`, `Body/Regular-14`. Focused: 1.5px border `colorBrandPrimary`,
text/placeholder `colorTextSecondary`.

**Used by**: `CurrencyListPage` header (US4/FR-012). `onChanged` feeds `CurrencyListCubit`'s
search query, which re-runs the pure `filterCurrencies` usecase (research.md §11) — the widget
itself holds no filtering logic (Principle II).

## `CurrencyRow` (Figma node 11:21)

```dart
class CurrencyRow extends StatelessWidget {
  const CurrencyRow({
    required this.code,
    required this.name,
    required this.rate,
    this.deltaLabel,      // null => delta slot hidden (see data-model.md ExchangeRate note)
    this.isPositiveDelta,
    required this.onTap,
  });
}
```

**States**: Default / Pressed (`InkWell` on the whole row). **Styling**: height 64, full width,
`spacing.md` padding, `spacing.sm` gap, `radius.md`. Leading: 36×36 circle avatar,
`colorBgSurfaceElevated` bg, code-initials text (research.md §5) — not a flag icon. Middle
(flex): code `Title/SemiBold-16` `colorTextPrimary`, name `Caption`-ish 12px `colorTextSecondary`,
`spacing.xs` gap. Trailing: rate SemiBold 14px `colorTextPrimary`, delta (if present) 12px
`colorAccentPositive`/`colorAccentNegative` per `isPositiveDelta`. Default bg `colorBgSurface`,
pressed bg `colorBgSurfaceElevated`.

**Used by**: `CurrencyListPage`'s list (FR-001, FR-003); `onTap` navigates to
`/detail/{baseCode}/{code}` (FR-005).

## `TrendCard` (Figma node 13:19)

```dart
class TrendCard extends StatelessWidget {
  const TrendCard({
    required this.pairLabel,       // e.g. "USD / EUR"
    required this.deltaPercent,    // signed, e.g. +0.42 or -0.12
    required this.value,           // current rate, formatted by caller
    required this.sparklinePoints, // List<double>, normalized by TrendSparkline itself
  });
}
```

**Variants**: Positive / Negative, derived from `deltaPercent.sign`, not passed separately (single
source of truth — avoids a caller passing mismatched variant + sign). **Styling**: 200×160,
`spacing.lg` padding, `spacing.sm` gap, `radius.lg`, bg `colorBgSurfaceElevated`, `shadowMd`. Top
row: pair label `Label/SemiBold-12`-ish `colorTextSecondary`; badge pill `radius.pill`,
`spacing.sm`/`spacing.xs` padding, bg = accent @ 16%, text = accent @ 100% (research.md §9). Value:
Bold 24px `colorTextPrimary`. Chart: 48px tall, full width, `radius.sm`, renders `TrendSparkline`
(real line, not the Figma placeholder block — research.md §2) colored by variant.

**Used by**: `CurrencyListPage`'s trend row (2 cards, per the List frame in design-context.md).

## `BottomNavBar` (Figma node 13:23)

```dart
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.activeDestination,  // enum: overview | markets | watchlist | profile
    required this.onDestinationSelected,
  });
}
```

**Styling**: floating pill, height 64, `radius.pill`, bg `colorBgSurfaceElevated`, double shadow
(`0px 2px 2px rgba(0,0,0,0.15)` + `0px 6px 8px rgba(0,0,0,0.3)`), `spacing.md`/`spacing.sm`
padding, items space-between. Each item: 16×16 icon (Material icon standing in for the Figma
placeholder shape, research.md §5) + `Caption` 11px label, `spacing.xs` gap. Inactive:
`colorTextTertiary`. Active: `colorBrandPrimary`, label SemiBold.

**Used by**: Both `CurrencyListPage` and `CurrencyDetailPage`, `Markets` destination active on
both (per design-context.md's List and Detail frames). Only `Markets` is wired to this feature's
routes; `Overview`/`Watchlist`/`Profile` are visually present (Figma-1:1) but inert — no FR covers
those destinations, so `onDestinationSelected` for them is a documented no-op, not a broken link.

## `TrendSparkline` (supporting, not a named Figma component — see research.md §2)

```dart
class TrendSparkline extends StatelessWidget {
  const TrendSparkline({required this.points, required this.isPositive});
}
```

`CustomPainter` drawing a normalized line/area through `points` (min→max mapped to the widget's
height), stroke color `colorAccentPositive`/`colorAccentNegative` per `isPositive`. Used inside
both `TrendCard` (48px tall) and `CurrencyDetailPage`'s chart area (180px tall, `radius.lg`) — same
widget, different `SizedBox` wrapper, so the line-drawing logic isn't duplicated between the two
call sites.
