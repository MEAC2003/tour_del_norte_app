import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/edit_car_screen.dart';
import 'package:tour_del_norte_app/utils/app_assets.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CarManagementScreen extends StatefulWidget {
  const CarManagementScreen({super.key});

  @override
  _CarManagementScreenState createState() => _CarManagementScreenState();
}

class _CarManagementScreenState extends State<CarManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).loadCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Vehículos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push(AppRouter.adminAddCar);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _CarSearchBar(),
          Expanded(
            child: _CarList(),
          ),
          SizedBox(
            height: AppSize.defaultPadding * 4.5,
          )
        ],
      ),
    );
  }
}

class _CarSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar vehículos...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onChanged: (value) {
          Provider.of<AdminProvider>(context, listen: false).searchCars(value);
        },
      ),
    );
  }
}

class _CarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        List<Car> cars = adminProvider.cars;
        return ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            return _CarCard(car: cars[index]);
          },
        );
      },
    );
  }
}

class _CarCard extends StatelessWidget {
  final Car car;

  const _CarCard({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: _getLeadingImage(),
        ),
        title: Text(car.name ?? 'Sin nombre'),
        subtitle: Text(
            'Año: ${car.year} | Estado: ${car.isAvailable! ? 'Disponible' : 'No disponible'}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCarScreen(car: car),
                  ),
                );
                break;
              case 'delete':
                _showDeleteConfirmationDialog(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'edit',
              child: Text('Editar'),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Eliminar'),
            ),
          ],
        ),
        onTap: () {
          context.push(
            '${AppRouter.adminCarDetail}/${car.id}',
            extra: car,
          );
        },
      ),
    );
  }

  ImageProvider _getLeadingImage() {
    if (car.images != null && car.images!.isNotEmpty) {
      return NetworkImage(car.images!.first);
    } else {
      return const AssetImage(AppAssets.logo);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Estás seguro de que quieres eliminar este vehículo?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                Provider.of<AdminProvider>(context, listen: false)
                    .deleteCar(car.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Vehículo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CarHeader(),
            _CarInfo(),
            _CarBookingHistory(),
            _CarMaintenanceHistory(),
          ],
        ),
      ),
    );
  }
}

class _CarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Image.asset(
        AppAssets.logo,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CarInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información del Vehículo',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const _InfoRow(title: 'Marca', value: 'Toyota'),
            const _InfoRow(title: 'Modelo', value: 'Corolla'),
            const _InfoRow(title: 'Año', value: '2023'),
            const _InfoRow(title: 'Placa', value: 'ABC-123'),
            const _InfoRow(title: 'Estado', value: 'Disponible'),
            const _InfoRow(title: 'Kilometraje', value: '15,000 km'),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

class _CarBookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Historial de Reservas',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const _BookingItem(
                user: 'John Doe', date: '15/07/2023 - 20/07/2023'),
            const _BookingItem(
                user: 'Jane Smith', date: '01/07/2023 - 05/07/2023'),
          ],
        ),
      ),
    );
  }
}

class _BookingItem extends StatelessWidget {
  final String user;
  final String date;

  const _BookingItem({required this.user, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(user),
      subtitle: Text(date),
    );
  }
}

class _CarMaintenanceHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Historial de Mantenimiento',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const _MaintenanceItem(
                service: 'Cambio de aceite', date: '01/06/2023'),
            const _MaintenanceItem(
                service: 'Revisión general', date: '15/03/2023'),
          ],
        ),
      ),
    );
  }
}

class _MaintenanceItem extends StatelessWidget {
  final String service;
  final String date;

  const _MaintenanceItem({required this.service, required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.build),
      title: Text(service),
      subtitle: Text(date),
    );
  }
}
