import 'package:flutter/material.dart';

import '../design/design_tokens.dart';
import 'trend_sparkline.dart';

/// Figma node 13:19 ("TrendCard"). Positive/Negative variant is derived from
/// [deltaPercent]'s sign, not passed separately. See `contracts/widget-components.md`.
class TrendCard extends StatelessWidget {
  const TrendCard({
    super.key,
    required this.pairLabel,
    required this.deltaPercent,
    required this.value,
    required this.sparklinePoints,
  });

  final String pairLabel;
  final double deltaPercent;
  final String value;
  final List<double> sparklinePoints;

  bool get _isPositive => deltaPercent >= 0;

  @override
  Widget build(BuildContext context) {
    final accent = _isPositive
        ? DesignTokens.colorAccentPositive
        : DesignTokens.colorAccentNegative;
    final sign = _isPositive ? '+' : '';

    return Container(
      width: 200,
      height: 160,
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      decoration: BoxDecoration(
        color: DesignTokens.colorBgSurfaceElevated,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        boxShadow: DesignTokens.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  pairLabel,
                  style: DesignTokens.textLabelSemiBold12.copyWith(
                    color: DesignTokens.colorTextSecondary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingSm,
                  vertical: DesignTokens.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusPill),
                ),
                child: Text(
                  '$sign${deltaPercent.toStringAsFixed(2)}%',
                  style: DesignTokens.textCaptionRegular11.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            value,
            style: DesignTokens.textHeadingSemiBold20.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              child: TrendSparkline(
                points: sparklinePoints,
                isPositive: _isPositive,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
