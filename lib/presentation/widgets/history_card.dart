import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/search_history_entity.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/theme/theme.dart';

class HistoryCard extends StatelessWidget {
  final SearchHistoryEntity history;

  const HistoryCard({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM, HH:mm');

    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: AppTheme.cardDecoration,
        child: ListTile(
          title: Text('City: ${history.cityName}'),
          subtitle: Text(
            'Searched at: ${dateFormat.format(history.searchTime)}\nTemperature: ${history.temperature.toStringAsFixed(1)} °C',
          ),
        ),
      ),
    );
  }
}
