import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'weather_icon.dart';

class DailyForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const DailyForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecast.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = forecast[index];

        return Card(
          color: Colors.grey.withAlpha(60),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            leading: WeatherIcon(iconCode: item.iconCode, size: 50),
            title: Text(
              DateFormat("EEEE").format(DateTime.parse(item.dateTime)),
            ),
            subtitle: Text(item.weatherMain),
            trailing: Text(
              "${item.temperature.round()}°",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        );
      },
    );
  }
}
