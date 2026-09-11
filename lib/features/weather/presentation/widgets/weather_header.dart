import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather.dart';
import 'weather_glass_container.dart';

class WeatherHeader extends StatelessWidget {
  final Weather weather;

  const WeatherHeader({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("EEEE, MMMM d").format(DateTime.now());

    return WeatherContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "${weather.cityName}, ${weather.country}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wb_sunny_rounded,
              color: Colors.amberAccent,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
