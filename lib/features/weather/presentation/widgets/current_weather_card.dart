import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';
import 'weather_icon.dart';

class CurrentWeatherCard extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withAlpha(30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            WeatherIcon(iconCode: weather.iconCode, size: 120),
            const SizedBox(height: 15),
            Text(
              "${weather.temperature.round()}°",
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(weather.weatherMain, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
