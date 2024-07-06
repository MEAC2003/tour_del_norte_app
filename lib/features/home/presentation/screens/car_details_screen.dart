import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CarDetailsScreen extends StatelessWidget {
  final int carId;

  const CarDetailsScreen({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Detalles del Vehículo',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _CarDetailsView(carId: carId),
    );
  }
}

class _CarDetailsView extends StatelessWidget {
  final int carId;

  const _CarDetailsView({required this.carId});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        final car = carProvider.getCarById(carId);

        if (car == null) {
          return const Center(child: Text('Vehículo no encontrado'));
        }

        List<CarFeature> features = [
          CarFeature(icon: Icons.calendar_today, label: car.year),
          CarFeature(icon: Icons.speed, label: car.mileage),
          CarFeature(
              icon: Icons.settings,
              label: 'Automático'), // Asumiendo que es automático
          CarFeature(icon: Icons.person, label: '${car.passengers}'),
          CarFeature(icon: Icons.door_back_door, label: '${car.doors}'),
          CarFeature(icon: Icons.local_gas_station, label: car.fuelType),
        ];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCarouselSlider(imgList: car.images),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.defaultPaddingHorizontal * 1.5,
                    vertical: AppSize.defaultPadding * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 0.5),
                    Text(
                      car.shortOverview,
                      style: AppStyles.h4(
                        color: AppColors.darkColor50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    Text(
                      'Descripción',
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 0.5),
                    Text(
                      car.fullOverview,
                      style: AppStyles.h4(
                        color: AppColors.darkColor50,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: AppSize.defaultPadding),
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
                        children: features
                            .map((feature) => _buildFeatureCard(feature))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    CustomCTAButton(
                        text: 'Reservar',
                        onPressed: () {
                          context.push(AppRouter.reservation);
                        }),
                    SizedBox(height: AppSize.defaultPadding * 0.5),
                    Text(
                      'Precio por día: S/ ${car.priceByDay}',
                      style: AppStyles.h4(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 0.5),
                    Text(
                      'Se debe pagar una garantía de S/ 1400 *',
                      style: AppStyles.h5(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

class CustomCarouselSlider extends StatelessWidget {
  final List<String> imgList;

  const CustomCarouselSlider({required this.imgList, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 0.25.sh,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.65,
      ),
      items: imgList
          .map((item) => Container(
                child: Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primaryGrey,
                        child:
                            const Icon(Icons.error, color: AppColors.darkColor),
                      );
                    },
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class CarFeature {
  final IconData icon;
  final String label;

  CarFeature({required this.icon, required this.label});
}
