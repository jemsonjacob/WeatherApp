import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/db_helper/db_helper.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/core/theme/theme_cubit.dart';
import 'package:weather/features/forecast/data/datasource/forecast_remote_datasource.dart';
import 'package:weather/features/forecast/data/repositories/forecast_repository_impl.dart';
import 'package:weather/features/forecast/domain/repositories/forecast_repository.dart';
import 'package:weather/features/forecast/domain/usecase/get_forecast_bycoordinate_usecase.dart';
import 'package:weather/features/weather/data/datasource/remote/weather_local_datasource.dart';
import 'package:weather/features/weather/data/datasource/remote/weather_remote_datasource.dart';
import 'package:weather/features/weather/data/repository_impli/weather_repository_impli.dart';
import 'package:weather/features/weather/domain/repository/weather_repository.dart';
import 'package:weather/features/weather/domain/usecases/get_weather_by_coordinates_usecase.dart';
import 'package:weather/features/weather/domain/usecases/get_weather_by_search_usecase.dart';
import 'package:weather/features/weather/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/search_bloc/search_weather_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //register dio
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  //db helper
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  sl.registerSingleton<LocationService>(LocationService());

  sl.registerSingleton<Dio>(dio);
  //register datasource
  sl.registerSingleton<WeatherRemoteDataSource>(
    WeatherRemoteDataSourceImpl(dio: sl()),
  );

  //local datasource
  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(databaseHelper: sl()),
  );
  //register repository
  sl.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(
      remoteDataSource: sl(),
      locationService: sl(),
      localDataSource: sl(),
    ),
  );
  //register usecase
  sl.registerSingleton<GetCurrentWeatherUseCase>(
    GetCurrentWeatherUseCase(repository: sl()),
  );
  sl.registerSingleton<GetLocationUseCase>(GetLocationUseCase(sl()));
  sl.registerSingleton<GetWeatherByCoordinatesUseCase>(
    GetWeatherByCoordinatesUseCase(repository: sl()),
  );
  //register bloc
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl<GetLocationUseCase>(),
      sl<GetWeatherByCoordinatesUseCase>(),
      sl<GetForecastByCoordinatesUseCase>(),
    ),
  );

  sl.registerFactory<SearchWeatherBloc>(
    () => SearchWeatherBloc(sl<GetCurrentWeatherUseCase>()),
  );
  //register cubit
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // Forecast datasource
  sl.registerSingleton<ForecastRemoteDataSource>(
    ForecastRemoteDataSourceImpl(dio: sl()),
  );

  // Forecast repository
  sl.registerSingleton<ForecastRepository>(
    ForecastRepositoryImpl(remoteDataSource: sl(), locationService: sl()),
  );

  // Forecast use case
  sl.registerSingleton<GetForecastByCoordinatesUseCase>(
    GetForecastByCoordinatesUseCase(sl()),
  );
}
