import 'package:weather_app/domain/entities/forecast_item_entity.dart';

class ForecastEntity {
  final String cityName;
  final List<ForecastItemEntity> forecastList;

  ForecastEntity({
    required this.cityName,
    required this.forecastList,
  });
}
