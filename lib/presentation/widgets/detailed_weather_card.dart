import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/presentation/widgets/forecast_chart_widget.dart';

class DetailedWeatherCard extends StatelessWidget {
  final WeatherEntity weather;
  final ForecastEntity? forecast;

  const DetailedWeatherCard({
    super.key,
    required this.weather,
    this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      color: Colors.blue[50],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: AppTheme.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'City: ${weather.cityName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Temperature: ${weather.temperature.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 16),
            ),
            if (forecast?.cityName != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child:
                    ForecastChartWidget(forecastList: forecast!.forecastList),
              ),
            const SizedBox(height: 8),
            Text(
              'Feels Like: ${(weather.temperature + 1).toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${weather.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Humidity: 14%',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
