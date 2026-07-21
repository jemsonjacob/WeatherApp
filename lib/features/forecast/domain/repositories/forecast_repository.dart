import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';

abstract class ForecastRepository {
  Future<Either<Failure, List<Forecast>>> getCurrentForecast(String cityName);

  Future<Either<Failure, List<Forecast>>> getForecastByCoordinates({
    required double latitude,
    required double longitude,
  });

  Future<Position> getCurrentLocation();
}
