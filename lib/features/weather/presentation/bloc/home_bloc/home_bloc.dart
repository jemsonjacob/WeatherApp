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
    final currentState = state;

    if (currentState is! HomeLoaded) {
      emit(HomeLoading());
    }

    try {
      // Get current location
      final position = await getLocationUseCase();

      if (currentState is HomeLoaded) {
        // If loc got changed
        final isLocationChanged = currentState.weather.cityName.isEmpty;
        if (isLocationChanged) {
          emit(HomeLoading());
        }
      }

      //current weather
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
        if (currentState is HomeLoaded) {
          // Keep displaying current weather if fetch fails while refreshing
          return;
        }

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
          // Weather from db
          if (weather != null) {
            emit(HomeLoaded(weather: weather!, forecast: const []));
            return;
          }

          if (currentState is! HomeLoaded) {
            emit(const HomeError(message: "No Internet Connection"));
          }
          return;
        }

        if (currentState is! HomeLoaded) {
          if (forecastFailure is ServerFailure) {
            emit(const HomeError(message: "Server Error"));
          } else {
            emit(const HomeError(message: "Something went wrong"));
          }
        }
        return;
      }

      // If location changed from previous loaded weather, emit loading
      if (currentState is HomeLoaded &&
          currentState.weather.cityName.isNotEmpty &&
          weather != null &&
          currentState.weather.cityName.toLowerCase() !=
              weather!.cityName.toLowerCase()) {
        emit(HomeLoading());
      }

      // Both succeeded
      emit(HomeLoaded(weather: weather!, forecast: forecasts!));
    } catch (e) {
      debugPrint(e.toString());
      if (currentState is! HomeLoaded) {
        emit(LocationPermissionDenied());
      }
    }
  }
}
