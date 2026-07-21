import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherMain,
    required this.weatherDescription,
    required this.iconCode,
  });

  final String cityName;
  final String country;
  final double feelsLike;
  final int humidity;
  final String iconCode;
  final double temperature;
  final String weatherDescription;
  final String weatherMain;
  final double windSpeed;

  @override
  List<Object?> get props => [
    cityName,
    country,
    temperature,
    feelsLike,
    humidity,
    windSpeed,
    weatherMain,
    weatherDescription,
    iconCode,
  ];
}
