import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Nuestros Vehículos',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const _CarsView(),
    );
  }
}

class _CarsView extends StatefulWidget {
  const _CarsView();

  @override
  _CarsViewState createState() => _CarsViewState();
}

class _CarsViewState extends State<_CarsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CarProvider>().loadCars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        if (carProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (carProvider.cars.isEmpty) {
          return const Center(child: Text('No hay coches disponibles.'));
        }

        return ListView.builder(
          itemCount: carProvider.cars.length,
          itemBuilder: (context, index) {
            final car = carProvider.cars[index];
            return CardCar(
              carModel: car.name,
              carDescription: car.shortOverview,
              carPassengers: car.passengers.toString(),
              carYear: car.year,
              carPrice: car.priceByDay.toString(),
              carImage: car.images.isNotEmpty ? car.images[0] : '',
              isAvailable: car.isAvailable,
              onTap: () {
                context.push(AppRouter.carDetails, extra: car.id);
              },
            );
          },
        );
      },
    );
  }
}
