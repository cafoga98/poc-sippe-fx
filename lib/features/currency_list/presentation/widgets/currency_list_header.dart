import 'package:flutter/material.dart';

import '../../../../core/design/design_tokens.dart';
import '../../../../core/widgets/app_search_bar.dart';

/// Page-specific composition (not a standalone Figma component) — title +
/// subtitle for `CurrencyListPage`'s header, per the "FX Monitor / List"
/// frame. Also hosts the base-currency selector (US3, FR-002/FR-004) and the
/// search field (US4, FR-012): no dedicated Figma component exists for the
/// base-currency picker (design-context.md is silent on it), so it's kept
/// visually minimal, built only from `design_tokens.dart` values.
class CurrencyListHeader extends StatelessWidget {
  const CurrencyListHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.availableCodes = const [],
    this.onSelectBaseCurrency,
    required this.searchController,
    required this.onSearchChanged,
  });

  final String title;
  final String subtitle;

  /// Currencies already loaded in the list — the picker only ever offers
  /// currencies the user can already see, never a fabricated global list.
  final List<String> availableCodes;
  final ValueChanged<String>? onSelectBaseCurrency;

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  bool get _canPickBase =>
      availableCodes.isNotEmpty && onSelectBaseCurrency != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DesignTokens.textHeadingSemiBold20),
        const SizedBox(height: DesignTokens.spacingXs),
        GestureDetector(
          onTap: _canPickBase ? () => _showBaseCurrencyPicker(context) : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subtitle,
                style: DesignTokens.textCaptionRegular11.copyWith(
                  color: DesignTokens.colorTextSecondary,
                ),
              ),
              if (_canPickBase) ...[
                const SizedBox(width: DesignTokens.spacingXs),
                const Icon(
                  Icons.unfold_more,
                  size: 14,
                  color: DesignTokens.colorTextTertiary,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        AppSearchBar(controller: searchController, onChanged: onSearchChanged),
      ],
    );
  }

  void _showBaseCurrencyPicker(BuildContext context) {
    final onSelect = onSelectBaseCurrency!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: DesignTokens.colorBgSurfaceElevated,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: availableCodes.map((code) {
              return ListTile(
                title: Text(
                  code,
                  style: DesignTokens.textBodyRegular14.copyWith(
                    color: DesignTokens.colorTextPrimary,
                  ),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onSelect(code);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
