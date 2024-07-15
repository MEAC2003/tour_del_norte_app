import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPaddingHorizontal,
          vertical: AppSize.defaultPadding,
        ),
        child: Column(
          children: [
            Text('Acciones Rápidas',
                style: AppStyles.h3(
                    color: AppColors.darkColor, fontWeight: FontWeight.bold)),
            SizedBox(height: AppSize.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _QuickActionButton(
                        icon: Icons.add_circle,
                        label: 'Nueva Reserva',
                        onPressed: () {
                          context.push(AppRouter.adminCreateBookings);
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.car_rental,
                        label: 'Añadir Vehículo',
                        onPressed: () {
                          context.push(AppRouter.adminAddCar);
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.person_add,
                        label: 'Añadir Usuario',
                        onPressed: () {
                          context.push(AppRouter.adminAddUser);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label, style: AppStyles.h4(color: AppColors.darkColor)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
