# FlexibleTabBar

[![version](https://img.shields.io/badge/version-0.1.0-blue)]()
[![pub.dev](https://img.shields.io/pub/v/flexible_tab_bar)](https://pub.dev/packages/flexible_tab_bar)
[![license](https://img.shields.io/badge/license-MIT-green)]()

A beautifully animated, flex-based tab bar for Flutter.

**Active tabs expand horizontally**, inactive tabs compact — with icons, labels, optional count badges, and smooth `AnimatedContainer` transitions.

Built from a real-world crypto tracking app by [trinhnx](https://trinhnx.dev), extracted as a reusable component so everyone can benefit.

## Features

- ✅ Smooth animated tab switching (expand/compact)
- ✅ Custom icons per tab (with optional active-state icon override)
- ✅ Optional count badges on each tab
- ✅ Customizable colors, border radius, and spacing
- ✅ Vertical dividers between tabs (toggle on/off)
- ✅ Option to always show labels (not just when active)
- ✅ Zero external dependencies — pure Flutter Material
- ✅ Works on all platforms (Android, iOS, Web, macOS, Windows, Linux)

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flexible_tab_bar: ^0.1.0
```

Or use the latest version from git:

```yaml
dependencies:
  flexible_tab_bar:
    git: https://github.com/trinhnx/flexible_tab_bar.git
```

## Quick Start

```dart
import 'package:flexible_tab_bar/flexible_tab_bar.dart';

// Inside a StatefulWidget:
FlexibleTabBar(
  tabs: const [
    FlexibleTab(
      label: 'Crypto',
      icon: Icon(Icons.currency_bitcoin),
      count: 3,
    ),
    FlexibleTab(
      label: 'Commodity',
      icon: Icon(Icons.emoji_events),
      count: 1,
    ),
    FlexibleTab(
      label: 'Stocks',
      icon: Icon(Icons.candlestick_chart),
      count: 7,
    ),
  ],
  selectedIndex: _selectedIndex,
  onTabChanged: (index) {
    setState(() => _selectedIndex = index);
  },
  activeColor: Colors.orange,
  inactiveColor: Colors.grey,
)
```

## Integration Guide

### 1. Basic Setup

Wrap your app in a `MaterialApp` (or use within any existing Flutter project). The widget works with any theme — light, dark, or custom.

### 2. State Management

`FlexibleTabBar` is a simple controlled widget. You manage the `selectedIndex` yourself:

```dart
int _selectedIndex = 0;

FlexibleTabBar(
  selectedIndex: _selectedIndex,
  onTabChanged: (i) => setState(() => _selectedIndex = i),
  // ...
)
```

This works with any state management approach:
- `setState` 
- Provider / Riverpod
- Bloc / Cubit
- GetX
- Any other state solution

### 3. Responding to Tab Changes

Use `selectedIndex` to control what content is shown:

```dart
// With IndexedStack (preserves state):
IndexedStack(
  index: _selectedIndex,
  children: [
    WalletPage(),
    HistoryPage(),
    SettingsPage(),
  ],
)

// Or conditional rendering:
if (_selectedIndex == 0)
  CryptoDashboard()
else if (_selectedIndex == 1)
  CommodityList()
else
  StockPortfolio()
```

### 4. Styling

```dart
FlexibleTabBar(
  activeColor: Colors.orange,         // Active tab pill color
  inactiveColor: Colors.grey,          // Inactive icon/text color
  activeCountBadgeColor: Colors.white.withOpacity(0.2), // Badge bg (active)
  inactiveCountBadgeColor: Colors.grey.withOpacity(0.2),// Badge bg (inactive)
  backgroundColor: Color(0xFF1E1E1E),  // Container background
  borderRadius: BorderRadius.circular(16), // Roundness
  padding: EdgeInsets.all(6),          // Outer padding
  animationDuration: Duration(milliseconds: 300), // Transition speed
)
```

### 5. Compact Mode (no labels when inactive)

By default, labels only show for the active tab (saves space). If you want all labels visible:

```dart
FlexibleTabBar(
  alwaysShowLabel: true,
  // ...
)
```

### 6. No Badges

Simply omit the `count` field or set it to `null`:

```dart
FlexibleTab(label: 'Day', icon: Icon(Icons.wb_sunny)),
```

### 7. Custom Active Icon

Use a different icon when the tab is selected:

```dart
FlexibleTab(
  label: 'Bitcoin',
  icon: Icon(Icons.currency_bitcoin, color: Colors.grey),
  activeIcon: Icon(Icons.currency_bitcoin, color: Colors.white),
)
```

### 8. Theming

`FlexibleTabBar` respects `Theme.of(context)` for default colors:
- `activeColor` → uses your seed color via `colorScheme.onPrimary`
- `backgroundColor` → uses `colorScheme.surfaceContainerHighest`
- Active tab icon/text → `colorScheme.onPrimary`

## API Reference

### FlexibleTabBar

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `tabs` | `List<FlexibleTab>` | (required) | The tabs to display |
| `selectedIndex` | `int` | (required) | Currently selected tab index |
| `onTabChanged` | `ValueChanged<int>` | (required) | Callback when a tab is tapped |
| `activeColor` | `Color` | `Colors.orange` | Active tab background |
| `inactiveColor` | `Color` | `Colors.grey` | Inactive icon/text color |
| `backgroundColor` | `Color?` | theme surface | Container background |
| `dividerColor` | `Color?` | 10% of inactiveColor | Vertical divider color |
| `padding` | `EdgeInsetsGeometry` | `all(4)` | Container padding |
| `borderRadius` | `BorderRadiusGeometry` | `circular(12)` | Container & tab radius |
| `animationDuration` | `Duration` | `300ms` | Transition duration |
| `animationCurve` | `Curve` | `easeInOut` | Transition curve |
| `showDivider` | `bool` | `true` | Show vertical dividers |
| `dividerThickness` | `double` | `1.0` | Divider width |
| `crossAxisAlignment` | `CrossAxisAlignment` | `center` | Row alignment |
| `tabPadding` | `EdgeInsetsGeometry` | `sym(v:10)` | Inner tab padding |
| `alwaysShowLabel` | `bool` | `false` | Show labels on inactive tabs |
| `activeTextStyle` | `TextStyle?` | bold 13px white | Active label style |
| `inactiveTextStyle` | `TextStyle?` | 13px grey | Inactive label style |
| `countBadgeTextStyle` | `TextStyle?` | 10px white/grey | Badge number style |
| `activeCountBadgeColor` | `Color?` | white 20% | Badge bg (active) |
| `inactiveCountBadgeColor` | `Color?` | grey 20% | Badge bg (inactive) |

### FlexibleTab

| Parameter | Type | Description |
|-----------|------|-------------|
| `label` | `String` | Tab display label |
| `icon` | `Widget` | Tab icon (any widget) |
| `count` | `int?` | Optional badge count |
| `activeIcon` | `Widget?` | Optional icon override when selected |

## Example

Run the example app:

```bash
cd example/
flutter run
```

The example demonstrates:
- Basic usage with 3 asset types and count badges
- Minimal mode (no dividers, no badges) for time-period tabs
- Always-show-labels with custom styling
- Integration with a dark-themed app

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## License

MIT — see [LICENSE](LICENSE).
