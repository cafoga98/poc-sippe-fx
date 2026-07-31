import 'package:flutter/material.dart';

import '../design/design_tokens.dart';

enum AppButtonVariant { primary, secondary }

/// Figma node 8:17 ("Button") — Primary/Secondary variants,
/// Default/Pressed/Disabled states. See `contracts/widget-components.md`.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
  });

  final String label;

  /// `null` puts the button in its Disabled state.
  final VoidCallback? onPressed;
  final AppButtonVariant variant;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  bool get _isDisabled => widget.onPressed == null;

  void _setPressed(bool value) {
    if (_isDisabled) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == AppButtonVariant.primary;

    final Color backgroundColor;
    final Color labelColor;
    Border? border;

    if (isPrimary) {
      labelColor = DesignTokens.colorTextOnAccent;
      border = null;
      if (_isDisabled) {
        backgroundColor = DesignTokens.colorBrandPrimary.withValues(alpha: 0.4);
      } else if (_pressed) {
        backgroundColor = DesignTokens.colorBrandPrimaryPressed;
      } else {
        backgroundColor = DesignTokens.colorBrandPrimary;
      }
    } else {
      labelColor = DesignTokens.colorTextPrimary;
      border = Border.all(color: DesignTokens.colorBorderDefault, width: 1);
      if (_isDisabled) {
        backgroundColor = DesignTokens.colorBgSurfaceElevated.withValues(
          alpha: 0.4,
        );
      } else if (_pressed) {
        backgroundColor = DesignTokens.colorBgSurface;
      } else {
        backgroundColor = DesignTokens.colorBgSurfaceElevated;
      }
    }

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingMd,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: border,
        ),
        child: Center(
          child: Text(
            widget.label,
            style: DesignTokens.textTitleSemiBold16.copyWith(color: labelColor),
          ),
        ),
      ),
    );
  }
}
