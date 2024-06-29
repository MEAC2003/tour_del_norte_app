import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget {
  final Widget child;

  const NavBar({super.key, required this.child});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
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
                      context.go(AppRouter.home);
                      break;
                    case 1:
                      context.go(AppRouter.userProfile);
                      break;
                    case 2:
                      context.go(AppRouter.settings);
                      break;
                  }
                },
                iconSize: 30,
                activeColor: AppColors.primaryColor,
                selectedIndex: _selectedIndex,
                barItems: [
                  BarItem(
                    icon: Icons.home,
                    title: 'Inicio',
                  ),
                  BarItem(
                    icon: Icons.person,
                    title: 'Perfil',
                  ),
                  BarItem(
                    icon: Icons.settings,
                    title: 'Ajustes',
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
