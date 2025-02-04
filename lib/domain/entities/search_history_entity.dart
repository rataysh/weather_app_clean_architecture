class SearchHistoryEntity {
  final String cityName;
  final DateTime searchTime;
  final double temperature;

  SearchHistoryEntity({
    required this.cityName,
    required this.searchTime,
    required this.temperature,
  });
}
