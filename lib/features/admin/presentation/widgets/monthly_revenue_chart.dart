import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyRevenueChart extends StatelessWidget {
  final List<RevenueData> revenueData;

  const MonthlyRevenueChart({super.key, required this.revenueData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16.0, left: 6.0, top: 16, bottom: 6),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 1,
                verticalInterval: 1,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                            revenueData[value.toInt()].month.substring(0, 3)),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text('\$${value.toInt()}'),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              minX: 0,
              maxX: revenueData.length - 1,
              minY: 0,
              maxY: revenueData
                  .map((data) => data.revenue)
                  .reduce((a, b) => a > b ? a : b),
              lineBarsData: [
                LineChartBarData(
                  spots: revenueData.asMap().entries.map((entry) {
                    return FlSpot(entry.key.toDouble(), entry.value.revenue);
                  }).toList(),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true, color: Colors.blue.withOpacity(0.3)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RevenueData {
  final String month;
  final double revenue;

  RevenueData(this.month, this.revenue);
}
