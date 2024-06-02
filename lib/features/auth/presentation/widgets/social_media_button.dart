import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/app_size.dart';
import 'package:tour_del_norte_app/utils/app_styles.dart';

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
          horizontal: AppSize.defaultPaddingHorizontal * 1.5,
          vertical: AppSize.defaultPadding),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          icon: Image.asset(imgPath, width: 24, height: 24),
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
