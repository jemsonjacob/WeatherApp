import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';
import 'package:weather/features/weather/domain/repository/weather_repository.dart';

class GetCurrentWeatherUseCase implements UseCase<Weather, String> {
  final WeatherRepository repository;
  GetCurrentWeatherUseCase({required this.repository});

  @override
  Future<Either<Failure, Weather>> call(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}

class GetLocationUseCase {
  final WeatherRepository repository;
  GetLocationUseCase(this.repository);

  Future<Position> call() {
    return repository.getCurrentLocation();
  }
}
