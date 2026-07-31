# Design Context: FX Monitor (Figma)

**Source file**: `qLfN6nCLnmNPF0rMEJPM7X`
**Extracted**: 2026-07-31, via Figma MCP `get_design_context` / `get_variable_defs` / `get_metadata`

This is reference data for `plan.md` and implementation — not a spec. Values are pulled
directly from Figma variables/components; treat CSS var syntax as illustrative and map
to Flutter `ThemeData` / `TextStyle` / `EdgeInsets` / `BorderRadius` equivalents.

## Foundations (node 5:4, page "🎨 Foundations")

### Color — primitives

| Token | Hex |
|---|---|
| navy/900 | `#0f1117` |
| navy/800 | `#161a23` |
| navy/700 | `#1f2430` |
| navy/600 | `#2a303f` |
| gray/100 | `#f5f6f8` |
| gray/300 | `#b4b8c5` |
| gray/500 | `#7a7f91` |
| green/500 | `#2ecc91` |
| green/700 | `#1b9a6b` |
| red/500 | `#ff6b6b` |
| red/700 | `#e14545` |
| amber/500 | `#f5c144` |
| amber/700 | `#d89f1f` |
| white/1000 | `#ffffff` |
| black/1000 | `#000000` |

### Color — semantic (use these in code, not primitives)

| Token | Hex | Maps to primitive |
|---|---|---|
| `color-bg-primary` | `#0f1117` | navy/900 |
| `color-bg-surface` | `#161a23` | navy/800 |
| `color-bg-surface-elevated` | `#1f2430` | navy/700 |
| `color-text-primary` | `#f5f6f8` | gray/100 |
| `color-text-secondary` | `#b4b8c5` | gray/300 |
| `color-text-tertiary` | `#7a7f91` | gray/500 |
| `color-text-inverse` | `#0f1117` | navy/900 |
| `color-text-on-accent` | `#ffffff` | white/1000 |
| `color-accent-positive` | `#2ecc91` | green/500 |
| `color-accent-negative` | `#ff6b6b` | red/500 |
| `color-accent-highlight` | `#f5c144` | amber/500 |
| `color-brand-primary` | `#2ecc91` | green/500 |
| `color-brand-primary-pressed` | `#1b9a6b` | green/700 |
| `color-border-default` | `#2a303f` | navy/600 |

### Typography (Inter)

| Style | Weight | Size | Line height |
|---|---|---|---|
| Display/Bold-32 | Bold | 32px | 38px |
| Heading/SemiBold-20 | SemiBold | 20px | 26px |
| Title/SemiBold-16 | SemiBold | 16px | 22px |
| Body/Regular-14 | Regular | 14px | 20px |
| Label/SemiBold-12 | SemiBold | 12px | 16px |
| Caption/Regular-11 | Regular | 11px | 14px |

### Spacing scale

| Token | Value |
|---|---|
| `spacing-xs` | 4px |
| `spacing-sm` | 8px |
| `spacing-md` | 16px |
| `spacing-lg` | 24px |
| `spacing-xl` | 32px |
| `spacing-2xl` | 48px |

### Radius scale

| Token | Value |
|---|---|
| `radius-sm` | 8px |
| `radius-md` | 14px |
| `radius-lg` | 20px |
| `radius-xl` | 28px |
| `radius-pill` | 999px (fully rounded) |

### Elevation (shadows)

| Token | CSS-equivalent |
|---|---|
| `Shadow/sm` | `0px 2px 6px rgba(0,0,0,0.25)` |
| `Shadow/md` | `0px 6px 16px -2px rgba(0,0,0,0.30)` + `0px 2px 4px rgba(0,0,0,0.15)` (double shadow) |
| `Shadow/glow-positive` | `0px 0px 20px rgba(46,204,145,0.25)` (uses `color-accent-positive` at 25% alpha) |

## Components (page "🧩 Components")

### Button (node 8:17)

