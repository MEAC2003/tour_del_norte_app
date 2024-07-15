import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class RecentBookingsCard extends StatelessWidget {
  final List<Booking> recentBookings;
  final List<Car> cars; // Añade esta línea

  const RecentBookingsCard({
    super.key,
    required this.recentBookings,
    required this.cars, // Añade esta línea
  });
  String getFirstName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    return nameParts.isNotEmpty ? nameParts[0] : '';
  }

  String getThirdNamePart(String fullName) {
    List<String> nameParts = fullName.split(' ');
    return nameParts.length > 2 ? nameParts[2] : '';
  }

  // Función para obtener el nombre del auto por ID
  String _getCarName(int carId) {
    final car = cars.firstWhere(
      (car) => car.id == carId,
      orElse: () => Car(id: carId, name: 'Desconocido'),
    );
    List<String> nameParts = car.name?.split(' ') ?? ['Desconocido'];
    return nameParts.length > 1
        ? '${nameParts[0]} ${nameParts[1]}'
        : nameParts[0];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.defaultRadius)),
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding * 1.25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reservas Recientes',
                style: AppStyles.h3(
                    color: AppColors.darkColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...recentBookings.take(3).map((booking) => _BookingItem(
                  name:
                      '${getFirstName(booking.fullName)} ${getThirdNamePart(booking.fullName)}',
                  date: booking.startDate.toString().split(' ')[0],
                  car: _getCarName(booking.idCar),
                )),
          ],
        ),
      ),
    );
  }
}

class _BookingItem extends StatelessWidget {
  final String name;
  final String date;
  final String car;

  const _BookingItem({
    required this.name,
    required this.date,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(name[0])),
      title: Text(name),
      subtitle: Text(car),
      trailing: Text(date),
    );
  }
}
