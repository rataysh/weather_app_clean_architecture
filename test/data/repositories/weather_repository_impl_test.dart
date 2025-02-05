import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/datasources/remote/weather_api_service.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/entities/city_entity.dart';

class MockWeatherApiService extends Mock implements WeatherApiService {
  @override
  Future<Map<String, dynamic>> fetchCityData(String cityName) {
    return super.noSuchMethod(
      Invocation.method(#fetchCityData, [cityName]),
      returnValue: Future.value(<String, dynamic>{}),
      returnValueForMissingStub: Future.value(<String, dynamic>{}),
    );
  }
}

void main() {
  group('WeatherRepositoryImpl Tests', () {
    test('getCityCoordinates should return CityEntity from fetchCityData',
        () async {
      // Arrange
      final mockApiService = MockWeatherApiService();
      final repository = WeatherRepositoryImpl(apiService: mockApiService);

      const testCity = 'Berlin';
      final mockResponse = {
        'name': testCity,
        'lat': 52.52,
        'lon': 13.405,
      };

      when(mockApiService.fetchCityData(testCity))
          .thenAnswer((_) async => mockResponse);

      // Act
      final cityEntity = await repository.getCityCoordinates(testCity);

      // Assert
      verify(mockApiService.fetchCityData(testCity)).called(1);
      expect(cityEntity, isA<CityEntity>());
      expect(cityEntity.name, testCity);
      expect(cityEntity.lat, 52.52);
      expect(cityEntity.lon, 13.405);
    });
  });
}
