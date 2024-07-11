import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CustomUserActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomUserActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5,
            vertical: AppSize.defaultPadding),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.primaryGrey),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.defaultRadius / 2),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: AppStyles.h4(
                color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
