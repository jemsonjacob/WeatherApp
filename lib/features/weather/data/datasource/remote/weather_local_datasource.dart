import 'package:weather/core/db_helper/db_helper.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel weather);

  Future<WeatherModel?> getCachedWeather();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  WeatherLocalDataSourceImpl({required this.databaseHelper});

  final DatabaseHelper databaseHelper;

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    final db = await databaseHelper.database;
    //delete the previous one
    await db.delete('weather_cache');

    await db.insert('weather_cache', {
      'city_name': weather.cityName,
      'country': weather.country,
      'temperature': weather.temperature,
      'feels_like': weather.feelsLike,
      'humidity': weather.humidity,
      'wind_speed': weather.windSpeed,
      'weather_main': weather.weatherMain,
      'weather_description': weather.weatherDescription,
      'icon_code': weather.iconCode,
      'last_updated': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<WeatherModel?> getCachedWeather() async {
    final db = await databaseHelper.database;

    final result = await db.query(
      'weather_cache',
      orderBy: 'id DESC',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    final data = result.first;

    return WeatherModel(
      cityName: data['city_name'] as String,
      country: data['country'] as String,
      temperature: data['temperature'] as double,
      feelsLike: data['feels_like'] as double,
      humidity: data['humidity'] as int,
      windSpeed: data['wind_speed'] as double,
      weatherMain: data['weather_main'] as String,
      weatherDescription: data['weather_description'] as String,
      iconCode: data['icon_code'] as String,
    );
  }
}
