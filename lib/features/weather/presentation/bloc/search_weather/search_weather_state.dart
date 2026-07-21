// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_weather_bloc.dart';

abstract class SearchWeatherState extends Equatable {
  const SearchWeatherState();

  @override
  List<Object> get props => [];
}

class SearchWeatherInitial extends SearchWeatherState {}

class SearchWeatherLoading extends SearchWeatherState {}

class SearchWeatherLoaded extends SearchWeatherState {
  final Weather weather;

  const SearchWeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class SearchWeatherError extends SearchWeatherState {
  final String message;
  const SearchWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
