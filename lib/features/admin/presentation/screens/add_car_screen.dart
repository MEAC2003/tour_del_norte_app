// lib/features/admin/presentation/screens/add_car_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';
import 'package:tour_del_norte_app/services/cloudinary_service.dart';
import 'package:tour_del_norte_app/utils/app_colors.dart';
import 'package:tour_del_norte_app/utils/app_styles.dart';
import 'package:tour_del_norte_app/utils/app_size.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  int? _selectedCarTypeId;
  int? _selectedCarBrandId;
  String? _imageUrl;
  late TextEditingController _nameController;
  late TextEditingController _shortOverviewController;
  late TextEditingController _passengersController;
  late TextEditingController _mileageController;
  late TextEditingController _priceByDayController;
  late TextEditingController _fullOverviewController;
  late TextEditingController _doorsController;
  late TextEditingController _typeController;
  late TextEditingController _fuelTypeController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _shortOverviewController = TextEditingController();
    _passengersController = TextEditingController();
    _mileageController = TextEditingController();
    _priceByDayController = TextEditingController();
    _fullOverviewController = TextEditingController();
    _doorsController = TextEditingController();
    _typeController = TextEditingController();
    _fuelTypeController = TextEditingController();
    _yearController = TextEditingController();
    _loadCarTypesAndBrands();
  }

  void _loadCarTypesAndBrands() {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    adminProvider.loadCarTypes();
    adminProvider.loadCarBrands();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortOverviewController.dispose();
    _passengersController.dispose();
    _mileageController.dispose();
    _priceByDayController.dispose();
    _fullOverviewController.dispose();
    _doorsController.dispose();
    _typeController.dispose();
    _fuelTypeController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final url = await _cloudinaryService.uploadImage();
    if (url != null) {
      setState(() {
        _imageUrl = url;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newCar = Car(
        name: _nameController.text,
        shortOverview: _shortOverviewController.text,
        passengers: int.tryParse(_passengersController.text) ?? 0,
        mileage: _mileageController.text,
        priceByDay: int.tryParse(_priceByDayController.text) ?? 0,
        images: _imageUrl != null ? [_imageUrl!] : [],
        fullOverview: _fullOverviewController.text,
        isAvailable: true,
        doors: int.tryParse(_doorsController.text) ?? 0,
        type: _typeController.text,
        fuelType: _fuelTypeController.text,
        year: _yearController.text,
        idCarType: _selectedCarTypeId,
        idCarModel: _selectedCarBrandId,
      );

      final success = await Provider.of<AdminProvider>(context, listen: false)
          .addCar(newCar);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Auto añadido con éxito')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al añadir el auto')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Nuevo Vehículo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppSize.defaultPadding),
              Consumer<AdminProvider>(
                builder: (context, adminProvider, child) {
                  return DropdownButtonFormField<int>(
                    value: _selectedCarTypeId,
                    items: adminProvider.carTypes.map((carType) {
                      return DropdownMenuItem<int>(
                        value: carType.id,
                        child: Text(carType.typeName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCarTypeId = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Tipo de vehículo'),
                  );
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              Consumer<AdminProvider>(
                builder: (context, adminProvider, child) {
                  return DropdownButtonFormField<int>(
                    value: _selectedCarBrandId,
                    items: adminProvider.carBrands.map((carBrand) {
                      return DropdownMenuItem<int>(
                        value: carBrand.id,
                        child: Text(carBrand.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCarBrandId = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Marca del vehículo'),
                  );
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del vehículo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del vehículo';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _shortOverviewController,
                decoration:
                    const InputDecoration(labelText: 'Descripción corta'),
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _passengersController,
                decoration:
                    const InputDecoration(labelText: 'Número de pasajeros'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de pasajeros';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _mileageController,
                decoration: const InputDecoration(labelText: 'Kilometraje'),
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _priceByDayController,
                decoration: const InputDecoration(labelText: 'Precio por día'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio por día';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _fullOverviewController,
                decoration:
                    const InputDecoration(labelText: 'Descripción completa'),
                maxLines: 3,
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _doorsController,
                decoration:
                    const InputDecoration(labelText: 'Número de puertas'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _typeController,
                decoration:
                    const InputDecoration(labelText: 'Tipo de vehículo'),
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _fuelTypeController,
                decoration:
                    const InputDecoration(labelText: 'Tipo de combustible'),
              ),
              SizedBox(height: AppSize.defaultPadding),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Año'),
              ),
              SizedBox(height: AppSize.defaultPadding),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Subir imagen del vehículo'),
              ),
              if (_imageUrl != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                  child: Image.network(_imageUrl!, height: 100, width: 100),
                ),
              SizedBox(height: AppSize.defaultPadding),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Guardar vehículo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
