import 'package:fluid_clock/i18n/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

/// Displays the current time and day of the week and current date
///
///             10:30
///
///      Nov 21, 2019
///          Thursday
class DateTimeDetails extends StatelessWidget {
  DateTimeDetails({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _buildCurrentTime(context),
          _buildCurrentDate(context),
        ],
      ),
    );
  }

  Widget _buildCurrentTime(BuildContext context) {
    final format = model.is24HourFormat
        ? DateFormat.HOUR24_MINUTE
        : DateFormat.HOUR_MINUTE;

    final fullFormat = model.is24HourFormat
        ? DateFormat.HOUR24_MINUTE_SECOND
        : DateFormat.HOUR_MINUTE_SECOND;

    // We put an [ExcludeSemantics] at this time because we want the full time
    // representation, to make sure that the screen reader
    // can read this [Semantics] as a time properly
    return Semantics(
      container: true,
      label: Messages.dateTime.currentTime,
      value: DateFormat(fullFormat).format(currentTime),
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          DateFormat(format).format(currentTime).toLowerCase(),
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }

  Widget _buildCurrentDate(BuildContext context) {
    final currentDate =
        DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(currentTime);
    final dayOfWeek = DateFormat(DateFormat.WEEKDAY).format(currentTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Semantics(
          label: Messages.dateTime.currentDate,
          value: currentDate,
          excludeSemantics: true,
          child: Text(
            currentDate,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Semantics(
          label: Messages.dateTime.dayOfWeek,
          value: dayOfWeek,
          excludeSemantics: true,
          child: Text(
            dayOfWeek,
            style: Theme.of(context).textTheme.body1,
          ),
        ),
      ],
    );
  }
}
