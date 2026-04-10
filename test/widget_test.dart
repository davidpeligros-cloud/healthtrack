import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:healthtrack/app.dart';

void main() {
  testWidgets('HealthTrack app boots', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthTrackApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}