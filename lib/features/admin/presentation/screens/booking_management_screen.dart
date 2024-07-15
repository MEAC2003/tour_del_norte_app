import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/admin_car_bookings.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class BookingManagementScreen extends StatefulWidget {
  const BookingManagementScreen({super.key});

  @override
  State<BookingManagementScreen> createState() =>
      _BookingManagementScreenState();
}

class _BookingManagementScreenState extends State<BookingManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false)
          .fetchAllBookingsWithDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Reservas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push(AppRouter.adminCreateBookings);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _BookingSearchBar(),
          _BookingFilterChips(),
          Expanded(
            child: _BookingList(),
          ),
          SizedBox(height: AppSize.defaultPadding * 4),
        ],
      ),
    );
  }
}

class _BookingSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar reservas...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onChanged: (value) {
          Provider.of<BookingProvider>(context, listen: false)
              .searchBookings(value);
        },
      ),
    );
  }
}

class _BookingFilterChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'Pendiente'),
          _FilterChip(label: 'Pagado'),
          _FilterChip(label: 'Cancelado'),
          _FilterChip(label: 'Completado'),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected:
            bookingProvider.selectedStatuses.contains(label.toLowerCase()),
        onSelected: (bool selected) {
          bookingProvider.toggleStatusFilter(label.toLowerCase());
        },
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final bookingsWithDetails = bookingProvider.bookingsWithDetails;

    if (bookingProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (bookingProvider.error != null) {
      return Center(child: Text('Error: ${bookingProvider.error}'));
    } else if (bookingsWithDetails.isEmpty) {
      return const Center(child: Text('No hay reservas disponibles.'));
    } else {
      return ListView.builder(
        itemCount: bookingsWithDetails.length,
        itemBuilder: (context, index) {
          return _BookingCard(bookingWithDetails: bookingsWithDetails[index]);
        },
      );
    }
  }
}

class _BookingCard extends StatelessWidget {
  final BookingWithDetails bookingWithDetails;

  const _BookingCard({super.key, required this.bookingWithDetails});

  @override
  Widget build(BuildContext context) {
    final booking = bookingWithDetails.booking;
    final payment = bookingWithDetails.payment;
    final car = bookingWithDetails.car;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(payment?.status ?? 'desconocido'),
          child: Icon(_getStatusIcon(payment?.status ?? 'desconocido'),
              color: Colors.white),
        ),
        title: Text('Reserva #${booking.id}'),
        subtitle: Text(
            '${booking.fullName} | ${_formatDateRange(booking.startDate, booking.endDate)}'),
        children: [
          Padding(
            padding: EdgeInsets.all(AppSize.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(title: 'Vehículo', value: '${car.name} (${car.year})'),
                _InfoRow(title: 'Duración', value: '${booking.qtyDays} días'),
                _InfoRow(title: 'Total', value: 'S/. ${booking.total}'),
                _InfoRow(
                    title: 'Estado', value: payment?.status ?? 'Desconocido'),
              ],
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('Ver detalles'),
                onPressed: () {
                  context
                      .push('${AppRouter.adminBookingsDetail}/${booking.id!}');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'pagado':
        return Colors.green;
      case 'completado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pendiente':
        return Icons.access_time;
      case 'pagado':
        return Icons.check_circle;
      case 'completado':
        return Icons.playlist_add_check_circle_outlined;
      case 'cancelado':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return '${formatter.format(start)} - ${formatter.format(end)}';
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
