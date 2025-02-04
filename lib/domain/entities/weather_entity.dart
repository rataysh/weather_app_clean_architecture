class WeatherEntity {
  final double temperature;
  final String description;
  final String? cityName;

  WeatherEntity({
    required this.temperature,
    required this.description,
    this.cityName,
  });
}
