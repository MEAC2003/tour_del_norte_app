import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class QuickStatsRow extends StatelessWidget {
  final int todayBookings;
  final int availableCars;
  final double totalRevenue;

  const QuickStatsRow({
    super.key,
    required this.todayBookings,
    required this.availableCars,
    required this.totalRevenue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatCard(
            title: 'Reservas Hoy',
            value: todayBookings.toString(),
            icon: Icons.calendar_today,
          ),
          _StatCard(
            title: 'Autos Disponibles',
            value: availableCars.toString(),
            icon: Icons.directions_car,
          ),
          _StatCard(
            title: 'Ingresos',
            value: 'S/. ${totalRevenue.toStringAsFixed(2)}',
            icon: Icons.attach_money,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard(
      {required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: AppColors.primaryColor),
            const SizedBox(height: 10),
            Text(value, style: AppStyles.h4()),
            Text(title, style: AppStyles.h3(color: AppColors.darkColor50)),
          ],
        ),
      ),
    );
  }
}
