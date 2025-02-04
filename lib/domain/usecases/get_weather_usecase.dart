import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';

class GetWeatherUseCase {
  final WeatherRepositoryInterface repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> call(double lat, double lon) async {
    return await repository.getWeather(lat, lon);
  }
}
