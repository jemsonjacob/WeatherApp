import 'package:weather/features/forecast/domain/entities/forecast.dart';

class ForecastHelper {
  ForecastHelper._();

  static List<Forecast> getDailyForecast(List<Forecast> forecasts) {
    return forecasts
        .where((forecast) => forecast.dateTime.contains("12:00:00"))
        .toList();
  }
}
