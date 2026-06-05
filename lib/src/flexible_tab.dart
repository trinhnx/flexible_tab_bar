import 'package:flutter/material.dart';

/// Data model for a single tab in [FlexibleTabBar].
///
/// Each tab has:
/// - [label]: The text displayed when the tab is active.
/// - [icon]: The icon displayed in both active and inactive states.
/// - [count]: Optional badge number shown next to the label/icon.
/// - [activeIcon]: Optional icon override when the tab is selected.
///   Falls back to [icon] when null.
class FlexibleTab {
  final String label;
  final Widget icon;
  final int? count;
  final Widget? activeIcon;

  const FlexibleTab({
    required this.label,
    required this.icon,
    this.count,
    this.activeIcon,
  });
}
