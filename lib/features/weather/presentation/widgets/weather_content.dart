import 'package:flutter/material.dart';
import 'package:weather/core/utils/forecast_helper.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';

import '../bloc/home_bloc/home_bloc.dart';

import 'current_weather_card.dart';
import 'daily_forecast_list.dart';
import 'hourly_forecast_list.dart';
import 'weather_header.dart';
import 'weather_info_grid.dart';

class WeatherContent extends StatelessWidget {
  final HomeLoaded state;

  const WeatherContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final List<Forecast> dailyForecast = ForecastHelper.getDailyForecast(
      state.forecast,
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        children: [
          WeatherHeader(weather: state.weather),
          const SizedBox(height: 18),
          CurrentWeatherCard(weather: state.weather),
          const SizedBox(height: 18),
          WeatherInfoGrid(weather: state.weather),
          const SizedBox(height: 24),
          const Text(
            "Hourly Forecast",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),
          HourlyForecastList(forecast: state.forecast),
          const SizedBox(height: 24),
          const Text(
            "5-Day Forecast",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),
          DailyForecastList(forecast: dailyForecast),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
