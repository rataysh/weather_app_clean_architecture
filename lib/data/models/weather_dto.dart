import 'dart:convert';
import 'package:weather_app/domain/entities/weather_entity.dart';

class WeatherDTO {
  final double temperature;
  final String description;
  final String? cityName;

  WeatherDTO({
    required this.temperature,
    required this.description,
    this.cityName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temperature': temperature,
      'description': description,
      "cityName": cityName ?? '',
    };
  }

  factory WeatherDTO.fromMap(Map<String, dynamic> map) {
    return WeatherDTO(
      temperature: map['main']['temp'] as double,
      description: map['weather'][0]['description'] as String,
      cityName: map['name'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDTO.fromJson(String source) =>
      WeatherDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert DTO to Entity
  WeatherEntity toEntity() {
    return WeatherEntity(
      temperature: temperature,
      description: description,
      cityName: cityName ?? '',
    );
  }

  // Convert Entity to DTO
  factory WeatherDTO.fromEntity(WeatherEntity entity) {
    return WeatherDTO(
      description: entity.description,
      temperature: entity.temperature,
      cityName: entity.cityName ?? '',
    );
  }
}
