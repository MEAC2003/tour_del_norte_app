import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/screens/screen.dart';
import 'package:tour_del_norte_app/features/general_info/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/home/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/root/screen/app_root.dart';
import 'package:tour_del_norte_app/features/settings/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';

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
  static const String prueba = '/prueba';
  static const String pruebS = '/pruebaS';
  static const String appRoot = '/app-root';

  static final router = GoRouter(
    initialLocation: home,
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
        ],
      ),
      GoRoute(
        path: carDetails,
        builder: (context, state) =>
            CarDetailsScreen(carId: state.extra as int),
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
        path: faq,
        builder: (context, state) => const FAQScreen(),
      ),
      GoRoute(
        path: '/reservation/:carId',
        builder: (context, state) => ReservationScreen(
          carId: int.parse(state.pathParameters['carId']!),
        ),
      ),
      GoRoute(
        path: businessInformation,
        builder: (context, state) => const BusinessInformationScreen(),
      ),
      GoRoute(path: cars, builder: (context, state) => const CarsScreen()),
      GoRoute(
        path: appRoot,
        builder: (context, state) => const AppRoot(),
      )
    ],
  );
}
