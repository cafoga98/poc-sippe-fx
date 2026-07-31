import 'package:flutter/material.dart';

import '../../../../core/design/design_tokens.dart';
import '../../../../core/widgets/trend_card.dart';

/// Page-specific composition of 2x `TrendCard`, per the "FX Monitor / List"
/// frame's trend row. Not wired into `CurrencyListPage` in US1: `TrendCard`
/// requires a real day-over-day `deltaPercent`, and US1's data source
/// (`GET /v2/rates?base=...`) only returns a single current-rate snapshot —
/// no historical comparison to derive a delta from. Same reasoning as
/// `data-model.md`'s decision to hide `CurrencyRow`'s own delta slot: no FR
/// requires this row, and there's no legitimate data source for it yet.
/// Kept as a tested, reusable widget for when a real data source exists.
class TrendRow extends StatelessWidget {
  const TrendRow({super.key, required this.cards});

  final List<TrendCard> cards;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(width: DesignTokens.spacingMd),
          cards[i],
        ],
      ],
    );
  }
}
