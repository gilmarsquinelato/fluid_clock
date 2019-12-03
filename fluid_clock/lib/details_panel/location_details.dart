import 'package:fluid_clock/i18n/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

/// Displays the current location
///
///     Mountain View, CA
class LocationDetails extends StatelessWidget {
  LocationDetails({
    @required this.model,
  });

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: Messages.general.location,
      value: model.location,
      excludeSemantics: true,
      child: Text(
        model.location,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
