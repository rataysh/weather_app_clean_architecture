import 'package:weather_app/data/models/forecast_dto.dart';
import 'package:weather_app/domain/entities/city_entity.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository_interface.dart';
import 'package:weather_app/data/datasources/remote/weather_api_service.dart';
import 'package:weather_app/data/models/city_dto.dart';
import 'package:weather_app/data/models/weather_dto.dart';

class WeatherRepositoryImpl implements WeatherRepositoryInterface {
  final WeatherApiService apiService;

  WeatherRepositoryImpl({required this.apiService});

  @override
  Future<CityEntity> getCityCoordinates(String cityName) async {
    final response = await apiService.fetchCityData(cityName);
    final cityDTO = CityDTO.fromMap(response);
    return cityDTO.toEntity();
  }

  @override
  Future<WeatherEntity> getWeather(
    double lat,
    double lon,
  ) async {
    final response = await apiService.fetchWeatherData(lat: lat, lon: lon);
    final weatherDTO = WeatherDTO.fromMap(response);
    return weatherDTO.toEntity();
  }


  @override
  Future<ForecastEntity> getForecast(double lat, double lon) async {
    final response = await apiService.fetchForecastData(lat: lat, lon: lon);
    final forecastDTO = ForecastDTO.fromMap(response);
    return forecastDTO.toEntity();
  }
}