- Style variants: **Primary**, **Secondary**; States: **Default**, **Pressed**, **Disabled**
- Padding: `spacing-lg` (24px) horizontal, `spacing-md` (16px) vertical; gap `spacing-xs` (4px)
- Radius: `radius-md` (14px)
- Label: Title/SemiBold-16 equivalent (Inter SemiBold 16px)
- **Primary/Default**: bg `color-brand-primary` (#2ecc91), label `color-text-on-accent` (white)
- **Primary/Pressed**: bg `color-brand-primary-pressed` (#1b9a6b)
- **Primary/Disabled**: bg `color-brand-primary` @ 40% opacity
- **Secondary/Default**: bg `color-bg-surface-elevated` (#1f2430), 1px border `color-border-default`, label `color-text-primary`
- **Secondary/Pressed**: bg `color-bg-surface` (#161a23), border `color-border-default`
- **Secondary/Disabled**: bg `color-bg-surface-elevated`, border `color-border-default`, @ 40% opacity

### SearchBar (node 10:11)

- States: **Default**, **Focused**
- Size: height 44px, width 340px (flexible in list — full-width in "FX Monitor / List")
- Padding: `spacing-md` (16px) horizontal, `spacing-sm` (8px) vertical; gap `spacing-xs` (4px)
- Radius: `radius-pill` (999px)
- Leading icon: 16x16, `color-text-tertiary`, rounded 8px (placeholder circle in design — swap for search glyph)
- **Default**: bg `color-bg-surface-elevated`, 1px border `color-border-default`, placeholder text `color-text-tertiary`, Body/Regular-14
- **Focused**: bg `color-bg-surface-elevated`, 1.5px border `color-brand-primary`, placeholder/text `color-text-secondary`

### CurrencyRow (node 11:21)

- States: **Default**, **Pressed**
- Size: height 64px, full width; padding `spacing-md` (16px); gap `spacing-sm` (8px)
- Radius: `radius-md` (14px)
- Icon: 36x36 circle (radius 18px), bg `color-bg-surface-elevated` (placeholder — swap for flag/currency icon)
- Middle column (flex-grow): code — Title/SemiBold-16 equivalent, `color-text-primary`; name — Caption-ish Regular 12px, `color-text-secondary`; gap `spacing-xs`
- Right column (end-aligned): rate — SemiBold 14px, `color-text-primary`; delta — Regular 12px, `color-accent-positive` (or `color-accent-negative` for negative deltas — verify against value sign, not hardcoded); gap `spacing-xs`
- **Default**: bg `color-bg-surface` (#161a23)
- **Pressed**: bg `color-bg-surface-elevated` (#1f2430)

### TrendCard (node 13:19)

- Trend variants: **Positive**, **Negative**
- Size: 200x160, padding `spacing-lg` (24px), gap `spacing-sm` (8px)
- Radius: `radius-lg` (20px), bg `color-bg-surface-elevated`, drop shadow = `Shadow/md`
- Top row: pair label (e.g. "USD / PEN") Label/SemiBold-12-ish, `color-text-secondary`; badge pill (radius-pill, padding `spacing-sm`/`spacing-xs`) showing delta %, 11px SemiBold
  - **Positive**: badge bg `color-accent-positive`, badge text `color-accent-positive` (on a tinted bg — check actual contrast in Figma; code sample shows text color = accent color, likely needs on-accent white or a lighter tint bg in final art)
  - **Negative**: badge bg `color-accent-negative`, badge text `color-accent-negative`
- Value: Bold 24px, `color-text-primary`
- Chart area: 48px tall, full width, radius `radius-sm` (8px), filled block color = `color-accent-positive` or `color-accent-negative` (placeholder for real sparkline — implement an actual trend line/sparkline, not a solid block)

### BottomNavBar (node 13:23)

- Single state, 4 destinations (Overview, Markets, Watchlist, Profile)
- Floating pill: height 64px, width 360px (full width minus margins in practice), radius `radius-pill`, bg `color-bg-surface-elevated`, drop shadow = double shadow (`0px 2px 2px rgba(0,0,0,0.15)` + `0px 6px 8px rgba(0,0,0,0.3)`)
- Padding `spacing-md` (16px) horizontal, `spacing-sm` (8px) vertical, items space-between
- Each item: 16x16 icon (radius 4px placeholder — swap for real icons) + Caption 11px label, gap `spacing-xs`, centered
- Inactive: icon + label `color-text-tertiary`
- Active: icon + label `color-brand-primary` (SemiBold for active label)

## Frame: FX Monitor / List (node 15:2)

- Root: bg `color-bg-primary`, padding `spacing-lg` (24px) horizontal, `spacing-xl` (32px) vertical, column gap `spacing-lg` (24px)
- Header: title "FX Monitor" (Heading/SemiBold-20-ish, actually Bold ~22px per sample — verify against Foundations scale, closest match is Title/SemiBold-16 scaled or a one-off 22px Bold), subtitle "Actualizado hace {n} min" Body/Regular-12, `color-text-secondary`
- SearchBar: full width, placeholder "Buscar moneda..." (localized ES copy in design — confirm target locale with product before hardcoding)
- Trend row: horizontal, 2x TrendCard, gap `spacing-md` (16px) — sample shows "USD / PEN" positive +0.42% / 3.71, "EUR / PEN" negative -0.12%(shown as -0.68% in component default, -0.12% in row instance — use live data, not sample) / 4.02
- Section label "Monedas" — Label/SemiBold-13ish, `color-text-secondary`
- Currency list: column of CurrencyRow, gap `spacing-xs` (4px), full width
- BottomNavBar: floating, absolutely positioned near bottom, "Markets" tab active

## Frame: FX Monitor / Detail (node 16:56)

- Root: same page shell as List (bg `color-bg-primary`, `spacing-lg`/`spacing-xl` padding, gap `spacing-lg`)
- Header row: 24x24 back-button affordance (bg `color-bg-surface-elevated`, radius 6px — placeholder for back-chevron icon) + pair label ("USD / PEN") Title/SemiBold-16, `color-text-primary`
- Rate block: big value Display-Bold ~40px `color-text-primary` (larger than the 32px Foundations Display token — confirm whether this is an intentional one-off or the Display token should be 40px), delta line "+0.42% hoy" SemiBold 13px `color-accent-positive`/`color-accent-negative`
- Chart: full-width block, 180px tall, radius `radius-lg` (20px), fill = `color-accent-positive`/`color-accent-negative` (placeholder for real 30-day trend chart per FR-006)
- Stats card: bg `color-bg-surface-elevated`, radius `radius-lg` (20px), padding `spacing-md` (16px), column gap `spacing-sm` (8px), rows: "Compra" / "Venta" / "Rango 52 sem." each label (`color-text-secondary`, Regular 13px) vs value (`color-text-primary`, SemiBold 13px) — **note**: spec FR-007/FR-008 call for % change and 30-day min/max, but design shows Compra/Venta/52-week range instead; reconcile field mapping with product (buy/sell rates aren't in FRs; 52-week range vs 30-day min/max is a scope mismatch to flag in plan.md)
- Primary Button: full width, label "Agregar a favoritos" (favoriting isn't in the current FRs — flag as out-of-scope or confirm addition)
- BottomNavBar: same floating component as List, "Markets" active

## Flags for plan.md / spec reconciliation

1. **Detail stats mismatch**: Figma shows Compra/Venta/Rango 52 sem.; spec FR-007/FR-008 require % change over 30 days and 30-day min/max. Decide whether to follow spec (authoritative) and treat the stats-card fields as illustrative placeholders to relabel, or extend scope.
2. **"Agregar a favoritos" button**: not covered by any FR — likely out of scope for this feature; confirm before building.
3. **Chart is a solid color block in Figma**, not a real sparkline/line chart — implementation needs an actual 30-day trend chart per FR-006; use `color-accent-positive`/`color-accent-negative` for line color based on trend direction.
4. **Icons throughout (search glyph, currency icons, back chevron, nav icons) are unstyled placeholder shapes** in the design file — source real iconography (e.g. Material icons or a currency-flag set) separately.
5. **Locale**: design copy is in Spanish (Buscar moneda, Actualizado hace 5 min, Agregar a favoritos, Compra/Venta) while the spec is written in English — confirm target locale(s).
6. **Display type scale discrepancy**: Foundations defines Display/Bold-32, but the Detail rate value renders at 40px in the frame — treat 40px as a one-off "hero" size or add it to the type scale.
