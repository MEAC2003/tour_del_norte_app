import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/core/theme/app_theme.dart';
import 'package:tour_del_norte_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tour_del_norte_app/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tour_del_norte_app/features/general_info/data/datasources/supabase_information_source.dart';
import 'package:tour_del_norte_app/features/general_info/domain/repositories/information_repository_impl.dart';
import 'package:tour_del_norte_app/features/general_info/presentation/providers/information_provider.dart';
import 'package:tour_del_norte_app/features/home/data/datasources/supabase_booking_data_source.dart';
import 'package:tour_del_norte_app/features/home/data/datasources/supabase_car_data_source.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/booking_repository_impl.dart';
import 'package:tour_del_norte_app/features/home/domain/repositories/car_repository_impl.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/booking_provider.dart';
import 'package:tour_del_norte_app/features/home/presentation/providers/car_provider.dart';
import 'package:tour_del_norte_app/features/users/data/datasources/supabase_users_data_source.dart';
import 'package:tour_del_norte_app/features/users/domain/repositories/users_repository_impl.dart';
import 'package:tour_del_norte_app/features/users/presentation/providers/users_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  await ScreenUtil.ensureScreenSize();

  final authDataSource = SupabaseAuthDataSourceImpl();
  final authRepository = AuthRepositoryImpl(authDataSource);
  final informationDataSource = SupabaseInformationDataSourceImpl();
  final informationRepository =
      InformationRepositoryImpl(informationDataSource);
  final carDataSource = SupabaseCarDataSourceImpl();
  final carRepository = CarRepositoryImpl(carDataSource);
  final bookingDataSource = SupabaseBookingDataSourceImpl();
  final bookingRepository = BookingRepositoryImpl(bookingDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(
            UsersRepositoryImpl(
              SupabaseUsersDataSource(Supabase.instance.client),
            ),
            authProvider: Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, authProvider, previousUserProvider) =>
              previousUserProvider!..updateAuthProvider(authProvider),
        ),
        ChangeNotifierProvider(
            create: (_) => InformationProvider(informationRepository)),
        ChangeNotifierProvider(create: (_) => CarProvider(carRepository)),
        ChangeNotifierProvider(
            create: (_) => BookingProvider(bookingRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        title: 'Tour del Norte App',
      ),
    );
  }
}
