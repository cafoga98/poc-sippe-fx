import 'package:flutter/material.dart';

import '../design/design_tokens.dart';

enum BottomNavDestination { overview, markets, watchlist, profile }

const Map<BottomNavDestination, IconData> _destinationIcons = {
  BottomNavDestination.overview: Icons.dashboard_outlined,
  BottomNavDestination.markets: Icons.show_chart,
  BottomNavDestination.watchlist: Icons.star_border,
  BottomNavDestination.profile: Icons.person_outline,
};

const Map<BottomNavDestination, String> _destinationLabels = {
  BottomNavDestination.overview: 'Overview',
  BottomNavDestination.markets: 'Markets',
  BottomNavDestination.watchlist: 'Watchlist',
  BottomNavDestination.profile: 'Profile',
};

/// Figma node 13:23 ("BottomNavBar") — floating pill nav, 4 destinations.
/// Only `Markets` is wired to a route by this feature; the rest are visually
/// present but inert (see `contracts/widget-components.md`).
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.activeDestination,
    required this.onDestinationSelected,
  });

  final BottomNavDestination activeDestination;
  final ValueChanged<BottomNavDestination> onDestinationSelected;

  /// Component-specific double shadow documented in design-context.md's
  /// BottomNavBar section — not one of the named Foundations shadow tokens.
  static const List<BoxShadow> _navShadow = [
    BoxShadow(color: Color(0x26000000), offset: Offset(0, 2), blurRadius: 2),
    BoxShadow(color: Color(0x4D000000), offset: Offset(0, 6), blurRadius: 8),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.colorBgSurfaceElevated,
        borderRadius: BorderRadius.circular(DesignTokens.radiusPill),
        boxShadow: _navShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: BottomNavDestination.values.map((destination) {
          final isActive = destination == activeDestination;
          final color = isActive
              ? DesignTokens.colorBrandPrimary
              : DesignTokens.colorTextTertiary;
          return GestureDetector(
            onTap: () => onDestinationSelected(destination),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_destinationIcons[destination], size: 16, color: color),
                const SizedBox(height: DesignTokens.spacingXs),
                Text(
                  _destinationLabels[destination]!,
                  style: DesignTokens.textCaptionRegular11.copyWith(
                    color: color,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
