import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/search_bloc/search_weather_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _cityController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search city...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  final city = _cityController.text.trim();

                  if (city.isEmpty) return;

                  context.read<SearchWeatherBloc>().add(
                    SearchCityEvent(_cityController.text.trim()),
                  );
                },
              ),
              SizedBox(height: 5),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchWeatherBloc, SearchWeatherState>(
      builder: (context, state) {
        if (state is SearchWeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchWeatherLoaded) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.grey,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            state.weather.cityName,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            state.weather.country,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            ),
                          ),

                          const SizedBox(height: 20),
                          Image.network(
                            "https://openweathermap.org/img/wn/${state.weather.iconCode}@4x.png",
                            width: 120,
                          ),
                          Text(
                            "${state.weather.temperature.toStringAsFixed(0)}°",
                            style: const TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            state.weather.weatherMain,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherInfoCard(
                      icon: Icons.water_drop,
                      title: "Humidity",
                      value: "${state.weather.humidity}%",
                    ),
                    const SizedBox(width: 2),
                    WeatherInfoCard(
                      icon: Icons.air,
                      title: "Wind",
                      value: "${state.weather.windSpeed}ms",
                    ),
                    const SizedBox(width: 2),
                    WeatherInfoCard(
                      icon: Icons.emoji_emotions_outlined,
                      title: "Feels Like",
                      value: "${state.weather.feelsLike}%",
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is SearchWeatherError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("Search for a city"));
      },
    );
  }
}
