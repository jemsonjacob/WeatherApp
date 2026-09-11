import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';

abstract class WeatherRepository {
  //search
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
  //weather by loc
  Future<Either<Failure, Weather>> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  });
  //for geting loc
  Future<Position> getCurrentLocation();
  //
}
