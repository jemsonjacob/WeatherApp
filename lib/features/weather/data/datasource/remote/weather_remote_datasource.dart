import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/features/weather/data/exceptions/exceptions.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  //get curent weather of searched city
  Future<WeatherModel> getCurrentWeather(String cityName);
  //get coordinates weather
  Future<WeatherModel> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  });
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      // print("Before API Call");
      final response = await dio.get(
        '/',
        queryParameters: {
          'q': cityName,
          'appid': '2b10d5dd5a022f2095e1187c83afec2a',
          'units': 'metric',
        },
      );
      // print("After API Call");
      // print(response.realUri);
      final weather = response.data;

      return WeatherModel.fromJson(weather);
    } on DioException catch (e) {
      debugPrint("Message: ${e.message}");

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }

      if (e.response?.statusCode == 404) {
        throw CityNotFoundException();
      }

      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.get(
        '/',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': '2b10d5dd5a022f2095e1187c83afec2a',
          'units': 'metric',
        },
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("Message: ${e.message}");

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException();
      }

      throw ServerException();
    }
  }
}
