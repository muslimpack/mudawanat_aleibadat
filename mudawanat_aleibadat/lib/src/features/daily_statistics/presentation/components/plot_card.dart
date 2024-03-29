import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/core/utils/color_generator.dart';

class PlotCard extends StatelessWidget {
  final String label;
  final double height;
  final double? width;
  final double? maxY;
  final List<FlSpot> spots;

  const PlotCard({
    super.key,
    required this.label,
    required this.spots,
    this.height = 200,
    this.width,
    this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    final uniqueColor = ColorGenerator.highContrastByKey(key: label + label);
    return Card(
      color: uniqueColor.withOpacity(.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: LineChart(
                LineChartData(
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(width: 0),
                  ),
                  minY: 0,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      color: uniqueColor,
                      spots: spots,
                      belowBarData: BarAreaData(
                        show: true,
                        color: uniqueColor.withOpacity(0.2),
                      ),
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
