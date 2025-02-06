import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      // X is the index, Y is the temperature
      return FlSpot(index.toDouble(), item.temperature);
    }).toList();

    // We create a horizontal scroll for the chart
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        // We set the width proportionally to the number of data points
        width: (forecastList.length * 6).toDouble().clamp(500, 2000),
        height: 250,
        child: LineChart(
          LineChartData(
            // Set a range for the X axis to accommodate all points
            minX: 0,
            maxX: (spots.length - 1).toDouble(),

            // Enable zoom or pan if needed
            lineTouchData: LineTouchData(
              enabled: false,
              handleBuiltInTouches: false,
            ),

            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // Increase reservedSize to avoid overlapping
                  reservedSize: 40,
                  // You can also set an interval if you want fewer Y labels
                  interval: 1,
                  minIncluded: false,
                  maxIncluded: false,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toStringAsFixed(0)}°',
                        style: const TextStyle(fontSize: 12));
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // You could adjust interval if you want fewer X labels
                  interval: 8,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= forecastList.length) {
                      return const SizedBox.shrink();
                    }
                    final dateTime = forecastList[index].dateTime;
                    // Format the date and time, e.g. "05 Feb 03:00"
                    final formatted =
                        DateFormat('dd MMM HH:mm').format(dateTime);
                    return Text(
                      formatted,
                      style: const TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),

            borderData: FlBorderData(show: false),

            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                dotData: FlDotData(show: false),
              ),
            ],

            // Optionally control the grid lines
            gridData: FlGridData(
              show: true,
              horizontalInterval: 1,
              verticalInterval: 3,
            ),
          ),
        ),
      ),
    );
  }
}
