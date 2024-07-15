import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class AdminCarDetailScreen extends StatelessWidget {
  final String? carId;
  final Car? car;

  const AdminCarDetailScreen({super.key, this.car, this.carId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vehículo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CarImageCarousel(images: car!.images ?? []),
            Padding(
              padding: EdgeInsets.all(AppSize.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CarHeader(car: car!),
                  SizedBox(height: AppSize.defaultPadding),
                  _CarDescription(car: car!),
                  SizedBox(height: AppSize.defaultPadding),
                  _CarFeatures(car: car!),
                  SizedBox(height: AppSize.defaultPadding),
                  _CarBookingHistory(car: car!),
                  SizedBox(height: AppSize.defaultPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarImageCarousel extends StatelessWidget {
  final List<String> images;

  const _CarImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 0.25.sh,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        autoPlay: true,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _CarHeader extends StatelessWidget {
  final Car car;

  const _CarHeader({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          car.name ?? 'Sin nombre',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.defaultPadding * 0.5),
        Text(
          car.shortOverview ?? '',
          style: AppStyles.h4(
            color: AppColors.darkColor50,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CarDescription extends StatelessWidget {
  final Car car;

  const _CarDescription({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descripción',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.defaultPadding * 0.5),
        Text(
          car.fullOverview ?? '',
          style: AppStyles.h4(
            color: AppColors.darkColor50,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _CarFeatures extends StatelessWidget {
  final Car car;

  const _CarFeatures({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    List<CarFeature> features = [
      CarFeature(icon: Icons.calendar_today, label: car.year ?? ''),
      CarFeature(icon: Icons.speed, label: car.mileage ?? ''),
      CarFeature(icon: Icons.settings, label: car.type ?? ''),
      CarFeature(icon: Icons.person, label: '${car.passengers ?? 0}'),
      CarFeature(icon: Icons.door_back_door, label: '${car.doors ?? 0}'),
      CarFeature(icon: Icons.local_gas_station, label: car.fuelType ?? ''),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Características',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.defaultPadding * 0.5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                features.map((feature) => _buildFeatureCard(feature)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(CarFeature feature) {
    return Container(
      margin: EdgeInsets.only(right: AppSize.defaultPaddingHorizontal),
      padding: EdgeInsets.all(AppSize.defaultPaddingHorizontal),
      decoration: BoxDecoration(
        color: AppColors.primaryGrey,
        borderRadius: BorderRadius.circular(AppSize.defaultRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(feature.icon),
          SizedBox(height: AppSize.defaultPadding * 0.1),
          Text(
            feature.label,
            style: TextStyle(color: AppColors.darkColor50),
          ),
        ],
      ),
    );
  }
}

class _CarBookingHistory extends StatelessWidget {
  final Car car;

  const _CarBookingHistory({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Historial de Reservas',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.defaultPadding * 0.5),
        FutureBuilder<List<Booking>>(
          future: Provider.of<AdminProvider>(context, listen: false)
              .getBookingsForCar(car.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No hay reservas para este vehículo.');
            } else {
              return Column(
                children: snapshot.data!.map((booking) {
                  return _BookingItem(
                    user: booking.fullName,
                    date:
                        '${booking.startDate.toString().split(' ')[0]} - ${booking.endDate.toString().split(' ')[0]}',
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }
}

class _BookingItem extends StatelessWidget {
  final String user;
  final String date;

  const _BookingItem({super.key, required this.user, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(user),
      subtitle: Text(date),
    );
  }
}

class _MaintenanceItem extends StatelessWidget {
  final String service;
  final String date;

  const _MaintenanceItem(
      {super.key, required this.service, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.build),
      title: Text(service),
      subtitle: Text(date),
    );
  }
}

class CarFeature {
  final IconData icon;
  final String label;

  CarFeature({required this.icon, required this.label});
}
