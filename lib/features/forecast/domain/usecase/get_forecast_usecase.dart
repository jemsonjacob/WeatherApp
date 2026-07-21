// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'package:weather/features/forecast/domain/repositories/forecast_repository.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';

class GetForecastUseCase implements UseCase<List<Forecast>, String> {
  final ForecastRepository repository;
  GetForecastUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Forecast>>> call(String cityName) {
    return repository.getCurrentForecast(cityName);
  }
}

class GetLocationUseCase {
  final ForecastRepository repository;
  GetLocationUseCase(this.repository);

  Future<Position> call() {
    return repository.getCurrentLocation();
  }
}
