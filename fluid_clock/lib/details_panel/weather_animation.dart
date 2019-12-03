import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class WeatherAnimation extends StatelessWidget {
  WeatherAnimation({@required this.weatherCondition});

  final WeatherCondition weatherCondition;

  @override
  Widget build(BuildContext context) {
    final weather = _getWeatherCondition();

    if (weather == 'n/a') {
      return Container();
    }

    return FlareActor(
      'assets/weather-$weather.flr',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: 'idle',
    );
  }

  String _getWeatherCondition() {
    switch (weatherCondition) {
      case WeatherCondition.cloudy:
        return 'cloudy';
      case WeatherCondition.foggy:
        return 'foggy';
      case WeatherCondition.rainy:
        return 'rainy';
      case WeatherCondition.snowy:
        return 'snowy';
      case WeatherCondition.sunny:
        return 'sunny';
      case WeatherCondition.thunderstorm:
        return 'thunderstorm';
      case WeatherCondition.windy:
        return 'windy';
      default:
        return 'n/a';
    }
  }
}
