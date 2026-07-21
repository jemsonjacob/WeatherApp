part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Weather weather;
  final List<Forecast> forecast;

  const HomeLoaded({required this.weather, required this.forecast});

  @override
  List<Object?> get props => [weather, forecast];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocationPermissionDenied extends HomeState {}
