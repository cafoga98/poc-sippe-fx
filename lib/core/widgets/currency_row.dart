import 'package:flutter/material.dart';

import '../design/design_tokens.dart';

/// Figma node 11:21 ("CurrencyRow"). See `contracts/widget-components.md`.
class CurrencyRow extends StatefulWidget {
  const CurrencyRow({
    super.key,
    required this.code,
    required this.name,
    required this.rate,
    this.deltaLabel,
    this.isPositiveDelta,
    required this.onTap,
  });

  final String code;
  final String name;
  final double rate;

  /// `null` hides the delta slot (see `data-model.md`'s `ExchangeRate` note).
  final String? deltaLabel;
  final bool? isPositiveDelta;
  final VoidCallback onTap;

  @override
  State<CurrencyRow> createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    final initials = widget.code.length >= 2
        ? widget.code.substring(0, 2)
        : widget.code;
    final deltaColor = widget.isPositiveDelta == true
        ? DesignTokens.colorAccentPositive
        : DesignTokens.colorAccentNegative;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        decoration: BoxDecoration(
          color: _pressed
              ? DesignTokens.colorBgSurfaceElevated
              : DesignTokens.colorBgSurface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: DesignTokens.colorBgSurfaceElevated,
                shape: BoxShape.circle,
              ),
              child: Text(
                initials,
                style: DesignTokens.textLabelSemiBold12.copyWith(
                  color: DesignTokens.colorTextSecondary,
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.code, style: DesignTokens.textTitleSemiBold16),
                  const SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    widget.name,
                    style: DesignTokens.textCaptionRegular11.copyWith(
                      color: DesignTokens.colorTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.rate.toStringAsFixed(4),
                  style: DesignTokens.textBodyRegular14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.deltaLabel != null) ...[
                  const SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    widget.deltaLabel!,
                    style: DesignTokens.textCaptionRegular11.copyWith(
                      color: deltaColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
