import 'package:flutter/material.dart';

import '../../../../core/design/design_tokens.dart';

/// Detail screen's stats card — reuses the Figma `StatsCard`'s visual styling
/// but shows the spec-authoritative fields (FR-007/FR-008), not Figma's
/// Compra/Venta/Rango 52 sem. (see research.md §7).
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.percentChangeLabel,
    required this.minRateLabel,
    required this.maxRateLabel,
  });

  final String percentChangeLabel;
  final String minRateLabel;
  final String maxRateLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.colorBgSurfaceElevated,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      child: Column(
        children: [
          _StatRow(label: 'Cambio 30d', value: percentChangeLabel),
          const SizedBox(height: DesignTokens.spacingSm),
          _StatRow(label: 'Mínimo 30d', value: minRateLabel),
          const SizedBox(height: DesignTokens.spacingSm),
          _StatRow(label: 'Máximo 30d', value: maxRateLabel),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.textBodyRegular14.copyWith(
            color: DesignTokens.colorTextSecondary,
          ),
        ),
        Text(
          value,
          style: DesignTokens.textBodyRegular14.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
