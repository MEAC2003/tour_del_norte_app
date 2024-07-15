import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/payment.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserDetailScreen extends StatefulWidget {
  final String? userId;
  final PublicUser? user;

  const UserDetailScreen({super.key, this.user, this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserInfoSection(user: widget.user!),
              SizedBox(height: AppSize.defaultPadding * 2),
              _UserBookingsSection(userId: widget.user!.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  final PublicUser user;

  const _UserInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información del Usuario',
                style: AppStyles.h2(color: AppColors.darkColor)),
            SizedBox(height: AppSize.defaultPadding),
            _InfoRow(title: 'Nombre', value: user.fullName),
            _InfoRow(title: 'Email', value: user.email),
            _InfoRow(title: 'DNI', value: user.dni ?? 'No disponible'),
            _InfoRow(title: 'Teléfono', value: user.phone ?? 'No disponible'),
            _InfoRow(title: 'Rol', value: user.role),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppStyles.h4(color: AppColors.darkColor50),
            ),
          ),
          const SizedBox(width: 8), // Espacio entre el título y el valor
          Expanded(
            flex: 3,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: AppStyles.h4(color: AppColors.darkColor),
                  ),
                ],
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // Ajusta esto según tus necesidades
            ),
          ),
        ],
      ),
    );
  }
}

class _UserBookingsSection extends StatelessWidget {
  final String userId;

  const _UserBookingsSection({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reservas del Usuario',
                style: AppStyles.h2(color: AppColors.darkColor)),
            SizedBox(height: AppSize.defaultPadding),
            FutureBuilder<List<Booking>>(
              future: Provider.of<AdminProvider>(context, listen: false)
                  .getBookingsForUser(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Error en FutureBuilder: ${snapshot.error}');
                  return Center(
                      child: Text(
                          'Error al cargar las reservas: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print('No se encontraron reservas para el usuario $userId');
                  return const Center(
                      child: Text('No hay reservas para este usuario'));
                } else {
                  print(
                      'Se encontraron ${snapshot.data!.length} reservas para el usuario $userId');
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final booking = snapshot.data![index];
                      return _BookingCard(booking: booking);
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;

  const _BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reserva ID: ${booking.id}',
                style: AppStyles.h3(color: AppColors.darkColor)),
            SizedBox(height: AppSize.defaultPadding / 2),
            _InfoRow(
                title: 'Inicio', value: formatter.format(booking.startDate)),
            _InfoRow(title: 'Fin', value: formatter.format(booking.endDate)),
            FutureBuilder<Payment?>(
              future: Provider.of<AdminProvider>(context, listen: false)
                  .getPaymentForBooking(booking.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar el estado del pago');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return _InfoRow(
                      title: 'Estado', value: snapshot.data!.status);
                } else {
                  return const _InfoRow(
                      title: 'Estado', value: 'No disponible');
                }
              },
            ),
            _InfoRow(
                title: 'Total',
                value: 'S/. ${booking.total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
