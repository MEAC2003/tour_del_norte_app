import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/core/providers/language_provider.dart';
import 'package:tour_del_norte_app/core/theme/app_theme.dart';
import 'package:tour_del_norte_app/core/theme/theme_provider.dart';
import 'package:tour_del_norte_app/features/admin/data/datasources/supabase_admin_data_source.dart';
import 'package:tour_del_norte_app/features/admin/domain/repositories/admin_repository_impl.dart';
import 'package:tour_del_norte_app/features/admin/presentation/providers/admin_provider.dart';

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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final authProvider = AuthProvider(authRepository);
  await authProvider.initializeUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AdminProvider(
            AdminRepositoryImpl(
              SupabaseAdminDataSource(Supabase.instance.client),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider.value(value: authProvider),
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
      builder: (context, child) {
        return Consumer2<ThemeProvider, LanguageProvider>(
          builder: (context, themeProvider, languageProvider, child) =>
              MaterialApp.router(
            key: UniqueKey(),
            routerConfig: AppRouter.getRouter(context),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: languageProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('es', ''),
            ],
            title: 'Tour del Norte App',
          ),
        );
      },
    );
  }
}
