import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/users/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/users/presentation/providers/users_provider.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().fetchUserBookings();
      context.read<CarProvider>();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
          style: AppStyles.h1(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer2<AuthProvider, UserProvider>(
        builder: (context, authProvider, userProvider, child) {
          if (authProvider.isAuthenticated) {
            if (userProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (userProvider.error != null) {
              return Center(child: Text('Error: ${userProvider.error}'));
            } else if (userProvider.user != null) {
              return _UserProfileView(user: userProvider.user!);
            } else {
              return const Center(child: Text('No se pudo cargar el perfil'));
            }
          } else {
            return const _UnauthenticatedView();
          }
        },
      ),
    );
  }
}

class _UserProfileView extends StatelessWidget {
  final PublicUser user;

  const _UserProfileView({required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: AppColors.darkColor50,
              thickness: 0.5.h,
            ),
            UserInfoRow(
              title: 'Nombre',
              text: user.fullName,
            ),
            UserInfoRow(
              title: 'Correo electrónico',
              text: user.email,
            ),
            UserInfoRow(
              title: 'Numero de teléfono',
              text: user.phone,
            ),
            UserInfoRow(
              title: 'DNI',
              text: user.dni,
            ),
            ImageCard(
              imgPath: user.license?.isNotEmpty == true
                  ? user.license!.first
                  : 'https://www.w3schools.com/w3images/avatar2.png',
            ),
            CustomUserActionButton(
              text: 'Editar datos',
              onPressed: () {
                context.push(AppRouter.editProfile);
              },
            ),
            SizedBox(height: AppSize.defaultPadding),
            Divider(
              color: AppColors.darkColor50,
              thickness: 0.5.h,
            ),
            SizedBox(height: AppSize.defaultPadding * 2),
            //quiero mostrar las reservas del usuario
            Center(
              child: Text(
                'Mis Reservas',
                style: AppStyles.h2(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding * 2),
            SizedBox(height: AppSize.defaultPadding * 2),
            _RecentBookings(),
            SizedBox(height: AppSize.defaultPadding * 1.5),
            CustomUserActionButton(
              text: 'Ver Todas las Reservas',
              onPressed: () {
                context.push(AppRouter.userBookings);
              },
            ),
            SizedBox(height: AppSize.defaultPadding * 4),
          ],
        ),
      ),
    );
  }
}

class _UnauthenticatedView extends StatelessWidget {
  const _UnauthenticatedView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No has iniciado sesión',
            style: AppStyles.h2(color: AppColors.darkColor),
          ),
          SizedBox(height: AppSize.defaultPadding * 2),
          Text(
            'Para ver tu perfil, debes iniciar sesión o registrarte',
            textAlign: TextAlign.center,
            style: AppStyles.h4(
              color: AppColors.darkColor50,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding),
          CustomUserActionButton(
            text: 'Iniciar Sesión',
            onPressed: () {
              context.push(AppRouter.signIn);
            },
          ),
          CustomUserActionButton(
            text: 'Registrarse',
            onPressed: () {
              context.push(AppRouter.signUp);
            },
          ),
        ],
      ),
    );
  }
}

class _RecentBookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BookingProvider, CarProvider>(
      builder: (context, bookingProvider, carProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (bookingProvider.error != null) {
          return Center(child: Text('Error: ${bookingProvider.error}'));
        } else if (bookingProvider.userBookings.isEmpty) {
          return const Center(child: Text('No tienes reservas recientes'));
        } else {
          final recentBookings = bookingProvider.userBookings.take(2).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recentBookings.asMap().entries.map((entry) {
              final index = entry.key;
              final booking = entry.value;
              final car = carProvider.getCarById(booking.idCar);

              // Formatear la fecha
              final formattedDate =
                  DateFormat('dd/MM/yyyy HH:mm').format(booking.startDate);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reserva ${index + 1}:',
                    style: AppStyles.h3(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${car?.name ?? 'Auto no encontrado'} - $formattedDate',
                    style: AppStyles.h4(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: AppSize.defaultPadding),
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }
}
