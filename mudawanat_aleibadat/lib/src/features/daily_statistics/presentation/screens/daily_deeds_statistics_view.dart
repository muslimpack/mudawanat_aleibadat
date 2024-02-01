import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Card(
            child: SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  titlesData: const FlTitlesData(show: false),
                  gridData: FlGridData(),
                  borderData: FlBorderData(
                    show: true,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      color: Theme.of(context).colorScheme.primary,
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 3),
                        const FlSpot(6, 4),
                        const FlSpot(6, 5),
                        const FlSpot(7, 5),
                        const FlSpot(8, 5),
                      ],
                      // isCurved: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
