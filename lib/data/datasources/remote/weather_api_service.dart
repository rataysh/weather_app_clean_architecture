import 'package:weather_app/core/config.dart';
import 'package:weather_app/data/services/api_service.dart';

class WeatherApiService extends ApiService {
  WeatherApiService({super.dio});

  /// Fetch current city data using cityName
  ///
  Future<dynamic> fetchCityData(String cityName) async {
    const String url = 'http://api.openweathermap.org/geo/1.0/direct';
    final queryParameters = {
      'q': cityName,
      'limit': 1,
      'appid': AppConfig.openWeatherMapApiKey,
    };
    final rawData = await getRequest(url, queryParameters: queryParameters);
    return rawData[0];
  }

  /// Fetch current weather data using latitude and longitude
  ///
  Future<dynamic> fetchWeatherData({
    required double lat,
    required double lon,
  }) async {
    const String url = 'https://api.openweathermap.org/data/2.5/weather';
    final queryParameters = {
      'lat': lat,
      'lon': lon,
      'appid': AppConfig.openWeatherMapApiKey,
      'units': 'metric',
    };
    final rawData = await getRequest(url, queryParameters: queryParameters);
    return rawData;
  }
}
