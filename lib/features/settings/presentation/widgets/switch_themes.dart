import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_del_norte_app/core/theme/theme_provider.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class SwitchThemes extends StatelessWidget {
  const SwitchThemes({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Dark Mode',
        style: AppStyles.h3(
          color: AppColors.darkColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: themeProvider.themeMode == ThemeMode.dark,
      onChanged: (value) {
        themeProvider.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
