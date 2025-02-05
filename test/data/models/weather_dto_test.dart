import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/weather_dto.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';

void main() {
  group('WeatherDTO Tests', () {
    test('fromMap should create valid WeatherDTO', () {
      // Arrange
      final mockMap = {
        'main': {'temp': 12.3},
        'weather': [
          {'description': 'Cloudy'}
        ],
        'name': 'Berlin'
      };

      // Act
      final dto = WeatherDTO.fromMap(mockMap);

      // Assert
      expect(dto.temperature, 12.3);
      expect(dto.description, 'Cloudy');
      expect(dto.cityName, 'Berlin');
    });

    test('toEntity should convert DTO to WeatherEntity', () {
      // Arrange
      final dto = WeatherDTO(
          temperature: 10.0, description: 'Sunny', cityName: 'Paris');

      // Act
      final entity = dto.toEntity();

      // Assert
      expect(entity, isA<WeatherEntity>());
      expect(entity.temperature, 10.0);
      expect(entity.description, 'Sunny');
      expect(entity.cityName, 'Paris');
    });
  });
}
