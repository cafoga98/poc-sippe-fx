import 'package:flutter/material.dart';

import '../../../../core/design/design_tokens.dart';

/// Page-specific composition (not a standalone Figma component) — title +
/// subtitle for `CurrencyListPage`'s header, per the "FX Monitor / List" frame.
class CurrencyListHeader extends StatelessWidget {
  const CurrencyListHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DesignTokens.textHeadingSemiBold20),
        const SizedBox(height: DesignTokens.spacingXs),
        Text(
          subtitle,
          style: DesignTokens.textCaptionRegular11.copyWith(
            color: DesignTokens.colorTextSecondary,
          ),
        ),
      ],
    );
  }
}
