import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/users/data/models/public_user.dart';
import 'package:tour_del_norte_app/features/users/presentation/providers/users_provider.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
          style: AppStyles.h1(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer2<AuthProvider, UserProvider>(
        builder: (context, authProvider, userProvider, child) {
          if (authProvider.isAuthenticated) {
            if (userProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (userProvider.error != null) {
              return Center(child: Text('Error: ${userProvider.error}'));
            } else if (userProvider.user != null) {
              return _UserProfileView(user: userProvider.user!);
            } else {
              return const Center(child: Text('No se pudo cargar el perfil'));
            }
          } else {
            return const _UnauthenticatedView();
          }
        },
      ),
    );
  }
}

class _UserProfileView extends StatelessWidget {
  final PublicUser user;

  const _UserProfileView({required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
        child: Column(
          children: [
            Divider(
              color: AppColors.darkColor50,
              thickness: 0.5.h,
            ),
            UserInfoRow(
              title: 'Nombre',
              text: user.fullName,
            ),
            UserInfoRow(
              title: 'Correo electrónico',
              text: user.email,
            ),
            UserInfoRow(
              title: 'Numero de teléfono',
              text: user.phone,
            ),
            UserInfoRow(
              title: 'DNI',
              text: user.dni,
            ),
            ImageCard(
              imgPath: user.license?.isNotEmpty == true
                  ? user.license!.first
                  : 'https://www.w3schools.com/w3images/avatar2.png',
            ),
            CustomUserActionButton(
              text: 'Editar datos',
              onPressed: () {
                context.push(AppRouter.editProfile);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UnauthenticatedView extends StatelessWidget {
  const _UnauthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No has iniciado sesión',
            style: AppStyles.h2(color: AppColors.darkColor),
          ),
          const SizedBox(height: 20),
          Text(
            'Para ver tu perfil, debes iniciar sesión o registrarte',
            textAlign: TextAlign.center,
            style: AppStyles.h4(color: AppColors.darkColor50),
          ),
          const SizedBox(height: 30),
          CustomUserActionButton(
            text: 'Iniciar Sesión',
            onPressed: () {
              context.push(AppRouter.signIn);
            },
          ),
          const SizedBox(height: 10),
          CustomUserActionButton(
            text: 'Registrarse',
            onPressed: () {
              context.push(AppRouter.signUp);
            },
          ),
        ],
      ),
    );
  }
}
