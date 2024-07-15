import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tour_del_norte_app/features/admin/data/models/booking.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_brand.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car_type.dart';
import 'package:tour_del_norte_app/features/admin/data/models/payment.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';

class SupabaseAdminDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseAdminDataSource(this._supabaseClient);

  Future<List<Booking>> getRecentBookings(int limit) async {
    final response = await _supabaseClient
        .from('bookings')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List).map((e) => Booking.fromJson(e)).toList();
  }

  Future<int> getTodayBookingsCount() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await _supabaseClient
        .from('bookings')
        .select()
        .gte('start_date', today)
        .lt('start_date', '${today}T23:59:59')
        .count();

    return response.count;
  }

  Future<int> getAvailableCarsCount() async {
    final response = await _supabaseClient
        .from('car')
        .select()
        .eq('is_available', true)
        .count();

    return response.count;
  }

  Future<double> getTotalRevenue() async {
    try {
      final response = await _supabaseClient
          .from('payment')
          .select('amount, status, bookings(total)')
          .or('status.eq.pagado,status.eq.completado');

      final totals = (response as List)
          .where((payment) =>
              payment['status'] == 'pagado' ||
              payment['status'] == 'completado')
          .map((payment) => payment['bookings']['total'] as num);

      return totals.fold<double>(0, (sum, total) => sum + total.toDouble());
    } catch (error) {
      print('Error getting total revenue: $error');
      return 0.0;
    }
  }

  Future<List<Car>> getAllCars() async {
    try {
      final response = await _supabaseClient.from('car').select();

      return (response as List)
          .map((carData) => Car.fromJson(carData))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<PublicUser>> getAllUsers() async {
    try {
      final response = await _supabaseClient
          .from('public_users')
          .select()
          .order('full_name', ascending: true);

      print('Response from Supabase: $response');

      final users = (response as List)
          .map((userData) => PublicUser.fromJson(userData))
          .toList();

      print('Parsed users: ${users.length}');
      for (var user in users) {
        print(user.toJson());
      }

      return users;
    } catch (e, stackTrace) {
      print('Error fetching users: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
  }

  Future<void> updateUser(PublicUser user) async {
    await _supabaseClient
        .from('public_users')
        .update(user.toJson())
        .eq('id', user.id);
  }

  Future<Map<String, dynamic>> addPendingUser(PublicUser user) async {
    print('Iniciando proceso de agregar usuario: ${user.email}');
    int retryCount = 0;
    const maxRetries = 5;
    Duration delay = const Duration(seconds: 30);

    while (retryCount < maxRetries) {
      try {
        final response = await _supabaseClient.auth.signUp(
          email: user.email,
          password: 'admin123', // Considera generar una contraseña aleatoria
        );
        print('Usuario creado con ID: ${response.user?.id}');

        if (response.user != null) {
          // Aquí puedes agregar el código para insertar el usuario en tu tabla personalizada si es necesario
          return {'success': true, 'userId': response.user!.id};
        } else {
          return {'success': false, 'error': 'Failed to create user'};
        }
      } catch (e) {
        print('Error al agregar usuario: $e');
        if (e is AuthException && e.statusCode == 429) {
          retryCount++;
          print(
              'Límite de velocidad alcanzado. Intento $retryCount de $maxRetries. Esperando ${delay.inSeconds} segundos...');
          await Future.delayed(delay);
          delay *=
              2; // Duplica el tiempo de espera para el próximo intento (retroceso exponencial)
        } else {
          // Si es otro tipo de error, no reintentamos
          return {'success': false, 'error': e.toString()};
        }
      }
    }

    // Si llegamos aquí, hemos agotado todos los reintentos
    return {'success': false, 'error': 'Máximo número de reintentos alcanzado'};
  }

  Future<void> addCar(Car car) async {
    try {
      final response =
          await _supabaseClient.from('car').insert(car.toJson()).select();

      print('Respuesta de inserción: $response');

      if (response.isEmpty) {
        throw Exception('No se recibió respuesta al insertar el carro');
      }
    } catch (e) {
      print('Error en SupabaseAdminDataSource.addCar: $e');
      rethrow;
    }
  }

  Future<void> updateCar(Car car) async {
    await _supabaseClient.from('car').update(car.toJson()).eq('id', car.id!);
  }

  Future<void> deleteCar(int carId) async {
    try {
      // Primero, obtén todos los bookings relacionados con este auto
      // Asumimos que la columna se llama 'id_car', pero ajusta esto según tu estructura real
      final bookings = await _supabaseClient
          .from('bookings')
          .select('id')
          .eq('id_car', carId);

      // Elimina todos los pagos relacionados con estos bookings
      for (var booking in bookings) {
        await _supabaseClient
            .from('payment')
            .delete()
            .eq('booking_id', booking['id']);
      }

      // Ahora elimina los bookings
      await _supabaseClient.from('bookings').delete().eq('id_car', carId);

      // Finalmente, elimina el auto
      await _supabaseClient.from('car').delete().eq('id', carId);
    } catch (e) {
      print('Error al eliminar el auto: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      // Eliminar de la tabla public_users
      await _supabaseClient.from('public_users').delete().eq('id', userId);

      // Eliminar de la tabla de autenticación de Supabase
      await _supabaseClient.auth.admin.deleteUser(userId);
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  Future<Payment?> getPaymentForBooking(int bookingId) async {
    try {
      final response = await _supabaseClient
          .from('payment')
          .select()
          .eq('booking_id', bookingId)
          .single();

      return Payment.fromJson(response);
      return null;
    } catch (e) {
      print('Error al obtener el pago para la reserva $bookingId: $e');
      return null;
    }
  }

  Future<List<Booking>> getBookingsForUser(String userId) async {
    try {
      final response = await _supabaseClient
          .from('bookings')
          .select()
          .eq('id_user', userId)
          .order('start_date', ascending: false);

      print(
          'Respuesta de Supabase para userId $userId: $response'); // Añade esta línea

      final bookings =
          (response as List).map((e) => Booking.fromJson(e)).toList();

      print('Bookings procesados: ${bookings.length}'); // Añade esta línea

      return bookings;
    } catch (e) {
      print('Error al obtener las reservas del usuario: $e');
      return [];
    }
  }

  Future<List<Booking>> getBookingsForCar(int carId) async {
    try {
      final response = await _supabaseClient
          .from('bookings')
          .select()
          .eq('id_car', carId)
          .order('start_date', ascending: false);

      return (response as List).map((e) => Booking.fromJson(e)).toList();
    } catch (e) {
      print('Error al obtener las reservas del vehículo: $e');
      return [];
    }
  }

  Future<List<CarType>> getAllCarTypes() async {
    final response = await _supabaseClient.from('car_type').select();
    return (response as List).map((e) => CarType.fromJson(e)).toList();
  }

  Future<List<CarBrand>> getAllCarBrands() async {
    final response = await _supabaseClient.from('car_brands').select();
    return (response as List).map((e) => CarBrand.fromJson(e)).toList();
  }
}
