import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CustomUserActionButton extends StatelessWidget {
  final String text;
  const CustomUserActionButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPaddingHorizontal * 1.5,
          vertical: AppSize.defaultPadding),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.primaryGrey),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.defaultRadius / 2),
            ),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: AppStyles.h4(
              color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
