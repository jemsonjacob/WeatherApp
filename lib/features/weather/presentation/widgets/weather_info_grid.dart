import 'package:flutter/material.dart';
import 'package:weather/features/weather/presentation/widgets/weather_info_card.dart';

import '../../domain/entities/weather.dart';

class WeatherInfoGrid extends StatelessWidget {
  final Weather weather;

  const WeatherInfoGrid({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.water_drop,
                title: "Humidity",
                value: "${weather.humidity}%",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.thermostat,
                title: "Feels Like",
                value: "${weather.feelsLike.round()}°C",
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.air,
                title: "Wind",
                value: "${weather.windSpeed} m/s",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.cloud,
                title: "Condition",
                value: weather.weatherMain,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
