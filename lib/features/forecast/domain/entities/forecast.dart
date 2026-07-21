import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  const Forecast({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherMain,
    required this.weatherDescription,
    required this.iconCode,
  });

  final String dateTime;
  final double feelsLike;
  final int humidity;
  final String iconCode;
  final double temperature;
  final String weatherDescription;
  final String weatherMain;
  final double windSpeed;

  @override
  List<Object?> get props => [
    dateTime,
    temperature,
    feelsLike,
    humidity,
    windSpeed,
    weatherMain,
    weatherDescription,
    iconCode,
  ];
}
