import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flexible_tab_bar_example/main.dart';

void main() {
  testWidgets('FlexibleTabBar example renders three tab sections',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());

    // All three section headers should be visible
    expect(find.text('Basic (count badges, dividers)'), findsOneWidget);
    expect(find.text('Minimal (no dividers, no badges)'), findsOneWidget);
    expect(find.text('Always show labels + custom style'), findsOneWidget);

    // Tab labels should be present
    expect(find.text('Crypto'), findsOneWidget);
    expect(find.text('Day'), findsOneWidget);
    expect(find.text('Bitcoin'), findsOneWidget);
  });
}
