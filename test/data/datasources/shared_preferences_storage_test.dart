import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/datasources/local/shared_preferences_storage.dart';
import 'package:weather_app/data/models/search_history_dto.dart';

void main() {
  group('SharedPreferencesStorage Tests', () {
    late SharedPreferencesStorage storage;

    setUp(() {
      // Initialize mock SharedPreferences
      SharedPreferences.setMockInitialValues({});
      storage = SharedPreferencesStorage();
    });

    test(
        'should return an empty list when getSearchHistory is called and no data stored',
        () async {
      // Act
      final history = await storage.getSearchHistory();

      // Assert
      expect(history, isEmpty);
    });

    test('should save and retrieve search history correctly', () async {
      // Arrange
      final dto = SearchHistoryDTO(
        cityName: 'Berlin',
        searchTime: DateTime.now(),
        temperature: 2.5,
      );

      // Act
      await storage.saveSearchHistory(dto);
      final history = await storage.getSearchHistory();

      // Assert
      expect(history.length, 1);
      expect(history[0].cityName, 'Berlin');
      expect(history[0].temperature, 2.5);
    });

    test('should clear all search history', () async {
      // Arrange
      final dto1 = SearchHistoryDTO(
        cityName: 'Berlin',
        searchTime: DateTime.now(),
        temperature: 2.5,
      );
      final dto2 = SearchHistoryDTO(
        cityName: 'Munich',
        searchTime: DateTime.now(),
        temperature: 5.0,
      );
      await storage.saveSearchHistory(dto1);
      await storage.saveSearchHistory(dto2);

      // Ensure that 2 items exist
      final historyBeforeClear = await storage.getSearchHistory();
      expect(historyBeforeClear.length, 2);

      // Act
      await storage.clearSearchHistory();
      final historyAfterClear = await storage.getSearchHistory();

      // Assert
      expect(historyAfterClear, isEmpty);
    });
  });
}
