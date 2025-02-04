import 'dart:convert';
import 'package:weather_app/domain/entities/search_history_entity.dart';

class SearchHistoryDTO {
  final String cityName;
  final DateTime searchTime;
  final double temperature;

  SearchHistoryDTO({
    required this.cityName,
    required this.searchTime,
    required this.temperature,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'searchTime': searchTime.millisecondsSinceEpoch,
      'temperature': temperature,
    };
  }

  factory SearchHistoryDTO.fromMap(Map<String, dynamic> map) {
    return SearchHistoryDTO(
      cityName: map['cityName'] as String,
      searchTime: DateTime.fromMillisecondsSinceEpoch(map['searchTime'] as int),
      temperature: map['temperature'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchHistoryDTO.fromJson(String source) =>
      SearchHistoryDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert DTO to Entity
  SearchHistoryEntity toEntity() {
    return SearchHistoryEntity(
      cityName: cityName,
      searchTime: searchTime,
      temperature: temperature,
    );
  }

  // Convert Entity to DTO
  factory SearchHistoryDTO.fromEntity(SearchHistoryEntity entity) {
    return SearchHistoryDTO(
      cityName: entity.cityName,
      searchTime: entity.searchTime,
      temperature: entity.temperature,
    );
  }
}
