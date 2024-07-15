import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/features/admin/data/models/car.dart';
import 'package:tour_del_norte_app/features/admin/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/add_car_screen.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/add_user_screen.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/admin_car_bookings.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/admin_car_detail_screen.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/create_booking_screen.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/admin/presentation/screens/user_detail_screen.dart';
import 'package:tour_del_norte_app/features/admin/presentation/widgets/admin_nav_bar.dart';
import 'package:tour_del_norte_app/features/auth/domain/enums/user_role.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';

import 'package:tour_del_norte_app/features/auth/presentation/screens/screen.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/role_guard.dart';
import 'package:tour_del_norte_app/features/general_info/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/home/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/settings/presentation/screens/policies_screen.dart';
import 'package:tour_del_norte_app/features/settings/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/features/users/presentation/screens/screens.dart';

class AppRouter {
  static const String home = '/';
  static const String carDetails = '/car-details';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String userProfile = '/user-profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String faq = '/faq';
  static const String reservation = '/reservation';
  static const String businessInformation = '/business-information';
  static const String cars = '/cars';
  static const String userBookings = '/user-bookings';
  static const String policies = '/policies';
  static const String adminDashboard = '/admin-dashboard';
  static const String adminUsers = '/admin-users';
  static const String adminCars = '/admin-cars';
  static const String adminBookings = '/admin-bookings';
  static const String adminBookingsDetail = '/admin-bookings-detail';
  static const String adminAddCar = '/admin-add-car';
  static const String adminCarDetail = '/admin-car-detail';
  static const String adminCreateBookings = '/admin-create-bookings';
  static const String adminAddUser = '/admin-add-user';
  static const String adminUserDetail = '/admin-user-detail';

  static GoRouter getRouter(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    String initialLocation = home;
    if (authProvider.isAuthenticated &&
        authProvider.hasRole(UserRole.admin.toString().split('.').last)) {
      initialLocation = adminDashboard;
    }

    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return NavBar(child: child);
          },
          routes: [
            GoRoute(
              path: home,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: userProfile,
              builder: (context, state) => const UserProfileScreen(),
            ),
            GoRoute(
              path: settings,
              builder: (context, state) => const SettingsScreen(),
            ),

            // GoRoute(
            //   path: userBookings,
            //   builder: (context, state) => const UserBookingsScreen(),
            // ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) => AdminNavBar(child: child),
          routes: [
            GoRoute(
              path: adminDashboard,
              builder: (context, state) => const AdminDashboardScreen(),
            ),
            GoRoute(
              path: adminUsers,
              builder: (context, state) => const UserManagementScreen(),
            ),
            GoRoute(
              path: adminCars,
              builder: (context, state) => const CarManagementScreen(),
            ),
            GoRoute(
              path: adminBookings,
              builder: (context, state) => const BookingManagementScreen(),
            ),
          ],
        ),
        GoRoute(
          path: carDetails,
          builder: (context, state) =>
              CarDetailsScreen(carId: state.extra as int),
        ),
        GoRoute(
          path: faq,
          builder: (context, state) => const FAQScreen(),
        ),
        GoRoute(
          path: '$reservation/:carId',
          builder: (context, state) => ReservationScreen(
            carId: int.parse(state.pathParameters['carId']!),
          ),
        ),
        GoRoute(
          path: businessInformation,
          builder: (context, state) => const BusinessInformationScreen(),
        ),
        GoRoute(
          path: userBookings,
          builder: (context, state) => const UserBookingsScreen(),
        ),
        GoRoute(
          path: policies,
          builder: (context, state) => const PoliciesScreen(),
        ),
        GoRoute(
          path: signIn,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: signUp,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: editProfile,
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: cars,
          builder: (context, state) => const CarsScreen(),
        ),
        GoRoute(
          path: adminDashboard,
          builder: (context, state) => const RoleGuard(
            requiredRole: UserRole.admin,
            child: AdminDashboardScreen(),
          ),
        ),
        GoRoute(
          path: adminAddCar,
          builder: (context, state) => const AddCarScreen(),
        ),
        GoRoute(
          path: adminCreateBookings,
          builder: (context, state) => const CreateBookingScreen(),
        ),
        GoRoute(
          path: adminAddUser,
          builder: (context, state) => const AddUserScreen(),
        ),
        GoRoute(
          path: adminCarDetail,
          builder: (context, state) => const AdminCarDetailScreen(),
        ),
        GoRoute(
          path: '$adminCarDetail/:carId',
          builder: (context, state) {
            final carId = state.pathParameters['carId'];
            final car = state.extra as Car?;
            return AdminCarDetailScreen(carId: carId, car: car);
          },
        ),
        GoRoute(
          path: '$adminUserDetail/:userId',
          builder: (context, state) {
            final userId = state.pathParameters['userId'];
            final user = state.extra as PublicUser?;
            return UserDetailScreen(userId: userId, user: user);
          },
        ),
        GoRoute(
          path: '$adminBookingsDetail/:bookingId',
          builder: (context, state) {
            final bookingId = int.parse(state.pathParameters['bookingId']!);
            return BookingDetailsScreen(bookingId: bookingId);
          },
        ),
      ],
    );
  }
}
