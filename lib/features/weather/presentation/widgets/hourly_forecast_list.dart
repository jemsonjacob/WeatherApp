import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';

import 'weather_icon.dart';

class HourlyForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const HourlyForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.take(8).length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = forecast[index];

          return Container(
            width: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  DateFormat.Hm().format(DateTime.parse(item.dateTime)),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                WeatherIcon(iconCode: item.iconCode, size: 45),

                Text(
                  "${item.temperature.round()}°",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
