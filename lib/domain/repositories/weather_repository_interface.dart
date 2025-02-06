import 'package:weather_app/domain/entities/city_entity.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';

abstract class WeatherRepositoryInterface {
  // Retrieve weather data for the given city name
  Future<WeatherEntity> getWeather(
    double lat,
    double lon,
  );

  // Get city coordinates using the city name
  Future<CityEntity> getCityCoordinates(String cityName);

  // 5-day forecast
  Future<ForecastEntity> getForecast(double lat, double lon);
}
