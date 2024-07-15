// edit_car_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';
import 'package:tour_del_norte_app/services/cloudinary_service.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class EditCarScreen extends StatefulWidget {
  final Car car;

  const EditCarScreen({super.key, required this.car});

  @override
  _EditCarScreenState createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
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
  late bool _isAvailable;
  late List<String> _images;

  final CloudinaryService _cloudinaryService = CloudinaryService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.car.name);
    _shortOverviewController =
        TextEditingController(text: widget.car.shortOverview);
    _passengersController =
        TextEditingController(text: widget.car.passengers.toString());
    _mileageController = TextEditingController(text: widget.car.mileage);
    _priceByDayController =
        TextEditingController(text: widget.car.priceByDay.toString());
    _fullOverviewController =
        TextEditingController(text: widget.car.fullOverview);
    _doorsController = TextEditingController(text: widget.car.doors.toString());
    _typeController = TextEditingController(text: widget.car.type);
    _fuelTypeController = TextEditingController(text: widget.car.fuelType);
    _yearController = TextEditingController(text: widget.car.year);
    _isAvailable = widget.car.isAvailable ?? false;
    _images = widget.car.images ?? [];
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

  Future<void> _addImage() async {
    final url = await _cloudinaryService.uploadImage();
    if (url != null) {
      setState(() {
        _images.add(url);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Vehículo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _shortOverviewController,
              decoration: const InputDecoration(labelText: 'Resumen corto'),
            ),
            TextField(
              controller: _passengersController,
              decoration: const InputDecoration(labelText: 'Pasajeros'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _mileageController,
              decoration: const InputDecoration(labelText: 'Kilometraje'),
            ),
            TextField(
              controller: _priceByDayController,
              decoration: const InputDecoration(labelText: 'Precio por día'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _fullOverviewController,
              decoration:
                  const InputDecoration(labelText: 'Descripción completa'),
              maxLines: 3,
            ),
            TextField(
              controller: _doorsController,
              decoration: const InputDecoration(labelText: 'Puertas'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            TextField(
              controller: _fuelTypeController,
              decoration:
                  const InputDecoration(labelText: 'Tipo de combustible'),
            ),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: 'Año'),
            ),
            SwitchListTile(
              title: const Text('Disponible'),
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Imágenes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._images.map((url) => Stack(
                      children: [
                        Image.network(url,
                            width: 100, height: 100, fit: BoxFit.cover),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _images.remove(url);
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: _addImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.add_photo_alternate, size: 40),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSize.defaultPadding * 4,
            )
          ],
        ),
      ),
    );
  }

  void _saveCar() {
    final updatedCar = widget.car.copyWith(
      name: _nameController.text,
      shortOverview: _shortOverviewController.text,
      passengers: int.tryParse(_passengersController.text),
      mileage: _mileageController.text,
      priceByDay: int.tryParse(_priceByDayController.text),
      fullOverview: _fullOverviewController.text,
      doors: int.tryParse(_doorsController.text),
      type: _typeController.text,
      fuelType: _fuelTypeController.text,
      year: _yearController.text,
      isAvailable: _isAvailable,
      images: _images,
    );

    Provider.of<AdminProvider>(context, listen: false).updateCar(updatedCar);
    Navigator.pop(context);
  }
}
