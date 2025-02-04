import 'package:weather_app/domain/entities/city_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';

class GetCityCoordinatesUseCase {
  final WeatherRepositoryInterface repository;

  GetCityCoordinatesUseCase(this.repository);

  Future<CityEntity> call(String cityName) async {
    return await repository.getCityCoordinates(cityName);
  }
}
