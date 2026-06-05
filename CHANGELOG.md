## 0.2.0

- **Fix**: Dividers now render correctly at ~85% of tab bar height (was invisible due to zero-height Container).
- **Fix**: Dividers default to white 30% opacity for visibility on dark backgrounds.
- **Fix**: Widget test updated from default template to actual tab bar test.
- **Docs**: Screenshots, problem/pain-point section, AI agent integration guide added.
- **Example**: Cleaned up — removed fake price data, only demos tab bar variants.
- **Internal**: `CrossAxisAlignment.center` retained as default (stretch breaks in scrollable layouts).

## 0.1.0

- Initial release.
- `FlexibleTabBar` widget with animated expand/compact behavior.
- `FlexibleTab` data model with label, icon, and optional count.
- Support for custom colors, dividers, badges, and animation settings.
- `alwaysShowLabel` option for always-visible tab labels.
