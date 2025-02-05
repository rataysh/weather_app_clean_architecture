import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/config.dart';
import 'package:weather_app/data/datasources/remote/weather_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MockDio extends Mock implements Dio {}

void main() {
  setUpAll(() async {
    // Register fallback values if needed
    registerFallbackValue(RequestOptions(path: ''));
    // Load environment variables
    await dotenv.load(fileName: ".env");
  });

  group('WeatherApiService Tests', () {
    late WeatherApiService service;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      service = WeatherApiService(dio: mockDio);
    });

    test('should fetch city data correctly', () async {
      // Arrange
      const cityName = 'Berlin';
      final responseData = [
        {
          'name': 'Berlin',
          'lat': 52.5200,
          'lon': 13.4050,
        }
      ];

      // Mocking dio.get()
      when(() => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await service.fetchCityData(cityName);

      // Assert
      expect(result['name'], equals('Berlin'));
      expect(result['lat'], equals(52.5200));
      expect(result['lon'], equals(13.4050));

      verify(() => mockDio.get(
            'http://api.openweathermap.org/geo/1.0/direct',
            queryParameters: {
              'q': cityName,
              'limit': 1,
              'appid': AppConfig.openWeatherMapApiKey,
            },
          )).called(1);
    });
  });
}
