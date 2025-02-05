import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/city_input_validation.dart';

void main() {
  group('validateCityInput Tests', () {
    test('should return an error message if city is empty', () {
      // Arrange
      final emptyValue = '';

      // Act
      final result = validateCityInput(emptyValue);

      // Assert
      expect(result, 'City name cannot be empty');
    });

    test('should return an error message if city contains numbers', () {
      // Arrange
      final invalidValue = 'Berlin123';

      // Act
      final result = validateCityInput(invalidValue);

      // Assert
      expect(result, 'City name cannot contain numbers');
    });

    test('should return null if city is valid', () {
      // Arrange
      final validValue = 'Berlin';

      // Act
      final result = validateCityInput(validValue);

      // Assert
      expect(result, null);
    });
  });
}
