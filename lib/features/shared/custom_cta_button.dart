import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/app_colors.dart';
import 'package:tour_del_norte_app/utils/app_size.dart';
import 'package:tour_del_norte_app/utils/app_styles.dart';

class CustomCTAButton extends StatelessWidget {
  final String text;
  const CustomCTAButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPadding * 1.5,
          vertical: AppSize.defaultPadding),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.defaultRadius),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: AppStyles.h3(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
