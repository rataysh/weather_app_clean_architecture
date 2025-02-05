import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/domain/entities/city_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';
import 'package:weather_app/domain/usecases/get_city_coordinates_usecase.dart';

// Mock class for WeatherRepositoryInterface
class MockWeatherRepository extends Mock
    implements WeatherRepositoryInterface {}

void main() {
  group('GetCityCoordinatesUseCase Tests', () {
    late GetCityCoordinatesUseCase useCase;
    late MockWeatherRepository mockRepository;

    setUp(() {
      mockRepository = MockWeatherRepository();
      useCase = GetCityCoordinatesUseCase(mockRepository);
    });

    test('should return CityEntity when repository call is successful',
        () async {
      // Arrange
      const testCityName = 'Berlin';
      final cityEntity = CityEntity(
        name: testCityName,
        lat: 52.5200,
        lon: 13.4050,
      );

      // Mock the repository to return a CityEntity
      when(() => mockRepository.getCityCoordinates(testCityName))
          .thenAnswer((_) async => cityEntity);

      // Act
      final result = await useCase.call(testCityName);

      // Assert
      expect(result, isA<CityEntity>());
      expect(result.name, equals(testCityName));
      verify(() => mockRepository.getCityCoordinates(testCityName)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
