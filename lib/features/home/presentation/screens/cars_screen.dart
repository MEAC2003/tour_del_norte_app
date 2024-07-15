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
  String _searchQuery = '';
  bool _showOnlyAvailable = false;
  String _selectedType = 'Todos';
  String _selectedBrand = 'Todas';

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

        var filteredCars = carProvider.cars.where((car) {
          if (_showOnlyAvailable && !car.isAvailable) return false;
          if (_selectedType != 'Todos' &&
              carProvider.getCarTypeName(car.idCarType) != _selectedType) {
            return false;
          }
          if (_selectedBrand != 'Todas' &&
              carProvider.getCarBrandName(car.name) != _selectedBrand) {
            return false;
          }
          return car.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.defaultPadding),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar vehículos',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.defaultRadius),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Solo disponibles'),
                      selected: _showOnlyAvailable,
                      onSelected: (bool selected) {
                        setState(() {
                          _showOnlyAvailable = selected;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedType,
                      items: ['Todos', ...carProvider.carTypeNames]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedBrand,
                      items: ['Todas', ...carProvider.carBrandNames]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBrand = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCars.length,
                itemBuilder: (context, index) {
                  final car = filteredCars[index];
                  return CardCar(
                    carModel: car.name,
                    carDescription: car.shortOverview,
                    carPassengers: car.passengers.toString(),
                    carYear: car.year,
                    carPrice: car.priceByDay.toString(),
                    carImage: car.images.isNotEmpty ? car.images[0] : '',
                    isAvailable: car.isAvailable,
                    onTap: car.isAvailable
                        ? () {
                            context.push(AppRouter.carDetails, extra: car.id);
                          }
                        : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
