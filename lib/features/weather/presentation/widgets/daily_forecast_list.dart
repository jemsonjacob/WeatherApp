import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/theme/app_colors.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'weather_glass_container.dart';
import 'weather_icon.dart';

class DailyForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const DailyForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    if (forecast.isEmpty) {
      return const WeatherContainer(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Connect to the internet to view the forecast.',
            style: TextStyle(color: AppColors.lightBackground),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecast.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = forecast[index];
        final date = DateTime.parse(item.dateTime);
        final isToday = index == 0;
        final dayName = isToday ? "Today" : DateFormat("EEEE").format(date);

        return WeatherContainer(
          borderRadius: 20,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              WeatherIcon(iconCode: item.iconCode, size: 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.weatherMain,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.lightBackground.withValues(
                          alpha: 0.75,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightBackground.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "${item.temperature.round()}°C",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.lightBackground,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
