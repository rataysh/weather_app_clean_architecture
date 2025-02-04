import 'package:weather_app/domain/entities/search_history_entity.dart';
import 'package:weather_app/domain/repositories/search_history_interface.dart';
import 'package:weather_app/data/datasources/local/shared_preferences_storage.dart';
import 'package:weather_app/data/models/search_history_dto.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepositoryInterface {
  final SharedPreferencesStorage storage;

  SearchHistoryRepositoryImpl({required this.storage});

  @override
  Future<List<SearchHistoryEntity>> getSearchHistory() async {
    // Retrieve search history DTO list from local storage
    final List<SearchHistoryDTO> dtoList = await storage.getSearchHistory();
    return dtoList.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> saveSearchHistory(SearchHistoryEntity history) async {
    // Convert Entity to DTO and save it to local storage
    final dto = SearchHistoryDTO.fromEntity(history);
    await storage.saveSearchHistory(dto);
  }

  @override
  Future<void> clearSearchHistory() async {
    // Clear all data from local storage
    await storage.clearSearchHistory();
  }
}
