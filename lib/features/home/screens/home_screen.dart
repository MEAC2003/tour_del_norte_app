import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/home/data/repositories/car_repository_impl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () async {
            final repository = CarRepositoryImpl();
            await repository.getCarById(id: 1);
          },
          child: const Text('data'),
        ),
      ),
    );
  }
}
