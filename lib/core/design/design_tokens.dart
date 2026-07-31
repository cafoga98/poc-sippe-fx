import 'package:flutter/material.dart';

/// Design tokens mirrored 1:1 from the Figma "sip.pe FX Monitor — UI Kit" file,
/// page "🎨 Foundations" (node 5:4). See `specs/001-currency-list-detail/design-context.md`.
///
/// Widget code MUST reference these constants (Principle IV) instead of hardcoding
/// hex values, spacing, radius, or type-scale numbers.
abstract final class DesignTokens {
  // ---------------------------------------------------------------------
  // Color — primitives (kept for traceability only; widgets use semantic
  // tokens below, not these directly).
  // ---------------------------------------------------------------------
  static const Color navy900 = Color(0xFF0F1117);
  static const Color navy800 = Color(0xFF161A23);
  static const Color navy700 = Color(0xFF1F2430);
  static const Color navy600 = Color(0xFF2A303F);
  static const Color gray100 = Color(0xFFF5F6F8);
  static const Color gray300 = Color(0xFFB4B8C5);
  static const Color gray500 = Color(0xFF7A7F91);
  static const Color green500 = Color(0xFF2ECC91);
  static const Color green700 = Color(0xFF1B9A6B);
  static const Color red500 = Color(0xFFFF6B6B);
  static const Color red700 = Color(0xFFE14545);
  static const Color amber500 = Color(0xFFF5C144);
  static const Color amber700 = Color(0xFFD89F1F);
  static const Color white1000 = Color(0xFFFFFFFF);
  static const Color black1000 = Color(0xFF000000);

  // ---------------------------------------------------------------------
  // Color — semantic (use these in code, not the primitives above)
  // ---------------------------------------------------------------------
  static const Color colorBgPrimary = navy900;
  static const Color colorBgSurface = navy800;
  static const Color colorBgSurfaceElevated = navy700;
  static const Color colorTextPrimary = gray100;
  static const Color colorTextSecondary = gray300;
  static const Color colorTextTertiary = gray500;
  static const Color colorTextInverse = navy900;
  static const Color colorTextOnAccent = white1000;
  static const Color colorAccentPositive = green500;
  static const Color colorAccentNegative = red500;
  static const Color colorAccentHighlight = amber500;
  static const Color colorBrandPrimary = green500;
  static const Color colorBrandPrimaryPressed = green700;
  static const Color colorBorderDefault = navy600;

  // ---------------------------------------------------------------------
  // Typography (Inter)
  // ---------------------------------------------------------------------
  static const String fontFamily = 'Inter';

  /// One-off Detail-frame hero rate size (40px), distinct from [fontSizeDisplay]
  /// (32px, the Foundations `Display/Bold-32` token). Both are kept, not merged
  /// — see research.md §10.
  static const double fontSizeDisplayHero = 40.0;

  static const TextStyle textDisplayBold32 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 38 / 32,
    fontWeight: FontWeight.bold,
    color: colorTextPrimary,
  );

  static const TextStyle textDisplayHeroBold40 = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeDisplayHero,
    height: 38 / 32,
    fontWeight: FontWeight.bold,
    color: colorTextPrimary,
  );

  static const TextStyle textHeadingSemiBold20 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.w600,
    color: colorTextPrimary,
  );

  static const TextStyle textTitleSemiBold16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
    color: colorTextPrimary,
  );

  static const TextStyle textBodyRegular14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.normal,
    color: colorTextPrimary,
  );

  static const TextStyle textLabelSemiBold12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
    color: colorTextPrimary,
  );

  static const TextStyle textCaptionRegular11 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.normal,
    color: colorTextPrimary,
  );

  // ---------------------------------------------------------------------
  // Spacing scale
  // ---------------------------------------------------------------------
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2xl = 48;

  // ---------------------------------------------------------------------
  // Radius scale
  // ---------------------------------------------------------------------
  static const double radiusSm = 8;
  static const double radiusMd = 14;
  static const double radiusLg = 20;
  static const double radiusXl = 28;
  static const double radiusPill = 999;

  // ---------------------------------------------------------------------
  // Elevation (shadows)
  // ---------------------------------------------------------------------
  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x40000000), offset: Offset(0, 2), blurRadius: 6),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x4D000000),
      offset: Offset(0, 6),
      blurRadius: 16,
      spreadRadius: -2,
    ),
    BoxShadow(color: Color(0x26000000), offset: Offset(0, 2), blurRadius: 4),
  ];

  static const List<BoxShadow> shadowGlowPositive = [
    BoxShadow(color: Color(0x402ECC91), offset: Offset(0, 0), blurRadius: 20),
  ];
}
