import 'package:dartz/dartz.dart';
import 'package:weather/core/usecase/coordinates.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';
import 'package:weather/features/weather/domain/repository/weather_repository.dart';

class GetWeatherByCoordinatesUseCase
    implements UseCase<Weather, CoordinatesParams> {
  final WeatherRepository repository;

  GetWeatherByCoordinatesUseCase({required this.repository});

  @override
  Future<Either<Failure, Weather>> call(CoordinatesParams params) {
    return repository.getWeatherByCoordinates(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}
