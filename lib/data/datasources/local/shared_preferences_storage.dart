import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather_app/data/models/search_history_dto.dart';

class SharedPreferencesStorage {
  static const String _historyKey = 'search_history';

  // instance
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Retrieve search history from SharedPreferences
  Future<List<SearchHistoryDTO>> getSearchHistory() async {
    final prefs = await _prefs;
    final String? jsonString = prefs.getString(_historyKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((jsonItem) => SearchHistoryDTO.fromMap(jsonItem))
          .toList();
    }
    return [];
  }

  // Save a search history entry to SharedPreferences
  Future<void> saveSearchHistory(SearchHistoryDTO dto) async {
    final prefs = await _prefs;
    final List<SearchHistoryDTO> currentHistory = await getSearchHistory();
    currentHistory.add(dto);
    final List<Map<String, dynamic>> jsonList =
        currentHistory.map((dto) => dto.toMap()).toList();
    await prefs.setString(_historyKey, json.encode(jsonList));
  }

  // Clear all saved search history from SharedPreferences
  Future<void> clearSearchHistory() async {
    final prefs = await _prefs;
    await prefs.remove(_historyKey);
  }
}
