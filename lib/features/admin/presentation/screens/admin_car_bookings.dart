import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/data/models/payment.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int bookingId;

  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late Future<BookingWithDetails> _bookingDetailsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  void _loadBookingDetails() {
    _bookingDetailsFuture =
        context.read<BookingProvider>().getBookingsWithDetails().then(
              (bookings) =>
                  bookings.firstWhere((b) => b.booking.id == widget.bookingId),
            );
  }

  void _updateStatus(String newStatus) {
    final bookingProvider = context.read<BookingProvider>();
    Future<void> updateFunction;
    switch (newStatus) {
      case 'pagado':
        updateFunction = bookingProvider.confirmPayment(widget.bookingId);
        break;
      case 'cancelado':
        updateFunction = bookingProvider.cancelBooking(widget.bookingId);
        break;
      case 'completado':
        updateFunction = bookingProvider.completeBooking(widget.bookingId);
        break;
      default:
        return;
    }

    updateFunction.then((_) {
      if (mounted) {
        setState(() {
          _loadBookingDetails();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Estado actualizado a $newStatus')),
        );
      }
    }).catchError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el estado: $error')),
        );
      }
    });
  }

  void _deleteBooking() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Eliminar Reserva'),
        content:
            const Text('¿Estás seguro de que quieres eliminar esta reserva?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _performDeletion();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _performDeletion() async {
    BuildContext? dialogContext;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final bookingProvider =
          Provider.of<BookingProvider>(context, listen: false);
      await bookingProvider.deleteBooking(widget.bookingId);

      if (!mounted) return;

      if (dialogContext != null) {
        Navigator.of(dialogContext!).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reserva eliminada con éxito')),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;

      if (dialogContext != null) {
        Navigator.of(dialogContext!).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar la reserva: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Reserva #${widget.bookingId}'),
      ),
      body: FutureBuilder<BookingWithDetails>(
        future: _bookingDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron detalles'));
          }

          final bookingDetails = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                _BookingInfo(bookingWithDetails: bookingDetails),
                _UserInfo(booking: bookingDetails.booking),
                _CarInfo(car: bookingDetails.car),
                _PaymentInfo(payment: bookingDetails.payment),
                SizedBox(height: AppSize.defaultPadding),
                ElevatedButton(
                  child: const Text('Cambiar Estado'),
                  onPressed: () =>
                      _showChangeStatusDialog(context, bookingDetails),
                ),
                ElevatedButton(
                  onPressed: _deleteBooking,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Eliminar Reserva',
                    style: AppStyles.h4(color: AppColors.primaryGrey),
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding * 4),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showChangeStatusDialog(
      BuildContext context, BookingWithDetails bookingDetails) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cambiar Estado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Pagado'),
              onTap: () {
                Navigator.of(context).pop();
                _updateStatus('pagado');
              },
            ),
            ListTile(
              title: const Text('Cancelado'),
              onTap: () {
                Navigator.of(context).pop();
                _updateStatus('cancelado');
              },
            ),
            ListTile(
              title: const Text('Completado'),
              onTap: () {
                Navigator.of(context).pop();
                _updateStatus('completado');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingInfo extends StatelessWidget {
  final BookingWithDetails bookingWithDetails;

  const _BookingInfo({required this.bookingWithDetails});

  @override
  Widget build(BuildContext context) {
    final booking = bookingWithDetails.booking;
    return Card(
      margin: EdgeInsets.all(AppSize.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información de la Reserva',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _InfoRow(title: 'Número de Reserva', value: '#${booking.id}'),
            _InfoRow(
                title: 'Estado',
                value: bookingWithDetails.payment?.status ?? 'Desconocido'),
            _InfoRow(
                title: 'Fecha de Inicio',
                value: _formatDate(booking.startDate)),
            _InfoRow(
                title: 'Fecha de Fin', value: _formatDate(booking.endDate)),
            _InfoRow(title: 'Duración', value: '${booking.qtyDays} días'),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

class _UserInfo extends StatelessWidget {
  final Booking booking;

  const _UserInfo({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información del Cliente',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _InfoRow(title: 'Nombre', value: booking.fullName),
            _InfoRow(title: 'Email', value: booking.email),
            _InfoRow(title: 'Teléfono', value: booking.phone),
            _InfoRow(title: 'DNI', value: booking.dni),
            const SizedBox(height: 16),
            Text('Imagen del Brevete',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImageView(
                      imageUrl: booking.license,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  booking.license,
                  height: 0.25.sh,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 0.25.sh,
                      child: const Center(
                        child: Text('Error al cargar la imagen'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}

class _CarInfo extends StatelessWidget {
  final Car car;

  const _CarInfo({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(AppSize.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información del Vehículo',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _InfoRow(title: 'Modelo', value: car.name ?? ''),
            _InfoRow(title: 'Año', value: car.year ?? ''),
            _InfoRow(title: 'Tipo', value: car.type ?? ''),
            _InfoRow(title: 'Puertas', value: car.doors.toString()),
          ],
        ),
      ),
    );
  }
}

class _PaymentInfo extends StatelessWidget {
  final Payment? payment;

  const _PaymentInfo({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(AppSize.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información de Pago',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _InfoRow(
                title: 'Estado del Pago',
                value: (payment?.status == 'pagado' ||
                        payment?.status == 'pendiente')
                    ? payment!.status
                    : 'pagado'),
            _InfoRow(title: 'Monto', value: 'S/. ${payment?.amount ?? 0}'),
            if (payment?.paidAt != null)
              _InfoRow(
                title: 'Fecha de Pago',
                value: _formatDate(payment!.paidAt!),
              ),
            if (payment?.cancelledAt != null)
              _InfoRow(
                title: 'Fecha de Cancelación',
                value: _formatDate(payment!.cancelledAt!),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm:ss Z').format(date);
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
