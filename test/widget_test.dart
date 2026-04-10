import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:healthtrack/app.dart';

void main() {
  testWidgets('HealthTrack renders the root scaffold', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthTrackApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
