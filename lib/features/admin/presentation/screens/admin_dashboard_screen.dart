import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';

import 'package:tour_del_norte_app/features/admin/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';

import 'package:tour_del_norte_app/utils/utils.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Admin Dashboard',
            style: AppStyles.h2(color: AppColors.primaryGrey),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5),
            icon: const Icon(Icons.logout, color: AppColors.primaryGrey),
            onPressed: () {
              context.read<AuthProvider>().signOut();
              context.go(AppRouter.home);
            },
          ),
        ],
      ),
      body: const _AdminDashboardView(),
    );
  }
}

class _AdminDashboardView extends StatefulWidget {
  const _AdminDashboardView();

  @override
  State<_AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<_AdminDashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final userName = authProvider.currentUser?.userMetadata?['full_name'] ?? '';

    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultPadding * 1.25),
            child: Column(
              children: [
                SizedBox(height: AppSize.defaultPadding * 0.5),
                WelcomeCard(name: userName.split(' ')[0]),
                SizedBox(height: AppSize.defaultPadding * 1.5),
                QuickStatsRow(
                  todayBookings: adminProvider.todayBookings,
                  availableCars: adminProvider.availableCars,
                  totalRevenue: adminProvider.totalRevenue,
                ),
                SizedBox(height: AppSize.defaultPadding * 1.5),
                RecentBookingsCard(
                  recentBookings: adminProvider.recentBookings,
                  cars: adminProvider.cars,
                ),
                SizedBox(height: AppSize.defaultPadding * 1.5),
                const QuickActions(),
                SizedBox(height: AppSize.defaultPadding * 4),
              ],
            ),
          ),
        );
      },
    );
  }
}
