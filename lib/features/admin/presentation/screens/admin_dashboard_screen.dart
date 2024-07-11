import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Admin Dashboard'),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              final bool isSignedIn = authProvider.isAuthenticated;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  isSignedIn ? 'Cerrar Sesión' : 'Iniciar Sesión',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  authProvider.signOut();
                  context.go(AppRouter
                      .home); // Usa go en lugar de push para forzar una nueva navegación
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
