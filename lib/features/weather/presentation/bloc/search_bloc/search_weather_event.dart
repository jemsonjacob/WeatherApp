part of 'search_weather_bloc.dart';

abstract class SearchWeatherEvent extends Equatable {
  const SearchWeatherEvent();

  @override
  List<Object> get props => [];
}

class SearchCityEvent extends SearchWeatherEvent {
  final String cityName;

  const SearchCityEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}
