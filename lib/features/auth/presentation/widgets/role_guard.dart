import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/screens/home_screen.dart';
import '../../domain/enums/user_role.dart';
import '../providers/auth_provider.dart';

class RoleGuard extends StatelessWidget {
  final UserRole requiredRole;
  final Widget child;

  const RoleGuard({super.key, required this.requiredRole, required this.child});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAuthenticated ||
        !authProvider.hasRole(requiredRole.toString().split('.').last)) {
      // Redirigir a una página de acceso denegado o a la página de inicio
      return const HomeScreen(); // Asegúrate de crear esta pantalla
    }

    return child;
  }
}
