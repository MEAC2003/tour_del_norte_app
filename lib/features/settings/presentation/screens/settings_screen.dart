import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tour_del_norte_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Ajustes',
          style: AppStyles.h2(
              color: AppColors.darkColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: AppColors.darkColor50, thickness: 0.5),
              SizedBox(height: AppSize.defaultPadding / 1.5),
              const SwitchThemes(),
              const OptionsLanguage(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(Icons.arrow_forward_ios),
                title: Text(
                  'Preguntas frecuentes',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: AppSize.defaultPadding / 1.5),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Cerrar Sesión',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () async {
                  await context.read<AuthProvider>().signOut();
                  context.go(AppRouter.signIn);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}