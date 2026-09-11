import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/features/weather/data/datasource/remote/weather_local_datasource.dart';
import 'package:weather/features/weather/data/datasource/remote/weather_remote_datasource.dart';
import 'package:weather/features/weather/data/exceptions/exceptions.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';
import 'package:weather/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final LocationService locationService;
  final WeatherLocalDataSource localDataSource;
  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.locationService,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final weather = await remoteDataSource.getCurrentWeather(cityName);
      return Right(weather);
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
  Future<Either<Failure, Weather>> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final weather = await remoteDataSource.getWeatherByCoordinates(
        latitude: latitude,
        longitude: longitude,
      );
      //  print('Saving weather to SQLite');
      await localDataSource.cacheWeather(weather);
      // print('Weather saved to SQLite');
      return Right(weather);
    } on NetworkException {
      final cachedWeather = await localDataSource.getCachedWeather();

      if (cachedWeather != null) {
        // print('Cached weather found');
        return Right(cachedWeather);
      }
      //  print('No cached weather found');
      return Left(const NetworkFailure());
    } on ServerException {
      // print(' ServerException');
      return Left(const ServerFailure());
    }
  }
}
