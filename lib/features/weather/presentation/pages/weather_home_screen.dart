import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_colors.dart';
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
    final bloc = context.read<HomeBloc>();
    if (bloc.state is! HomeLoaded) {
      bloc.add(AppStarted());
    }
  }

  List<Color> _getWeatherGradient(HomeState state, bool isDark) {
    if (state is HomeLoaded) {
      return AppColors.getWeatherGradient(state.weather.weatherMain, isDark);
    }
    return isDark ? AppColors.defaultNightGradient : AppColors.defaultDayGradient;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final gradientColors = _getWeatherGradient(state, isDark);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(
              builder: (context) {
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
          ),
        );
      },
    );
  }
}
