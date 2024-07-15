// En un nuevo archivo llamado create_booking_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/home/data/models/booking.dart';
import 'package:tour_del_norte_app/features/home/data/models/car.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/select_user_screen.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  _CreateBookingScreenState createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  List<DateTime> _disabledDates = [];

  final _formKey = GlobalKey<FormState>();
  PublicUser? _selectedUser;
  Car? _selectedCar;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));
  @override
  void initState() {
    super.initState();
    // Forzar la carga de coches cuando se inicia la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CarProvider>(context, listen: false).loadCars();
      _loadDisabledDates();
    });
  }

  Future<void> _loadDisabledDates() async {
    if (_selectedCar != null) {
      final bookingProvider =
          Provider.of<BookingProvider>(context, listen: false);
      final bookings =
          await bookingProvider.getBookingsForCar(_selectedCar!.id);

      setState(() {
        _disabledDates = bookings.expand((booking) {
          final days = booking.endDate.difference(booking.startDate).inDays;
          return List.generate(days + 1,
              (index) => booking.startDate.add(Duration(days: index)));
        }).toList();
      });
    }
  }

  int _calculateDays() {
    return _endDate.difference(_startDate).inDays + 1;
  }

  int _calculateTotal() {
    if (_selectedCar == null) return 0;
    return _selectedCar!.priceByDay * _calculateDays();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context); // Escuchar cambios
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    print('Number of cars: ${carProvider.cars.length}');
    print('Is loading: ${carProvider.isLoading}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nueva Reserva'),
      ),
      body: carProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : carProvider.availableCars.isEmpty
              ? const Center(child: Text('No hay vehículos disponibles'))
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final user = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectUserScreen()),
                          );
                          if (user != null) {
                            setState(() {
                              _selectedUser = user;
                            });
                          }
                        },
                        child: Text(_selectedUser == null
                            ? 'Seleccionar Usuario'
                            : 'Usuario: ${_selectedUser!.fullName}'),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Car>(
                        value: _selectedCar,
                        items: carProvider.availableCars.map((Car car) {
                          return DropdownMenuItem<Car>(
                            value: car,
                            child: Text(car.name),
                          );
                        }).toList(),
                        onChanged: (Car? newValue) {
                          setState(() {
                            _selectedCar = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: 'Seleccionar Vehículo Disponible'),
                      ),
                      const SizedBox(height: 16),
                      DateRange(
                        initialStartDate: _startDate,
                        initialEndDate: _endDate,
                        disabledDates: _disabledDates,
                        onDateTimeRangeSelected: (start, end) {
                          setState(() {
                            _startDate = start;
                            _endDate = end;
                          });
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(AppSize.defaultPadding),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGrey,
                          borderRadius:
                              BorderRadius.circular(AppSize.defaultRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resumen de la reserva',
                              style: AppStyles.h3(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppSize.defaultPadding * 0.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Duración:',
                                  style:
                                      AppStyles.h4(color: AppColors.darkColor),
                                ),
                                Text(
                                  '${_calculateDays()} día(s)',
                                  style: AppStyles.h4(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSize.defaultPadding * 0.5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Precio por día:',
                                  style:
                                      AppStyles.h4(color: AppColors.darkColor),
                                ),
                                Text(
                                  'S/ ${_selectedCar?.priceByDay ?? 0}',
                                  style: AppStyles.h4(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: AppColors.primaryColor.withOpacity(0.5),
                              thickness: 1,
                              height: AppSize.defaultPadding,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: AppStyles.h3(
                                    color: AppColors.darkColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'S/ ${_calculateTotal()}',
                                  style: AppStyles.h3(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedUser != null &&
                              _selectedCar != null) {
                            // Extraer la URL de la licencia del array
                            String licenseUrl = '';
                            if (_selectedUser != null) {
                              if (_selectedUser!.license is List<String>) {
                                List<String> licenseList =
                                    _selectedUser!.license as List<String>;
                                if (licenseList.isNotEmpty) {
                                  licenseUrl = licenseList[0];
                                }
                              } else if (_selectedUser!.license is String) {
                                licenseUrl = _selectedUser!.license as String;
                              }
                            }

                            // Eliminar los corchetes si aún están presentes
                            licenseUrl = licenseUrl
                                .replaceAll('[', '')
                                .replaceAll(']', '');

                            final booking = Booking(
                              fullName: _selectedUser!.fullName,
                              email: _selectedUser!.email,
                              phone: _selectedUser!.phone ?? '',
                              dni: _selectedUser!.dni ?? '',
                              license: licenseUrl, // Usar la URL extraída
                              idCar: _selectedCar!.id,
                              startDate: _startDate,
                              endDate: _endDate,
                              qtyDays:
                                  _endDate.difference(_startDate).inDays + 1,
                              total: (_selectedCar!.priceByDay *
                                      (_endDate.difference(_startDate).inDays +
                                          1))
                                  .toInt(),
                              idUser: _selectedUser!.id,
                            );

                            bookingProvider.createBooking(booking).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Reserva creada con éxito')),
                              );
                              // Actualizar la lista de reservas
                              bookingProvider.fetchAllBookingsWithDetails();
                              Navigator.of(context).pop();
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Error al crear la reserva: $error')),
                              );
                            });
                          }
                        },
                        child: const Text('Crear Reserva'),
                      )
                    ],
                  ),
                ),
    );
  }
}
