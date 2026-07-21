import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/features/forecast/data/datasource/forecast_remote_datasource.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'package:weather/features/forecast/domain/repositories/forecast_repository.dart';
import 'package:weather/features/weather/data/exceptions/exceptions.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDataSource remoteDataSource;
  final LocationService locationService;
  ForecastRepositoryImpl({
    required this.remoteDataSource,
    required this.locationService,
  });

  @override
  Future<Either<Failure, List<Forecast>>> getCurrentForecast(
    String cityName,
  ) async {
    try {
      final forecast = await remoteDataSource.getCurrentForecast(cityName);
      return Right(forecast);
    } on CityNotFoundException {
      return Left(const CityNotFoundFailure());
    } on NetworkException {
      return Left(const NetworkFailure());
    } on ServerException {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Position> getCurrentLocation() {
    return locationService.getCurrentLocation();
  }

  @override
  Future<Either<Failure, List<Forecast>>> getForecastByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final forecast = await remoteDataSource.getForecastByCoordinates(
        latitude: latitude,
        longitude: longitude,
      );

      return Right(forecast as List<Forecast>);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
