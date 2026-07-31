import 'package:flutter/material.dart';

import '../design/design_tokens.dart';

/// Figma node 10:11 ("SearchBar"). See `contracts/widget-components.md`.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.placeholder = 'Buscar moneda...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String placeholder;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _focused
        ? DesignTokens.colorBrandPrimary
        : DesignTokens.colorBorderDefault;
    final textColor = _focused
        ? DesignTokens.colorTextSecondary
        : DesignTokens.colorTextPrimary;
    final placeholderColor = _focused
        ? DesignTokens.colorTextSecondary
        : DesignTokens.colorTextTertiary;

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.colorBgSurfaceElevated,
        borderRadius: BorderRadius.circular(DesignTokens.radiusPill),
        border: Border.all(color: borderColor, width: _focused ? 1.5 : 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 16,
            color: DesignTokens.colorTextTertiary,
          ),
          const SizedBox(width: DesignTokens.spacingXs),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              style: DesignTokens.textBodyRegular14.copyWith(color: textColor),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: DesignTokens.textBodyRegular14.copyWith(
                  color: placeholderColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
