import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'date_time_details.dart';
import 'location_details.dart';
import 'weather_details.dart';

class DetailsPanel extends StatelessWidget {
  DetailsPanel({
    @required this.currentTime,
    @required this.model,
  })  : assert(currentTime != null),
        assert(model != null);

  final DateTime currentTime;
  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DateTimeDetails(
                currentTime: currentTime,
                model: model,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: WeatherDetails(
                  model: model,
                ),
              ),
              LocationDetails(
                model: model,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
