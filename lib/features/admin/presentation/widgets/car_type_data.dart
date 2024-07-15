import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CarTypeDistributionChart extends StatelessWidget {
  final List<CarTypeData> carTypeData;

  const CarTypeDistributionChart({super.key, required this.carTypeData});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(height: 18),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: carTypeData.map((data) {
                      return PieChartSectionData(
                        color: data.color,
                        value: data.percentage,
                        title: '${data.percentage.toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffffff),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: carTypeData.map((data) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: data.color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data.type,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(width: 28),
          ],
        ),
      ),
    );
  }
}

class CarTypeData {
  final String type;
  final double percentage;
  final Color color;

  CarTypeData(this.type, this.percentage, this.color);
}
