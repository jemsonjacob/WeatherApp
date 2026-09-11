import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'weather_glass_container.dart';
import 'weather_icon.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const HourlyForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: forecast.isEmpty
          ? const WeatherContainer(
              child: Center(
                child: Text(
                  'Connect to the internet to view the forecast.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.take(12).length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = forecast[index];
                final isNow = index == 0;

                return WeatherContainer(
                  borderRadius: 24,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  color: isNow
                      ? Colors.white.withValues(alpha: 0.32)
                      : Colors.white.withValues(alpha: 0.16),
                  border: Border.all(
                    color: isNow
                        ? Colors.white.withValues(alpha: 0.75)
                        : Colors.white.withValues(alpha: 0.25),
                    width: isNow ? 2.0 : 1.2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        isNow
                            ? "Now"
                            : DateFormat.j().format(
                                DateTime.parse(item.dateTime),
                              ),
                        style: TextStyle(
                          fontWeight: isNow ? FontWeight.bold : FontWeight.w600,
                          fontSize: 13,
                          color: isNow
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      WeatherIcon(iconCode: item.iconCode, size: 48),
                      Text(
                        "${item.temperature.round()}°",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
