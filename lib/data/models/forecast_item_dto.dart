import 'package:weather_app/domain/entities/forecast_item_entity.dart';

class ForecastItemDTO {
  final int dt;
  final double temperature;

  ForecastItemDTO({
    required this.dt,
    required this.temperature,
  });

  factory ForecastItemDTO.fromMap(Map<String, dynamic> map) {
    final dt = map['dt'] as int;
    final temp = (map['main']['temp'] as num).toDouble();

    return ForecastItemDTO(
      dt: dt,
      temperature: temp,
    );
  }

  ForecastItemEntity toEntity() {
    return ForecastItemEntity(
      dateTime: DateTime.fromMillisecondsSinceEpoch(dt * 1000),
      temperature: temperature,
    );
  }
}
