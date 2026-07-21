import 'package:weather/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.country,
    required super.temperature,
    required super.feelsLike,
    required super.humidity,
    required super.windSpeed,
    required super.weatherMain,
    required super.weatherDescription,
    required super.iconCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"],
      country: json["sys"]["country"],
      temperature: (json["main"]["temp"] as num).toDouble(),
      feelsLike: json["main"]["feels_like"],
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"],
      weatherMain: json["weather"][0]["main"],
      weatherDescription: json["weather"][0]["description"],
      iconCode: json["weather"][0]["icon"],
    );
  }
}

//the api return
  //{
//     "coord": {
//         "lon": 75,
//         "lat": 35
//     },
//     "weather": [
//         {
//             "id": 804,
//             "main": "Clouds",
//             "description": "overcast clouds",
//             "icon": "04d"
//         }
//     ],
//     "base": "stations",
//     "main": {
//         "temp": 280.92,
//         "feels_like": 279.18,
//         "temp_min": 280.92,
//         "temp_max": 280.92,
//         "pressure": 1013,
//         "humidity": 60,
//         "sea_level": 1013,
//         "grnd_level": 632
//     },
//     "visibility": 10000,
//     "wind": {
//         "speed": 2.71,
//         "deg": 234,
//         "gust": 2.46
//     },
//     "clouds": {
//         "all": 93
//     },
//     "dt": 1784123483,
//     "sys": {
//         "country": "PK",
//         "sunrise": 1784073413,
//         "sunset": 1784124872
//     },
//     "timezone": 18000,
//     "id": 7423730,
//     "name": "Eidgah",
//     "cod": 200
// }