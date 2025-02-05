import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';

void main() {
  group('WeatherCard Widget Tests', () {
    testWidgets('should display correct temperature and description',
        (WidgetTester tester) async {
      // Arrange
      final mockWeather = WeatherEntity(
        temperature: 25.5678,
        description: 'Clear sky',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherCard(weather: mockWeather),
          ),
        ),
      );

      // Assert
      // We check if the text containing "Temperature: 25.6 °C" is found
      expect(find.text('Temperature: 25.6 °C'), findsOneWidget);

      // We check if the text containing "Description: Clear sky" is found
      expect(find.text('Description: Clear sky'), findsOneWidget);
    });
  });
}
