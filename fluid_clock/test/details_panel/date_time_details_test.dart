import 'package:fluid_clock/details_panel/date_time_details.dart';
import 'package:fluid_clock/i18n/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clock_helper/model.dart';

import '../test_utils.dart';

void main() {
  final currentTime = DateTime(2019, 1, 1, 17, 40, 0);

  testWidgets('Displays 24 hour format', (WidgetTester tester) async {
    final model = ClockModel()..is24HourFormat = true;

    await tester.pumpWidget(_buildWidget(currentTime, model));

    expect(find.text('17:40'), findsOneWidget);
  });

  testWidgets('Displays 12 hour format', (WidgetTester tester) async {
    final model = ClockModel()..is24HourFormat = false;

    await tester.pumpWidget(_buildWidget(currentTime, model));

    expect(find.text('5:40 pm'), findsOneWidget);
  });

  testWidgets('Displays current date', (WidgetTester tester) async {
    final model = ClockModel()..is24HourFormat = false;

    await tester.pumpWidget(_buildWidget(currentTime, model));

    expect(find.text('Jan 1, 2019'), findsOneWidget);
  });

  testWidgets('Displays day of week', (WidgetTester tester) async {
    final model = ClockModel()..is24HourFormat = false;

    await tester.pumpWidget(_buildWidget(currentTime, model));

    expect(find.text('Tuesday'), findsOneWidget);
  });

  testWidgets('[Semantics] currentTime 24 hour', (WidgetTester tester) async {
    final currentTime = DateTime(2019, 1, 1, 17, 40, 0);
    final model = ClockModel()..is24HourFormat = true;

    await tester.pumpWidget(_buildWidget(currentTime, model));

    testSemantics(
      tester,
      Messages.dateTime.currentTime,
      '17:40:00',
    );
  });

  testWidgets('[Semantics] currentTime 12 hour', (WidgetTester tester) async {
    final model = ClockModel()..is24HourFormat = false;

    await tester.pumpWidget(_buildWidget(currentTime, model));

    testSemantics(
      tester,
      Messages.dateTime.currentTime,
      '5:40:00 PM',
    );
  });

  testWidgets('[Semantics] currentDate', (WidgetTester tester) async {
    final model = ClockModel();

    await tester.pumpWidget(_buildWidget(currentTime, model));

    testSemantics(
      tester,
      Messages.dateTime.currentDate,
      'Jan 1, 2019',
    );
  });

  testWidgets('[Semantics] dayOfWeek', (WidgetTester tester) async {
    final model = ClockModel();

    await tester.pumpWidget(_buildWidget(currentTime, model));

    testSemantics(
      tester,
      Messages.dateTime.dayOfWeek,
      'Tuesday',
    );
  });
}

Widget _buildWidget(DateTime currentTime, ClockModel model) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: DateTimeDetails(
      currentTime: currentTime,
      model: model,
    ),
  );
}
