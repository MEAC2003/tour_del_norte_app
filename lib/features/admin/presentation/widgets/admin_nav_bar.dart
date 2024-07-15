import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:go_router/go_router.dart';

class AdminNavBar extends StatefulWidget {
  final Widget child;

  const AdminNavBar({super.key, required this.child});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              child: SlidingClippedNavBar(
                inactiveColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                onButtonPressed: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  switch (index) {
                    case 0:
                      context.go(AppRouter.adminDashboard);
                      break;
                    case 1:
                      context.go(AppRouter.adminUsers);
                      break;
                    case 2:
                      context.go(AppRouter.adminCars);
                      break;
                    case 3:
                      context.go(AppRouter.adminBookings);
                      break;
                  }
                },
                iconSize: 30,
                activeColor: AppColors.primaryColor,
                selectedIndex: _selectedIndex,
                barItems: [
                  BarItem(
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                  ),
                  BarItem(
                    icon: Icons.people,
                    title: 'Usuarios',
                  ),
                  BarItem(
                    icon: Icons.directions_car,
                    title: 'Autos',
                  ),
                  BarItem(
                    icon: Icons.book_online,
                    title: 'Reservas',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
