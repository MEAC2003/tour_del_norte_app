import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserInfoRow extends StatelessWidget {
  final String title;
  final String text;
  const UserInfoRow({
    super.key,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.h4(
              color: AppColors.darkColor50,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 7,
            child: Text(
              text,
              textAlign: TextAlign.end,
              style: AppStyles.h4(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
