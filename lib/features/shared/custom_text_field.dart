import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_del_norte_app/utils/app_size.dart';
import 'package:tour_del_norte_app/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Añade esta línea

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.controller,
    this.validator, // Añade esta línea
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPaddingHorizontal * 1.5,
          vertical: AppSize.defaultPadding * 0.75),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(AppSize.defaultRadius),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal),
              child: icon,
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: AppSize.defaultPaddingHorizontal),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                    ),
                  ),
                  child: SizedBox(
                    height: 56.h,
                    child: TextFormField(
                      controller: controller,
                      style: AppStyles.h4(
                        fontWeight: FontWeight.w600,
                      ),
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: hintText,
                      ),
                      validator: validator, // Añade esta línea
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
