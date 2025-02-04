import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get openWeatherMapApiKey {
    return dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';
  }
}
