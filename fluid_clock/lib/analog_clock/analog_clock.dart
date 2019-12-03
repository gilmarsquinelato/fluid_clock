import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

import 'clock_decoration.dart';
import 'clock_hand.dart';
import 'timed_rotation.dart';

class AnalogClock extends StatelessWidget {
  AnalogClock({
    @required this.currentTime,
  }) : assert(currentTime != null);

  final DateTime currentTime;

  int _from24HourTo12(int hour) => hour <= 12 ? hour : hour - 12;

  TinyColor _mainColor(BuildContext context) =>
      TinyColor(Theme.of(context).accentColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: CircleBorder(),
      elevation: 6,
      child: Stack(
        children: <Widget>[
          _buildClockDecoration(context),
          _buildMinutesPointer(context),
          _buildHoursPointer(context),
          _buildSecondsPointer(context),
        ],
      ),
    );
  }

  Widget _buildClockDecoration(BuildContext context) {
    return ClockDecoration(
      secondsColor: _mainColor(context).color,
      secondsLength: 10,
      minutesColor: _mainColor(context).color,
      minutesLength: 15,
      hoursColor: _mainColor(context).complement().color,
      hoursLength: 20,
      outerSpacing: 8,
    );
  }

  Widget _buildSecondsPointer(BuildContext context) {
    final strokeColor = _mainColor(context).lighten(20);
    return TimedRotation(
      animationDuration: Duration(seconds: 60),
      currentTime: Duration(seconds: currentTime.second),
      child: ClockHand(
        strokeColor: strokeColor.color,
        fillColor: strokeColor.darken().color,
        thickness: 4,
        outerSpacing: 18,
        centerCircleRadius: Radius.circular(6),
      ),
    );
  }

  Widget _buildMinutesPointer(BuildContext context) {
    final strokeColor = _mainColor(context);
    return TimedRotation(
      animationDuration: Duration(minutes: 60),
      currentTime: Duration(
        minutes: currentTime.minute,
        seconds: currentTime.second,
      ),
      child: ClockHand(
        strokeColor: strokeColor.color,
        fillColor: strokeColor.darken().color,
        thickness: 8,
        outerSpacing: 28,
      ),
    );
  }

  Widget _buildHoursPointer(BuildContext context) {
    final strokeColor = _mainColor(context).darken();
    return TimedRotation(
      // Analog clock is only in 12 hour format
      animationDuration: Duration(hours: 12),
      currentTime: Duration(
        hours: _from24HourTo12(currentTime.hour),
        minutes: currentTime.minute,
        seconds: currentTime.second,
      ),
      child: ClockHand(
        strokeColor: strokeColor.color,
        fillColor: strokeColor.darken().color,
        thickness: 10,
        outerSpacing: 64,
      ),
    );
  }
}
