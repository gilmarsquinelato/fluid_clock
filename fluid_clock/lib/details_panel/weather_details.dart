import 'package:fluid_clock/details_panel/weather_animation.dart';
import 'package:fluid_clock/i18n/messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

/// Displays the weather conditions
///
///      Sunny 22.0ºC
///            26.0ºC
///            19.0ºC
class WeatherDetails extends StatelessWidget {
  WeatherDetails({
    @required this.model,
  });

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _WeatherCondition(
              weatherCondition: model.weatherCondition,
            ),
          ),
          _Temperature(
            temperature: model.temperatureString,
            minimumTemperature: model.lowString,
            maximumTemperature: model.highString,
          ),
        ],
      ),
    );
  }
}

class _Temperature extends StatelessWidget {
  const _Temperature({
    Key key,
    @required this.temperature,
    @required this.maximumTemperature,
    @required this.minimumTemperature,
  }) : super(key: key);

  final String temperature;
  final String maximumTemperature;
  final String minimumTemperature;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Semantics(
            container: true,
            label: Messages.weather.currentTemperature,
            value: temperature,
            excludeSemantics: true,
            child: Text(
              temperature,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          _TextWithIcon(
            icon: Icons.keyboard_arrow_up,
            text: maximumTemperature,
            semanticsLabel: Messages.weather.maximumTemperature,
          ),
          _TextWithIcon(
            icon: Icons.keyboard_arrow_down,
            text: minimumTemperature,
            semanticsLabel: Messages.weather.minimumTemperature,
            color: Theme.of(context).textTheme.caption.color,
          ),
        ],
      ),
    );
  }
}

class _WeatherCondition extends StatelessWidget {
  const _WeatherCondition({
    Key key,
    @required this.weatherCondition,
  }) : super(key: key);

  final WeatherCondition weatherCondition;

  @override
  Widget build(BuildContext context) {
    final condition =
        Messages.weather.fromString(enumToString(weatherCondition));

    return Semantics(
      container: true,
      label: Messages.weather.weatherCondition,
      value: condition,
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            condition,
            style: Theme.of(context).textTheme.body1,
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: WeatherAnimation(
              weatherCondition: weatherCondition,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextWithIcon extends StatelessWidget {
  const _TextWithIcon({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.semanticsLabel,
    this.color,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final String semanticsLabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textColor =
        color != null ? color : Theme.of(context).textTheme.body1.color;

    return Semantics(
      container: true,
      label: semanticsLabel,
      value: text,
      excludeSemantics: true,
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.body1.copyWith(
                  color: textColor,
                ),
          ),
          Icon(
            icon,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
