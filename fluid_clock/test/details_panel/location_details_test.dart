import 'package:fluid_clock/details_panel/location_details.dart';
import 'package:fluid_clock/i18n/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clock_helper/model.dart';

void main() {
  final model = ClockModel()..location = 'London, UK';

  testWidgets('Displays current location', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    expect(find.text(model.location), findsOneWidget);
  });

  testWidgets('[Semantics] current location', (WidgetTester tester) async {
    await tester.pumpWidget(_buildWidget(model));

    final finder = find.bySemanticsLabel(Messages.general.location);
    expect(finder, findsOneWidget);

    final widget = tester.widget<Semantics>(finder);
    expect(widget.properties.value, model.location);
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
