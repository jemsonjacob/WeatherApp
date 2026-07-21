import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/core/constants/constants.dart';
import 'package:weather/features/forecast/data/model/forecast_model.dart';
import 'package:weather/features/weather/data/exceptions/exceptions.dart';

abstract class ForecastRemoteDataSource {
  //get curent Forecast of searched city
  Future<List<ForecastModel>> getCurrentForecast(String cityName);
  //get coordinates Forecast
  Future<List<ForecastModel>> getForecastByCoordinates({
    required double latitude,
    required double longitude,
  });
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  ForecastRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<ForecastModel>> getCurrentForecast(String cityName) async {
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

      return ForecastModel.fromJsonList(response.data);
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
  Future<List<ForecastModel>> getForecastByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.get(
        forecastUrl,
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': '2b10d5dd5a022f2095e1187c83afec2a',
          'units': 'metric',
        },
      );
      // print(response.data.toString());

      return ForecastModel.fromJsonList(response.data);
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
