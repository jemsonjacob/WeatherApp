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
      dateTime: json["dt_txt"],

      temperature: (json["main"]["temp"] as num).toDouble(),
      feelsLike: json["main"]["feels_like"],
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"],
      weatherMain: json["weather"][0]["main"],
      weatherDescription: json["weather"][0]["description"],
      iconCode: json["weather"][0]["icon"],
    );
  }

  //to list
  static List<ForecastModel> fromJsonList(Map<String, dynamic> json) {
    final List list = json["list"];

    return list.map((item) => ForecastModel.fromJson(item)).toList();
  }
}
