import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/forecast/domain/entities/forecast.dart';
import 'package:weather/features/home/presentation/home_bloc/home_bloc.dart';
import 'package:weather/features/weather/presentation/widgets/weather_info.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blue.shade100, body: _buildBody());
  }

  Widget _buildBody() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoaded) {
          final dailyForecast = getDailyForecast(state.forecast);

          return Padding(
            padding: EdgeInsets.all(12),
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(style: BorderStyle.none),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.weather.cityName,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          state.weather.country,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.grey,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
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
                          ],
                        ),

                        Text(
                          state.weather.weatherMain,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: weatherInfo(
                        icon: Icons.water_drop,
                        title: "Humidity",
                        value: "${state.weather.humidity}%",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: weatherInfo(
                        icon: Icons.emoji_emotions_outlined,
                        title: "Feels Like",
                        value:
                            "${state.weather.feelsLike.toStringAsFixed(0)}°C",
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                const Text(
                  "Hourly Forecast",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final forecast = state.forecast[index];
                      // print(state.forecast.length);

                      return Container(
                        width: 90,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              forecast.dateTime.substring(11, 16), // HH:mm
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Image.network(
                              "https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png",
                              width: 40,
                            ),

                            Text(
                              "${forecast.temperature.round()}°",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "5-Day Forecast",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyForecast.length,
                  itemBuilder: (context, index) {
                    final forecast = dailyForecast[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Image.network(
                          "https://openweathermap.org/img/wn/${forecast.iconCode}.png",
                        ),

                        title: Text(forecast.dateTime.substring(0, 10)),

                        subtitle: Text(forecast.weatherMain),

                        trailing: Text(
                          "${forecast.temperature.round()}°",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        if (state is LocationPermissionDenied) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 80),

                  Text(
                    "Location permission required, turn on location in your phone's settings",
                  ),

                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(AppStarted());
                    },
                    child: Text("Grant Permission"),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("Loading weather..."));
      },
    );
  }
}

List<Forecast> getDailyForecast(List<Forecast> forecasts) {
  final List<Forecast> daily = [];

  for (final item in forecasts) {
    if (item.dateTime.contains("12:00:00")) {
      daily.add(item);
    }
  }

  return daily;
}
