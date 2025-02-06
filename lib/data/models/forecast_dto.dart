import 'dart:convert';
import 'package:weather_app/data/models/forecast_item_dto.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';

class ForecastDTO {
  final String cityName;
  final List<ForecastItemDTO> forecastList;

  ForecastDTO({
    required this.cityName,
    required this.forecastList,
  });

  factory ForecastDTO.fromMap(Map<String, dynamic> map) {
    // "list" is an array of forecast items
    final city = map['city'];
    final cityName = city['name'] as String? ?? '';

    final list = map['list'] as List<dynamic>;
    final forecastItems = list.map((item) {
      return ForecastItemDTO.fromMap(item as Map<String, dynamic>);
    }).toList();

    return ForecastDTO(
      cityName: cityName,
      forecastList: forecastItems,
    );
  }

  factory ForecastDTO.fromJson(String source) {
    return ForecastDTO.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  ForecastEntity toEntity() {
    return ForecastEntity(
      cityName: cityName,
      forecastList: forecastList.map((item) => item.toEntity()).toList(),
    );
  }
}
