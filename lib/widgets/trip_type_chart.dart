import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TripTypeChart extends StatelessWidget {
  final Map<String, int> data;

  const TripTypeChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.values.every((e) => e == 0)) {
      return const Center(child: Text('No completed trips'));
    }

    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sectionsSpace: 4,
          centerSpaceRadius: 40,
          sections: data.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: entry.key,
              radius: 60,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
