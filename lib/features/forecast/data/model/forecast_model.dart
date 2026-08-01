import 'package:weather/features/forecast/domain/entities/forecast.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required super.dateTime,
    required super.temperature,
    required super.feelsLike,
    required super.humidity,
    required super.windSpeed,
    required super.weatherMain,
    required super.weatherDescription,
    required super.iconCode,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: json["dt_txt"] as String,
      temperature: (json["main"]["temp"] as num).toDouble(),
      feelsLike: (json["main"]["feels_like"] as num).toDouble(),
      humidity: json["main"]["humidity"] as int,
      windSpeed: (json["wind"]["speed"] as num).toDouble(),
      weatherMain: json["weather"][0]["main"] as String,
      weatherDescription: json["weather"][0]["description"] as String,
      iconCode: json["weather"][0]["icon"] as String,
    );
  }

  //to list
  static List<ForecastModel> fromJsonList(Map<String, dynamic> json) {
    final List list = json["list"];

    return list.map((item) => ForecastModel.fromJson(item)).toList();
  }
}
