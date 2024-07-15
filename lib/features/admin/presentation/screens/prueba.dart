// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:tour_del_norte_app/core/config/app_router.dart';
// import 'package:tour_del_norte_app/features/admin/presentation/widgets/booking_data.dart';
// import 'package:tour_del_norte_app/features/admin/presentation/widgets/car_type_data.dart';
// import 'package:tour_del_norte_app/features/admin/presentation/widgets/monthly_revenue_chart.dart';
// import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
// import 'package:tour_del_norte_app/utils/utils.dart';

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class AdminDashboardScreen extends StatelessWidget {
//   const AdminDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: const Text('Panel de Administración'),
//               background: Image.asset(
//                 AppAssets.googleIcon,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   KPICards(),
//                   SizedBox(height: 24),
//                   RecentActivityFeed(),
//                   SizedBox(height: 24),
//                   QuickActionsGrid(),
//                   SizedBox(height: 24),
//                   RevenueChart(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class KPICards extends StatelessWidget {
//   const KPICards({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           KPICard(
//             title: 'Reservas Hoy',
//             value: '12',
//             icon: Icons.calendar_today,
//             color: Colors.blue,
//           ),
//           KPICard(
//             title: 'Ingresos',
//             value: '\$5,230',
//             icon: Icons.attach_money,
//             color: Colors.green,
//           ),
//           KPICard(
//             title: 'Autos Disponibles',
//             value: '8',
//             icon: Icons.directions_car,
//             color: Colors.orange,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class KPICard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;

//   const KPICard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Icon(icon, size: 40, color: color),
//             const SizedBox(height: 8),
//             Text(value, style: Theme.of(context).textTheme.headlineSmall),
//             Text(title, style: Theme.of(context).textTheme.bodySmall),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RecentActivityFeed extends StatelessWidget {
//   const RecentActivityFeed({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text('Actividad Reciente',
//                 style: Theme.of(context).textTheme.titleLarge),
//           ),
//           const ListTile(
//             leading: CircleAvatar(child: Icon(Icons.person)),
//             title: Text('Nueva reserva: Juan Pérez'),
//             subtitle: Text('Hace 5 minutos'),
//           ),
//           const ListTile(
//             leading: CircleAvatar(child: Icon(Icons.car_rental)),
//             title: Text('Auto devuelto: Toyota Corolla'),
//             subtitle: Text('Hace 1 hora'),
//           ),
//           const ListTile(
//             leading: CircleAvatar(child: Icon(Icons.warning)),
//             title: Text('Mantenimiento programado: Ford Mustang'),
//             subtitle: Text('Hace 3 horas'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuickActionsGrid extends StatelessWidget {
//   const QuickActionsGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 3,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         QuickActionButton(
//           icon: Icons.add_circle,
//           label: 'Nueva Reserva',
//           onPressed: () {},
//         ),
//         QuickActionButton(
//           icon: Icons.people,
//           label: 'Gestionar Usuarios',
//           onPressed: () {},
//         ),
//         QuickActionButton(
//           icon: Icons.directions_car,
//           label: 'Gestionar Autos',
//           onPressed: () {},
//         ),
//         QuickActionButton(
//           icon: Icons.attach_money,
//           label: 'Ver Ingresos',
//           onPressed: () {},
//         ),
//         QuickActionButton(
//           icon: Icons.settings,
//           label: 'Configuración',
//           onPressed: () {},
//         ),
//         QuickActionButton(
//           icon: Icons.bar_chart,
//           label: 'Reportes',
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }

// class QuickActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onPressed;

//   const QuickActionButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: onPressed,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40),
//             const SizedBox(height: 8),
//             Text(label, textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RevenueChart extends StatelessWidget {
//   const RevenueChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Ingresos Mensuales',
//                 style: Theme.of(context).textTheme.titleLarge),
//             const SizedBox(height: 16),
//             AspectRatio(
//               aspectRatio: 1.7,
//               child: LineChart(
//                 LineChartData(
//                   gridData: const FlGridData(show: false),
//                   titlesData: const FlTitlesData(show: false),
//                   borderData: FlBorderData(show: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: [
//                         const FlSpot(0, 3),
//                         const FlSpot(1, 1),
//                         const FlSpot(2, 4),
//                         const FlSpot(3, 2),
//                         const FlSpot(4, 5),
//                         const FlSpot(5, 3),
//                       ],
//                       isCurved: true,
//                       color: Colors.blue,
//                       barWidth: 3,
//                       isStrokeCapRound: true,
//                       dotData: const FlDotData(show: false),
//                       belowBarData: BarAreaData(
//                           show: true, color: Colors.blue.withOpacity(0.3)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:tour_del_norte_app/core/config/app_router.dart';
// import 'package:tour_del_norte_app/features/admin/presentation/widgets/booking_data.dart';
// import 'package:tour_del_norte_app/features/admin/presentation/widgets/car_type_data.dart';
// import 'package:tour_del_norte_app/features/admin/presentation/widgets/monthly_revenue_chart.dart';
// import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
// import 'package:tour_del_norte_app/utils/utils.dart';

// class AdminDashboardScreen extends StatelessWidget {
//   const AdminDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Panel de Administración'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Resumen',
//                   style: Theme.of(context).textTheme.headlineMedium),
//               const SizedBox(height: 20),
//               _buildSummaryCards(),
//               const SizedBox(height: 20),
//               Text('Estadísticas',
//                   style: Theme.of(context).textTheme.headlineSmall),
//               const SizedBox(height: 10),
//               _buildCharts(),
//               const SizedBox(height: 20),
//               Text('Acciones Rápidas',
//                   style: Theme.of(context).textTheme.headlineSmall),
//               const SizedBox(height: 10),
//               _buildQuickActions(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCards() {
//     return GridView.count(
//       crossAxisCount: 2,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         _buildSummaryCard('Usuarios', '100', Icons.people),
//         _buildSummaryCard('Reservas', '50', Icons.book_online),
//         _buildSummaryCard('Autos', '30', Icons.directions_car),
//         _buildSummaryCard('Ingresos', '\$10,000', Icons.attach_money),
//       ],
//     );
//   }

//   Widget _buildSummaryCard(String title, String value, IconData icon) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40),
//             const SizedBox(height: 10),
//             Text(title, style: const TextStyle(fontSize: 16)),
//             Text(value,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCharts() {
//     // Aquí puedes agregar gráficos usando bibliotecas como fl_chart o charts_flutter
//     return const SizedBox(
//       height: 200,
//       child: Center(child: Text('Gráficos de estadísticas')),
//     );
//   }

//   Widget _buildQuickActions() {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: [
//         ElevatedButton.icon(
//           onPressed: () {},
//           icon: const Icon(Icons.add),
//           label: const Text('Nuevo Usuario'),
//         ),
//         ElevatedButton.icon(
//           onPressed: () {},
//           icon: const Icon(Icons.car_rental),
//           label: const Text('Agregar Auto'),
//         ),
//         ElevatedButton.icon(
//           onPressed: () {},
//           icon: const Icon(Icons.book),
//           label: const Text('Ver Reservas'),
//         ),
//       ],
//     );
//   }
// }

