import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryBlue = Color(0xFF3B82F6);
  static const accentCyan = Color(0xFF06B6D4);
  static const primaryOrange = Color(0xFFF97316);
  static const secondaryOrange = Color(0xFFFB923C);

  static const lightBackground = Color(0xFFF0F4F8);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightText = Color(0xFF0F172A);
  static const lightSubtext = Color(0xFF64748B);

  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkText = Color(0xFFF8FAFC);
  static const darkSubtext = Color(0xFF94A3B8);
  //icon color
  static const humidityIcon = Colors.lightBlueAccent;
  static const feelsLikeIcon = Colors.orangeAccent;
  static const windIcon = Colors.cyanAccent;
  static const conditionIcon = Colors.amberAccent;

  static final lightGlassBackground = Colors.white.withValues(alpha: 0.20);
  static final lightGlassBorder = Colors.white.withValues(alpha: 0.40);
  static final darkGlassBackground = Colors.black.withValues(alpha: 0.25);
  static final darkGlassBorder = Colors.white.withValues(alpha: 0.12);

  static const clearSkyDayGradient = [
    Color(0xFF1E3C72),
    Color(0xFF2A5298),
    Color(0xFF6DD5FA),
  ];

  static const clearSkyNightGradient = [
    Color(0xFF0F2027),
    Color(0xFF203A43),
    Color(0xFF2C5364),
  ];

  static const rainGradient = [
    Color(0xFF1F2937),
    Color(0xFF374151),
    Color(0xFF4B5563),
  ];

  static const cloudsDayGradient = [
    Color(0xFF3B82F6),
    Color(0xFF60A5FA),
    Color(0xFF93C5FD),
  ];

  static const cloudsNightGradient = [
    Color(0xFF111827),
    Color(0xFF1F2937),
    Color(0xFF374151),
  ];

  static const thunderGradient = [
    Color(0xFF0F172A),
    Color(0xFF1E1B4B),
    Color(0xFF312E81),
  ];

  static const snowGradient = [
    Color(0xFF1E293B),
    Color(0xFF334155),
    Color(0xFF64748B),
  ];

  static const defaultDayGradient = [Color(0xFF1E3C72), Color(0xFF2A5298)];

  static const defaultNightGradient = [Color(0xFF0F172A), Color(0xFF1E293B)];

  /// Returns dynamic background gradient based on weather condition & dark mode setting.
  static List<Color> getWeatherGradient(String weatherCondition, bool isDark) {
    final condition = weatherCondition.toLowerCase();

    if (condition.contains('clear') || condition.contains('sun')) {
      return isDark ? clearSkyNightGradient : clearSkyDayGradient;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return rainGradient;
    } else if (condition.contains('cloud')) {
      return isDark ? cloudsNightGradient : cloudsDayGradient;
    } else if (condition.contains('thunder')) {
      return thunderGradient;
    } else if (condition.contains('snow')) {
      return snowGradient;
    }

    return isDark ? defaultNightGradient : defaultDayGradient;
  }
}
