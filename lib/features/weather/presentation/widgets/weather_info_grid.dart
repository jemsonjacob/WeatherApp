import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_colors.dart';
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
                icon: Icons.water_drop_rounded,
                iconColor: AppColors.humidityIcon,
                title: "Humidity",
                value: "${weather.humidity}%",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.thermostat_rounded,
                iconColor: AppColors.feelsLikeIcon,
                title: "Feels Like",
                value: "${weather.feelsLike.round()}°C",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.air_rounded,
                iconColor: AppColors.windIcon,
                title: "Wind",
                value: "${weather.windSpeed} m/s",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WeatherInfoCard(
                icon: Icons.cloud_rounded,
                iconColor: AppColors.conditionIcon,
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
