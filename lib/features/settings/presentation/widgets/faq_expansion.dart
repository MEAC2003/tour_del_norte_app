import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class FaqExpansion extends StatelessWidget {
  final String question;
  final String answer;
  const FaqExpansion({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPaddingHorizontal * 1.5,
        vertical: AppSize.defaultPadding,
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkColor, // Color del borde inferior
              width: 0.5, // Grosor del borde inferior
            ),
          ),
        ),
        child: ExpansionTile(
          tilePadding:
              EdgeInsets.zero, // Eliminar el padding del tile por defecto
          title: Text(
            question,
            style: AppStyles.h3(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                answer,
                style: AppStyles.h4(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
