part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends HomeEvent {}

class RefreshCurrentLocation extends HomeEvent {}
