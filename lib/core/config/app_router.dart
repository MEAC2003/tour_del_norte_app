import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/features/auth/screens/screen.dart';
import 'package:tour_del_norte_app/features/home/screens/screens.dart';
import 'package:tour_del_norte_app/features/root/screen/app_root.dart';

class AppRouter {
  static const String home = '/';
  static const String carDetails = '/car-details';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String appRoot = '/app-root';

  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: carDetails,
        builder: (context, state) => const CarDetailsScreen(),
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
        path: appRoot,
        builder: (context, state) => const AppRoot(),
      ),
    ],
  );
}
