import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/shared/card_car.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPadding,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tour del Norte',
                          style: AppStyles.h3(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: AppSize.defaultPadding * 0.1,
                        ), // Espacio entre los textos
                        Text(
                          'Hey, Antón!',
                          style: AppStyles.h3(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          AppAssets.logo,
                          fit: BoxFit.cover,
                          width: 60.w,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.defaultPadding * 0.5,
                ),
                Divider(
                  color: AppColors.darkColor50,
                  thickness: 0.25.h,
                ),
                SizedBox(
                  height: AppSize.defaultPadding * 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nuestros Autos',
                      style: AppStyles.h4(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Ver más',
                        style: AppStyles.h4(
                          color: AppColors.darkColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.72.sh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CardCar(
                    carModel: 'SUV Toyota RAV4',
                    carDescription: 'Descripción corta sobre el auto',
                    carPassengers: '5',
                    carYear: '2020',
                    carPrice: '1400',
                    carImage:
                        'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                    isAvailable: true,
                  ),
                  const CardCar(
                    carModel: 'SUV Toyota RAV4',
                    carDescription: 'Descripción corta sobre el auto',
                    carPassengers: '5',
                    carYear: '2020',
                    carPrice: '1400',
                    carImage:
                        'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                    isAvailable: true,
                  ),
                  const CardCar(
                    carModel: 'SUV Toyota RAV4',
                    carDescription: 'Descripción corta sobre el auto',
                    carPassengers: '5',
                    carYear: '2020',
                    carPrice: '1400',
                    carImage:
                        'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                    isAvailable: true,
                  ),
                  const CardCar(
                    carModel: 'SUV Toyota RAV4',
                    carDescription: 'Descripción corta sobre el auto',
                    carPassengers: '5',
                    carYear: '2020',
                    carPrice: '1400',
                    carImage:
                        'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
                    isAvailable: false,
                  ),
                  SizedBox(height: AppSize.defaultPadding * 2.5)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
