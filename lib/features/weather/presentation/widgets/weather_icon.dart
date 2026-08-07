import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String iconCode;
  final double size;

  const WeatherIcon({super.key, required this.iconCode, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://openweathermap.org/img/wn/$iconCode@4x.png",
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.cloud, size: size);
      },
    );
  }
}
