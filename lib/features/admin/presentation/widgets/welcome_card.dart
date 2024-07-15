import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class WelcomeCard extends StatelessWidget {
  final String name;
  const WelcomeCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.defaultRadius)),
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding * 1.25),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSize.defaultPadding * 1.7,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.person,
                  size: AppSize.defaultPadding * 2.5, color: Colors.white),
            ),
            SizedBox(width: AppSize.defaultPaddingHorizontal * 1.25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.5.sw,
                  child: Text(
                    'Bienvenido, $name',
                    style: AppStyles.h3(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('¿Qué haremos hoy?',
                    style: AppStyles.h4(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
