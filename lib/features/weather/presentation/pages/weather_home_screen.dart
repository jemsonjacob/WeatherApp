import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'package:weather/features/weather/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:weather/features/weather/presentation/widgets/error_widget.dart';
import 'package:weather/features/weather/presentation/widgets/loading_widget.dart';
import 'package:weather/features/weather/presentation/widgets/permission_denied_widget.dart';
import 'package:weather/features/weather/presentation/widgets/weather_content.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeLoading():
              return const LoadingWidget();

            case HomeLoaded():
              return WeatherContent(state: state);

            case LocationPermissionDenied():
              return const PermissionDeniedWidget();

            case HomeError():
              return ErrorMessageWidget(message: state.message);

            default:
              return const LoadingWidget();
          }
        },
      ),
    );
  }
}

List<Forecast> getDailyForecast(List<Forecast> forecasts) {
  final List<Forecast> daily = [];

  for (final item in forecasts) {
    if (item.dateTime.contains("12:00:00")) {
      daily.add(item);
    }
  }

  return daily;
}
