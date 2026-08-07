import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/features/weather/presentation/bloc/search_bloc/search_weather_bloc.dart';
import 'package:weather/features/weather/presentation/widgets/weather_icon.dart';
import 'package:weather/features/weather/presentation/widgets/weather_info_card.dart';

class WeatherSearchScreen extends StatefulWidget {
  const WeatherSearchScreen({super.key});

  @override
  State<WeatherSearchScreen> createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchCity() {
    final city = _cityController.text.trim();

    if (city.isEmpty) return;

    context.read<SearchWeatherBloc>().add(SearchCityEvent(city));

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _searchCity(),
                decoration: InputDecoration(
                  hintText: "Search city...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _searchCity,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
                  builder: (context, state) {
                    if (state is SearchWeatherLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchWeatherError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: theme.textTheme.titleMedium,
                        ),
                      );
                    }

                    if (state is SearchWeatherLoaded) {
                      final weather = state.weather;

                      return ListView(
                        children: [
                          Card(
                            elevation: 4,
                            color: theme.colorScheme.surfaceContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Text(
                                    weather.cityName,
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    weather.country,
                                    style: theme.textTheme.bodyLarge,
                                  ),

                                  const SizedBox(height: 20),

                                  WeatherIcon(
                                    iconCode: weather.iconCode,
                                    size: 120,
                                  ),

                                  Text(
                                    "${weather.temperature.round()}°",
                                    style: theme.textTheme.displayLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),

                                  Text(
                                    weather.weatherMain,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

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
                                  icon: Icons.air,
                                  title: "Wind",
                                  value: "${weather.windSpeed} m/s",
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: WeatherInfoCard(
                                  icon: Icons.thermostat,
                                  title: "Feels Like",
                                  value: "${weather.feelsLike.round()}°",
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 90,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Search for a city",
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Enter a city name to view weather information.",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
