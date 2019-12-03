import 'package:intl/intl.dart';

class Messages {
  const Messages();

  static const _weatherMessages = WeatherMessages();
  static const _dateTimeMessages = DateTimeMessages();
  static const _generalMessages = GeneralMessages();

  static WeatherMessages get weather => _weatherMessages;
  static DateTimeMessages get dateTime => _dateTimeMessages;
  static GeneralMessages get general => _generalMessages;

}

class GeneralMessages {
  const GeneralMessages();

  String get location => Intl.message('location');
}

class DateTimeMessages {
  const DateTimeMessages();

  String get currentTime => Intl.message('currentTime');
  String get currentDate => Intl.message('currentDate');
  String get dayOfWeek => Intl.message('dayOfWeek');
}

class WeatherMessages {
  const WeatherMessages();

  String fromString(String weatherCondition) => Intl.message(weatherCondition);

  String get weatherCondition => Intl.message('weatherCondition');
  String get currentTemperature => Intl.message('currentTemperature');
  String get maximumTemperature => Intl.message('maximumTemperature');
  String get minimumTemperature => Intl.message('minimumTemperature');

  String get cloudy => Intl.message('cloudy');
  String get foggy => Intl.message('foggy');
  String get rainy => Intl.message('rainy');
  String get snowy => Intl.message('snowy');
  String get sunny => Intl.message('sunny');
  String get thunderstorm => Intl.message('thunderstorm');
  String get windy => Intl.message('windy');
}