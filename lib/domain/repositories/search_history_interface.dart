import 'package:weather_app/domain/entities/search_history_entity.dart';

abstract class SearchHistoryRepositoryInterface {
  // Retrieve the list of search history entries
  Future<List<SearchHistoryEntity>> getSearchHistory();

  // Save a search history entry
  Future<void> saveSearchHistory(SearchHistoryEntity history);

  // Clear the entire search history
  Future<void> clearSearchHistory();
}
