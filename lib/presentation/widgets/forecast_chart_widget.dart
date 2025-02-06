import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/forecast_item_entity.dart';

class ForecastChartWidget extends StatelessWidget {
  final List<ForecastItemEntity> forecastList;

  const ForecastChartWidget({
    super.key,
    required this.forecastList,
  });

  @override
  Widget build(BuildContext context) {
    // Prepare spots
    final spots = forecastList.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      // X could be the index, Y could be the temperature
      return FlSpot(index.toDouble(), item.temperature);
    }).toList();

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toStringAsFixed(0)}°');
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // Here you could convert index to time (e.g. "06 Feb 12:00")
                  final index = value.toInt();
                  if (index < 0 || index >= forecastList.length) {
                    return const SizedBox.shrink();
                  }
                  final dateTime = forecastList[index].dateTime;
                  // Format dateTime as needed
                  final hour = dateTime.hour.toString().padLeft(2, '0');
                  return Text('$hour:00');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
