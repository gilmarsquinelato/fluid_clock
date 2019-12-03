import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void testSemantics(WidgetTester tester, String label, String value) {
  final finder = find.bySemanticsLabel(label);
  expect(finder, findsOneWidget);

  final widget = tester.widget<Semantics>(finder);
  expect(widget.properties.value, value);
}
