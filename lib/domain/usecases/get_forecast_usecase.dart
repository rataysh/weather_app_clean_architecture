import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';

class GetForecastUseCase {
  final WeatherRepositoryInterface repository;

  GetForecastUseCase(this.repository);

  Future<ForecastEntity> call(double lat, double lon) async {
    return await repository.getForecast(lat, lon);
  }
}
