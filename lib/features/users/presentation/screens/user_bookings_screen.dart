import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/home/data/models/payment.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';

import 'package:tour_del_norte_app/features/users/presentation/widgets/booking_expansion_tile.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().fetchUserBookings();
      context.read<CarProvider>();
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Mis reservaciones',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const _UserBookingsScreen(),
    );
  }
}

class _UserBookingsScreen extends StatelessWidget {
  const _UserBookingsScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookingProvider, CarProvider>(
      builder: (context, bookingProvider, carProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (bookingProvider.error != null) {
          return Center(child: Text('Error: ${bookingProvider.error}'));
        } else if (bookingProvider.userBookings.isEmpty) {
          return const Center(child: Text('No tienes reservas'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: bookingProvider.userBookings.map((booking) {
                final car = carProvider.getCarById(booking.idCar);
                final formattedStartDate =
                    DateFormat('dd/MM/yyyy HH:mm').format(booking.startDate);
                final formattedEndDate =
                    DateFormat('dd/MM/yyyy HH:mm').format(booking.endDate);
                return FutureBuilder<Payment?>(
                  future: bookingProvider.getPaymentForBooking(booking.id!),
                  builder: (context, snapshot) {
                    String paymentStatus = 'pendiente'; // Estado por defecto
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        paymentStatus = snapshot.data!.status;
                      }
                    }
                    return BookingExpansionTile(
                      title: 'Reserva: ${car?.name ?? 'Auto no encontrado'}',
                      body: 'Detalles:\n'
                          '• Fecha de inicio: $formattedStartDate\n'
                          '• Fecha de fin: $formattedEndDate\n'
                          '• Precio total: S/ ${booking.total}\n'
                          '• Estado del pago: $paymentStatus',
                      onCancel: () {
                        if (booking.id != null) {
                          _showCancelDialog(
                              context, bookingProvider, booking.id!);
                        }
                      },
                      bookingStatus: paymentStatus, // Pasa el estado aquí
                    );
                  },
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  void _showCancelDialog(
      BuildContext context, BookingProvider bookingProvider, int bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar cancelación'),
          content:
              const Text('¿Estás seguro de que quieres cancelar esta reserva?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                bookingProvider.cancelBooking(bookingId).then((_) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Reserva cancelada con éxito')),
                  );
                }).catchError((error) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error al cancelar la reserva: $error')),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}

void _showCancelDialog(
    BuildContext context, BookingProvider bookingProvider, int bookingId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar cancelación'),
        content:
            const Text('¿Estás seguro de que quieres cancelar esta reserva?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Sí'),
            onPressed: () {
              bookingProvider.cancelBooking(bookingId).then((_) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reserva cancelada con éxito')),
                );
              }).catchError((error) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Error al cancelar la reserva: $error')),
                );
              });
            },
          ),
        ],
      );
    },
  );
}
