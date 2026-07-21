import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class LocationFailure extends Failure {
  const LocationFailure();
}

class CityNotFoundFailure extends Failure {
  const CityNotFoundFailure();
}
