import 'package:fluid_clock/analog_clock/timed_rotation.dart';
import 'package:fluid_clock/details_panel/location_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clock_helper/model.dart';

void main() {
  testWidgets('Rotation with 30 seconds', (WidgetTester tester) async {
    final currentTime = DateTime(2019, 1, 1, 17, 0, 30);

    await tester.pumpWidget(TimedRotation(
      animationDuration: Duration(seconds: 60),
      currentTime: Duration(seconds: currentTime.second),
      child: Container(),
    ));

    final state = tester.state<TimedRotationState>(find.byType(TimedRotation));

    expect(state.rotation, 0.5);
  });

  testWidgets('Rotation with 45 seconds', (WidgetTester tester) async {
    final currentTime = DateTime(2019, 1, 1, 17, 0, 45);

    await tester.pumpWidget(TimedRotation(
      animationDuration: Duration(seconds: 60),
      currentTime: Duration(seconds: currentTime.second),
      child: Container(),
    ));

    final state = tester.state<TimedRotationState>(find.byType(TimedRotation));

    expect(state.rotation, 0.75);
  });

  testWidgets('Rotation with 10 minutes', (WidgetTester tester) async {
    final currentTime = DateTime(2019, 1, 1, 17, 15);

    await tester.pumpWidget(TimedRotation(
      animationDuration: Duration(minutes: 60),
      currentTime: Duration(minutes: currentTime.minute),
      child: Container(),
    ));

    final state = tester.state<TimedRotationState>(find.byType(TimedRotation));

    expect(state.rotation, 0.25);
  });

  testWidgets('Rotation with 6 hours', (WidgetTester tester) async {
    final currentTime = DateTime(2019, 1, 1, 6, 15);

    await tester.pumpWidget(TimedRotation(
      animationDuration: Duration(hours: 12),
      currentTime: Duration(hours: currentTime.hour),
      child: Container(),
    ));

    final state = tester.state<TimedRotationState>(find.byType(TimedRotation));

    expect(state.rotation, 0.5);
  });

  testWidgets('Rotation with 6:30 hours', (WidgetTester tester) async {
    final currentTime = DateTime(2019, 1, 1, 6, 30);

    await tester.pumpWidget(TimedRotation(
      animationDuration: Duration(hours: 12),
      currentTime: Duration(hours: currentTime.hour, minutes: currentTime.minute),
      child: Container(),
    ));

    final state = tester.state<TimedRotationState>(find.byType(TimedRotation));

    expect(state.rotation.toStringAsFixed(2), '0.54');
  });
}

Widget _buildWidget(ClockModel model) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: LocationDetails(
      model: model,
    ),
  );
}
