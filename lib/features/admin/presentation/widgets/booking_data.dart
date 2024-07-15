import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class MonthlyBookingsChart extends StatelessWidget {
  final List<Map<String, dynamic>> bookingData;

  const MonthlyBookingsChart({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Bookings', style: AppStyles.h3()),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: bookingData.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(),
                            entry.value['bookings'].toDouble());
                      }).toList(),
                      isCurved: true,
                      color: AppColors.primaryColor,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < bookingData.length) {
                            return Text(bookingData[value.toInt()]['month']);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingData {
  final String month;
  final int bookings;

  BookingData(this.month, this.bookings);
}
