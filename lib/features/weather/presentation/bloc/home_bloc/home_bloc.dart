import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/usecase/coordinates.dart';

import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';

import 'package:weather/features/weather/domain/failures/failures.dart';
import 'package:weather/features/weather/domain/usecases/get_weather_by_coordinates_usecase.dart';
import 'package:weather/features/forecast/domain/usecase/get_forecast_bycoordinate_usecase.dart';
import 'package:weather/features/weather/domain/usecases/get_weather_by_search_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLocationUseCase getLocationUseCase;
  final GetWeatherByCoordinatesUseCase getWeatherByCoordinatesUseCase;
  final GetForecastByCoordinatesUseCase getForecastByCoordinatesUseCase;

  HomeBloc(
    this.getLocationUseCase,
    this.getWeatherByCoordinatesUseCase,
    this.getForecastByCoordinatesUseCase,
  ) : super(HomeInitial()) {
    on<AppStarted>(_loadCurrentLocationWeather);
    on<RefreshCurrentLocation>(_loadCurrentLocationWeather);
  }

  Future<void> _loadCurrentLocationWeather(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      // Get current location
      final position = await getLocationUseCase();

      // Fetch current weather
      final weatherResult = await getWeatherByCoordinatesUseCase(
        CoordinatesParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );

      // Fetch forecast
      final forecastResult = await getForecastByCoordinatesUseCase(
        CoordinatesParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );

      Weather? weather;
      List<Forecast>? forecasts;

      // Handle weather result
      final weatherFailure = weatherResult.fold<Failure?>(
        (failure) => failure,
        (value) {
          weather = value;
          return null;
        },
      );

      if (weatherFailure != null) {
        if (weatherFailure is NetworkFailure) {
          emit(const HomeError(message: "No Internet Connection"));
        } else if (weatherFailure is ServerFailure) {
          emit(const HomeError(message: "Server Error"));
        } else {
          emit(const HomeError(message: "Something went wrong"));
        }
        return;
      }

      // Handle forecast result
      final forecastFailure = forecastResult.fold<Failure?>(
        (failure) => failure,
        (value) {
          forecasts = value;
          return null;
        },
      );

      if (forecastFailure != null) {
        if (forecastFailure is NetworkFailure) {
          emit(const HomeError(message: "No Internet Connection"));
        } else if (forecastFailure is ServerFailure) {
          emit(const HomeError(message: "Server Error"));
        } else {
          emit(const HomeError(message: "Something went wrong"));
        }
        return;
      }

      // Both succeeded
      emit(HomeLoaded(weather: weather!, forecast: forecasts!));
    } catch (e) {
      debugPrint(e.toString());
      emit(LocationPermissionDenied());
    }
  }
}
