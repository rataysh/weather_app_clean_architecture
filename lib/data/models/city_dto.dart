import 'dart:convert';
import 'package:weather_app/domain/entities/city_entity.dart';

class CityDTO {
  final String name;
  final double lat;
  final double lon;

  CityDTO({
    required this.name,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }

  factory CityDTO.fromMap(Map<String, dynamic> map) {
    return CityDTO(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityDTO.fromJson(String source) =>
      CityDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  // Convert DTO to Entity
  CityEntity toEntity() {
    return CityEntity(
      name: name,
      lat: lat,
      lon: lon,
    );
  }

  // Convert Entity to DTO
  factory CityDTO.fromEntity(CityEntity entity) {
    return CityDTO(
      name: entity.name,
      lat: entity.lat,
      lon: entity.lon,
    );
  }
}
