import 'package:fluid_clock/details_panel/weather_details.dart';
import 'package:fluid_clock/i18n/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clock_helper/model.dart';

import '../test_utils.dart';

void main() {
  final model = ClockModel()
    ..unit = TemperatureUnit.celsius
    ..temperature = 25
    ..low = 18
    ..high = 30
    ..weatherCondition = WeatherCondition.cloudy;

  testWidgets('Displays current temperature', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    expect(find.text(model.temperatureString), findsOneWidget);
  });

  testWidgets('Displays maximum temperature', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    expect(find.text(model.highString), findsOneWidget);
  });

  testWidgets('Displays minimum temperature', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    expect(find.text(model.lowString), findsOneWidget);
  });

  testWidgets('Displays weather condition', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    expect(find.text('cloudy'), findsOneWidget);
  });

  testWidgets('[Semantics] current temperature', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    testSemantics(
      tester,
      Messages.weather.currentTemperature,
      model.temperatureString,
    );
  });

  testWidgets('[Semantics] maximum temperature', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    testSemantics(
      tester,
      Messages.weather.maximumTemperature,
      model.highString,
    );
  });

  testWidgets('[Semantics] minimum temperature', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    testSemantics(
      tester,
      Messages.weather.minimumTemperature,
      model.lowString,
    );
  });

  testWidgets('[Semantics] weather condition', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    testSemantics(
      tester,
      Messages.weather.weatherCondition,
      'cloudy',
    );
  });
}

Widget _buildWidget(ClockModel model) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: WeatherDetails(
      model: model,
    ),
  );
}
