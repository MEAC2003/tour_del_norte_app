// lib/features/admin/data/user_queue.dart
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';

import 'package:tour_del_norte_app/features/admin/domain/repositories/admin_repository.dart';

class UserQueue {
  final List<PublicUser> _queue = [];

  void addUser(PublicUser user) {
    _queue.add(user);
  }

  Future<void> processQueue(AdminRepository adminRepository) async {
    if (_queue.isEmpty) return;

    final user = _queue.first;
    try {
      final result = await adminRepository.addPendingUser(user);
      if (result['success']) {
        _queue.removeAt(0);
        print('Usuario creado exitosamente: ${user.email}');
      } else {
        print('Error al crear usuario: ${result['error']}');
        _queue.removeAt(0);
        _queue.add(user);
      }
    } catch (e) {
      print('Error al procesar la cola: $e');
    }
  }
}
