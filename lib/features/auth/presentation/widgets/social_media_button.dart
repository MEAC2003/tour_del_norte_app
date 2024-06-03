import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class SocialMediaButton extends StatelessWidget {
  final String text, imgPath;
  const SocialMediaButton({
    super.key,
    required this.text,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPadding * 1.32.h,
          vertical: AppSize.defaultPadding),
      child: SizedBox(
        width: double.infinity,
        height: 52.7.h,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor:
                const WidgetStatePropertyAll(AppColors.primaryGrey),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSize.defaultRadius * 1.6.w),
              ),
            ),
          ),
          onPressed: () {},
          icon: Image.asset(imgPath, width: 24.w, height: 24.h),
          label: Text(
            text,
            style: AppStyles.h4(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
