import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/general_info/data/models/information.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class AboutUs extends StatelessWidget {
  final Information information;
  const AboutUs({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.defaultPadding,
      ),
      child: SizedBox(
        height: 0.34.sh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sobre nosotros',
                style: AppStyles.h2(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: AppSize.defaultPadding * 0.5,
              ),
              Text(
                information.aboutUs ?? 'Información no disponible',
                style: AppStyles.h4(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: AppSize.defaultPadding * 0.5,
              ),
              Text(
                'Misión',
                style: AppStyles.h2(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: AppSize.defaultPadding * 0.5,
              ),
              Text(
                information.mision ?? 'Misión no disponible',
                style: AppStyles.h4(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: AppSize.defaultPadding * 0.5,
              ),
              Text(
                'Visión',
                style: AppStyles.h2(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: AppSize.defaultPadding * 0.5,
              ),
              Text(
                information.vision ?? 'Visión no disponible',
                style: AppStyles.h4(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
