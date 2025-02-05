import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/global_providers.dart';
import 'package:weather_app/presentation/home/home_page.dart';
import 'package:weather_app/presentation/home/home_page_provider.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/home/home_page_viewmodel.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';

void main() {
  group('HomePage Widget Tests', () {
    testWidgets(
        'should display text field, button, and app bar with history icon',
        (WidgetTester tester) async {
      // Arrange
      // Using a simple ProviderScope without overriding the provider
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            // We add routes to handle navigation for the test
            routes: {
              '/': (context) => const HomePage(),
              '/history': (context) =>
                  const Scaffold(body: Text('History Page')),
            },
          ),
        ),
      );

      // Act
      // Trigger a frame
      await tester.pump();

      // Assert
      // Check for AppBar Title
      expect(find.text('Weather App'), findsOneWidget);

      // Check for TextFormField
      expect(find.byType(TextFormField), findsOneWidget);

      // Check for ElevatedButton
      expect(
          find.widgetWithText(ElevatedButton, 'Get Weather'), findsOneWidget);

      // Check for IconButton with history icon
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('should show validation error if city input is empty',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const HomePage(),
          ),
        ),
      );

      // Act
      // Try to tap the "Get Weather" button without entering text
      await tester.tap(find.widgetWithText(ElevatedButton, 'Get Weather'));
      await tester.pump();

      // Assert
      // We expect an error text from the validator
      expect(find.text('City name cannot be empty'), findsOneWidget);
    });

    testWidgets(
        'should display CircularProgressIndicator when isLoading is true',
        (WidgetTester tester) async {
      // Arrange
      // We override the provider's state to set isLoading = true
      final testHomeState = HomePageState(
        isLoading: true,
        weather: null,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homePageProvider.overrideWith(
                (ref) => HomePageViewModel(
                      getCityCoordinatesUseCase: ref.watch(getCityCoordinatesUseCaseProvider),
                      getWeatherUseCase: ref.watch(getWeatherUseCaseProvider),
                      saveSearchHistoryUseCase: ref.watch(saveSearchHistoryUseCaseProvider),
                    )..state = testHomeState),
          ],
          child: MaterialApp(
            home: const HomePage(),
          ),
        ),
      );

      // Act
      // Trigger UI rebuild
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display WeatherCard when weather is not null',
        (WidgetTester tester) async {
      // Arrange
      final testHomeState = HomePageState(
        isLoading: false,
        weather: WeatherEntity(
          temperature: 20.0,
          description: 'Cloudy',
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homePageProvider.overrideWith(
                (ref) => HomePageViewModel(
                      getCityCoordinatesUseCase: ref.watch(getCityCoordinatesUseCaseProvider),
                      getWeatherUseCase: ref.watch(getWeatherUseCaseProvider),
                      saveSearchHistoryUseCase: ref.watch(saveSearchHistoryUseCaseProvider),
                    )..state = testHomeState),
          ],
          child: MaterialApp(
            home: const HomePage(),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      // Verify that WeatherCard is displayed
      expect(find.byType(WeatherCard), findsOneWidget);

      // Check specific text
      expect(find.text('Temperature: 20.0 °C'), findsOneWidget);
      expect(find.text('Description: Cloudy'), findsOneWidget);
    });

    testWidgets('should navigate to history page when history icon is tapped',
        (WidgetTester tester) async {
      // Arrange
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) =>
                const Scaffold(body: Text('History Page')),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle(); 
      // Assert
      expect(find.text('History Page'), findsOneWidget);
    });
  });
}
