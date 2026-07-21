import 'package:dartz/dartz.dart';
import 'package:weather/core/usecase/coordinates.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'package:weather/features/forecast/domain/repositories/forecast_repository.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';

class GetForecastByCoordinatesUseCase
    implements UseCase<List<Forecast>, CoordinatesParams> {
  final ForecastRepository repository;

  GetForecastByCoordinatesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Forecast>>> call(CoordinatesParams params) {
    return repository.getForecastByCoordinates(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}
