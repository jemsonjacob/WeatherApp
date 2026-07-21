import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/domain/failures/failures.dart';
import 'package:weather/features/weather/domain/usecases/get_weather_by_search_usecase.dart';

part 'search_weather_event.dart';
part 'search_weather_state.dart';

class SearchWeatherBloc extends Bloc<SearchWeatherEvent, SearchWeatherState> {
  SearchWeatherBloc(this.getCurrentWeatherUseCase)
    : super(SearchWeatherInitial()) {
    //dependencies

    on<SearchCityEvent>(_onGetWeather);
  }
  //inject usecase
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  //getwether
  Future<void> _onGetWeather(
    SearchCityEvent event,
    Emitter<SearchWeatherState> emit,
  ) async {
    //emit loading state first
    emit(SearchWeatherLoading());

    final result = await getCurrentWeatherUseCase(event.cityName);
    result.fold(
      (failure) {
        if (failure is CityNotFoundFailure) {
          emit(const SearchWeatherError(message: "City not found"));
        } else if (failure is NetworkFailure) {
          emit(const SearchWeatherError(message: "No Internet Connection"));
        } else if (failure is ServerFailure) {
          emit(const SearchWeatherError(message: "Server Error"));
        } else {
          emit(const SearchWeatherError(message: "Something went wrong"));
        }
      },
      (weather) {
        emit(SearchWeatherLoaded(weather));
      },
    );
  }
}
