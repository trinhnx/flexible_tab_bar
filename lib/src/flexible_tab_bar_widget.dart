import 'package:flutter/material.dart';
import 'flexible_tab.dart';

/// A flex-based animated tab bar.
///
/// Active tabs expand horizontally, inactive tabs compact.
/// Each tab displays an icon, optional label (shown when active), and
/// an optional count badge — with smooth [AnimatedContainer] transitions.
///
/// {@tool snippet}
/// ```dart
/// FlexibleTabBar(
///   tabs: const [
///     FlexibleTab(label: 'Crypto', icon: Icon(Icons.bitcoin), count: 3),
///     FlexibleTab(label: 'Stocks', icon: Icon(Icons.trending_up), count: 7),
///   ],
///   selectedIndex: _index,
///   onTabChanged: (i) => setState(() => _index = i),
///   activeColor: Colors.orange,
/// )
/// ```
/// {@end-tool}
class FlexibleTabBar extends StatelessWidget {
  /// The list of tabs to display.
  final List<FlexibleTab> tabs;

  /// The index of the currently selected tab.
  final int selectedIndex;

  /// Called when the user taps a tab.
  final ValueChanged<int> onTabChanged;

  /// The background color of the active tab pill.
  final Color activeColor;

  /// The color applied to inactive icons and text.
  final Color inactiveColor;

  /// The background color of the whole tab bar container.
  /// Defaults to [ColorScheme.surfaceContainerHighest] or a dark card color.
  final Color? backgroundColor;

  /// Color of the vertical dividers between tabs.
  /// Defaults to [inactiveColor] at 10% opacity.
  final Color? dividerColor;

  /// Padding around the entire tab bar.
  final EdgeInsetsGeometry padding;

  /// Border radius of the tab bar container.
  final BorderRadiusGeometry borderRadius;

  /// Border radius of each tab pill.
  /// Defaults to a small rounded rectangle.
  final BorderRadiusGeometry tabBorderRadius;

  /// Duration of the tab expand/collapse animation.
  final Duration animationDuration;

  /// Curve of the tab expand/collapse animation.
  final Curve animationCurve;

  /// Text style for the active tab label.
  final TextStyle? activeTextStyle;

  /// Text style for the inactive tab label (when [alwaysShowLabel] is true).
  final TextStyle? inactiveTextStyle;

  /// Whether to show vertical dividers between tabs.
  final bool showDivider;

  /// Thickness of the vertical dividers.
  final double dividerThickness;

  /// Alignment of tab rows.
  final CrossAxisAlignment crossAxisAlignment;

  /// Padding inside each individual tab.
  final EdgeInsetsGeometry tabPadding;

  /// If true, labels are always visible (not just when the tab is active).
  final bool alwaysShowLabel;

  /// Text style for the count badge number.
  final TextStyle? countBadgeTextStyle;

  /// Background color of the count badge when the tab is active.
  /// Defaults to white at 20% opacity.
  final Color? activeCountBadgeColor;

  /// Background color of the count badge when the tab is inactive.
  /// Defaults to [inactiveColor] at 20% opacity.
  final Color? inactiveCountBadgeColor;

  const FlexibleTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
    this.backgroundColor,
    this.dividerColor,
    this.padding = const EdgeInsets.all(4),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.tabBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.showDivider = true,
    this.dividerThickness = 1.0,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.tabPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    this.alwaysShowLabel = false,
    this.countBadgeTextStyle,
    this.activeCountBadgeColor,
    this.inactiveCountBadgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBg = backgroundColor ??
        theme.colorScheme.surfaceContainerHighest;
    final resolvedDivider =
        dividerColor ?? Colors.white.withValues(alpha: 0.3);

    final defaultActiveStyle = activeTextStyle ??
        TextStyle(
          color: theme.colorScheme.onPrimary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        );
    final defaultInactiveStyle = inactiveTextStyle ??
        TextStyle(
          color: inactiveColor,
          fontSize: 13,
        );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: borderRadius,
      ),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: List.generate(tabs.length * 2 - 1, (index) {
          // Even indices → tabs, odd indices → dividers
          if (index.isOdd) {
            if (!showDivider) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: dividerThickness,
                color: resolvedDivider,
              ),
            );
          }

          final i = index ~/ 2;
          final tab = tabs[i];
          final isActive = selectedIndex == i;
          final labelVisible = isActive || alwaysShowLabel;

          return Expanded(
            flex: isActive ? 3 : 1,
            child: GestureDetector(
              onTap: () => onTabChanged(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                padding: _resolveTabPadding(isActive, context),
                decoration: BoxDecoration(
                  color: isActive ? activeColor : Colors.transparent,
                  borderRadius: tabBorderRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIcon(tab, isActive, theme),
                    if (labelVisible) ...[
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          tab.label,
                          overflow: TextOverflow.ellipsis,
                          style: isActive
                              ? defaultActiveStyle
                              : defaultInactiveStyle,
                        ),
                      ),
                    ],
                    if (tab.count != null && tab.count! > 0) ...[
                      const SizedBox(width: 4),
                      _buildCountBadge(tab.count!, isActive),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  EdgeInsetsGeometry _resolveTabPadding(bool isActive, BuildContext context) {
    final resolved = tabPadding.resolve(Directionality.of(context));
    final extra = isActive ? 8.0 : 0.0;
    return EdgeInsets.only(
      left: resolved.left + extra,
      top: resolved.top,
      right: resolved.right + extra,
      bottom: resolved.bottom,
    );
  }

  Widget _buildIcon(FlexibleTab tab, bool isActive, ThemeData theme) {
    final icon =
        isActive && tab.activeIcon != null ? tab.activeIcon! : tab.icon;
    return IconTheme(
      data: IconThemeData(
        color: isActive ? theme.colorScheme.onPrimary : inactiveColor,
        size: 16,
      ),
      child: icon,
    );
  }

  Widget _buildCountBadge(int count, bool isActive) {
    final defaultBadgeColor = isActive
        ? (activeCountBadgeColor ?? Colors.white.withValues(alpha: 0.2))
        : (inactiveCountBadgeColor ??
            inactiveColor.withValues(alpha: 0.2));
    final defaultCountStyle = countBadgeTextStyle ??
        TextStyle(
          fontSize: 10,
          color: isActive ? Colors.white : inactiveColor,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: defaultBadgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count',
        style: defaultCountStyle,
      ),
    );
  }
}
