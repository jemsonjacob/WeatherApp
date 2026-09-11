import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/theme/app_colors.dart';
import 'package:weather/features/weather/presentation/bloc/search_bloc/search_weather_bloc.dart';
import 'package:weather/features/weather/presentation/widgets/weather_glass_container.dart';
import 'package:weather/features/weather/presentation/widgets/weather_icon.dart';
import 'package:weather/features/weather/presentation/widgets/weather_info_card.dart';

class WeatherSearchScreen extends StatefulWidget {
  const WeatherSearchScreen({super.key});

  @override
  State<WeatherSearchScreen> createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  final TextEditingController _cityController = TextEditingController();

  final List<String> _quickCities = [
    "London",
    "New York",
    "Tokyo",
    "Paris",
    "Sydney",
    "Dubai",
  ];

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchCity([String? cityName]) {
    final city = cityName ?? _cityController.text.trim();
    if (city.isEmpty) return;

    if (cityName != null) {
      _cityController.text = cityName;
    }

    context.read<SearchWeatherBloc>().add(SearchCityEvent(city));
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? AppColors.defaultNightGradient
              : AppColors.defaultDayGradient,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherContainer(
                  borderRadius: 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _cityController,
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          onSubmitted: (_) => _searchCity(),
                          decoration: InputDecoration(
                            hintText: "Search city...",
                            hintStyle: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => _searchCity(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _quickCities.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final city = _quickCities[index];
                      return GestureDetector(
                        onTap: () => _searchCity(city),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              city,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
                    builder: (context, state) {
                      if (state is SearchWeatherLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (state is SearchWeatherError) {
                        return Center(
                          child: WeatherContainer(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline_rounded,
                                  size: 48,
                                  color: Colors.white70,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (state is SearchWeatherLoaded) {
                        final weather = state.weather;

                        return ListView(
                          children: [
                            WeatherContainer(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Text(
                                    weather.cityName,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    weather.country,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  WeatherIcon(
                                    iconCode: weather.iconCode,
                                    size: 110,
                                  ),
                                  Text(
                                    "${weather.temperature.round()}°C",
                                    style: const TextStyle(
                                      fontSize: 64,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      weather.weatherMain,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: WeatherInfoCard(
                                    icon: Icons.water_drop_rounded,
                                    iconColor: Colors.lightBlueAccent,
                                    title: "Humidity",
                                    value: "${weather.humidity}%",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: WeatherInfoCard(
                                    icon: Icons.air_rounded,
                                    iconColor: Colors.cyanAccent,
                                    title: "Wind",
                                    value: "${weather.windSpeed} m/s",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: WeatherInfoCard(
                                    icon: Icons.thermostat_rounded,
                                    iconColor: Colors.orangeAccent,
                                    title: "Feels Like",
                                    value: "${weather.feelsLike.round()}°C",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }

                      return Center(
                        child: WeatherContainer(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.location_city_rounded,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Search for a city",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Enter a city name or select a quick option above.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
