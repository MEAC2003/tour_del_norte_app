import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Créditos',
            style: AppStyles.h2(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 0.28.sh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSize.defaultRadius,
                            ),
                          ),
                        ),
                        child: Text(
                          'Imágenes',
                          style: AppStyles.h4(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSize.defaultRadius,
                            ),
                          ),
                        ),
                        child: Text(
                          'FreePik',
                          style: AppStyles.h4(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
