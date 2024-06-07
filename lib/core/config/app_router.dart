import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/screens/edit_profile_screen.dart';
import 'package:tour_del_norte_app/features/auth/presentation/screens/screen.dart';
import 'package:tour_del_norte_app/features/home/presentation/screens/screens.dart';
import 'package:tour_del_norte_app/features/root/screen/app_root.dart';
import 'package:tour_del_norte_app/features/settings/screens/settings_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String carDetails = '/car-details';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String userProfile = '/user-profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String appRoot = '/app-root';

  static final router = GoRouter(
    initialLocation: userProfile,
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
        path: userProfile,
        builder: (context, state) => const UserProfileScreen(),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: appRoot,
        builder: (context, state) => const AppRoot(),
      ),
    ],
  );
}
