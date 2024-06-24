import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/shared/card_car.dart';

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
    return const SafeArea(
      child: Column(
        children: [
          CardCar(
            carModel: 'SUV Toyota RAV4',
            carDescription: 'Descripción corta sobre el auto',
            carPassengers: '5',
            carYear: '2020',
            carPrice: '1400',
            carImage:
                'https://res.cloudinary.com/dpngif7y4/image/upload/v1718403910/public/ImgCar.png',
            isAvailable: true,
          ),
        ],
      ),
    );
  }
}
