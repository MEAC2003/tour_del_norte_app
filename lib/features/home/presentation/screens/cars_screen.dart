import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
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

class _CarsView extends StatelessWidget {
  const _CarsView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: AppSize.defaultPadding * 1.5),
                CardCar(
                  carModel: 'SUV Toyota RAV4',
                  carDescription: 'Descripción corta sobre el auto',
                  carPassengers: '5',
                  carYear: '2020',
                  carPrice: '400',
                  carImage:
                      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                  isAvailable: true,
                  onTap: () {
                    context.push(AppRouter.carDetails);
                  },
                ),
                const CardCar(
                  carModel: 'SUV Toyota RAV4',
                  carDescription: 'Descripción corta sobre el auto',
                  carPassengers: '5',
                  carYear: '2020',
                  carPrice: '400',
                  carImage:
                      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                  isAvailable: true,
                ),
                CardCar(
                  carModel: 'SUV Toyota RAV4',
                  carDescription: 'Descripción corta sobre el auto',
                  carPassengers: '5',
                  carYear: '2020',
                  carPrice: '400',
                  carImage:
                      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                  isAvailable: true,
                  onTap: () {
                    context.push(AppRouter.carDetails);
                  },
                ),
                const CardCar(
                  carModel: 'SUV Toyota RAV4',
                  carDescription: 'Descripción corta sobre el auto',
                  carPassengers: '5',
                  carYear: '2020',
                  carPrice: '400',
                  carImage:
                      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                  isAvailable: true,
                ),
                CardCar(
                  carModel: 'SUV Toyota RAV4',
                  carDescription: 'Descripción corta sobre el auto',
                  carPassengers: '5',
                  carYear: '2020',
                  carPrice: '400',
                  carImage:
                      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                  isAvailable: true,
                  onTap: () {
                    context.push(AppRouter.carDetails);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
