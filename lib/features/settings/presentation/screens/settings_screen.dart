import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tour_del_norte_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tour_del_norte_app/core/providers/language_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.settings,
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
              ListTile(
                title: Text(t.language),
                trailing: DropdownButton<String>(
                  value: languageProvider.locale.languageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'es', child: Text('Español')),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      languageProvider.setLocale(Locale(value));
                    }
                  },
                ),
              ),
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
                onTap: () {
                  context.push(AppRouter.faq);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: const Icon(Icons.arrow_forward_ios),
                title: Text(
                  'Políticas y Condiciones',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.push(AppRouter.policies);
                },
              ),
              SizedBox(height: AppSize.defaultPadding / 1.5),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  final bool isSignedIn = authProvider.isAuthenticated;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      isSignedIn ? 'Cerrar Sesión' : 'Iniciar Sesión',
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () async {
                      if (isSignedIn) {
                        await context.read<AuthProvider>().signOut();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sesión cerrada')),
                        );
                      } else {
                        context.go(AppRouter.signIn);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
