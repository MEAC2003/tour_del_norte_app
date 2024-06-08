import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class SwitchThemes extends StatelessWidget {
  const SwitchThemes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dark Mode',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: false,
          activeColor: AppColors.primaryColor,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
