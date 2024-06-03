import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class ImageCard extends StatelessWidget {
  final String imgPath;
  const ImageCard({
    super.key,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brevete',
            style: AppStyles.h4(
              color: AppColors.darkColor50,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding),
          SizedBox(
            width: double.infinity,
            height: 175.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.defaultRadius * 2),
              child: FadeInImage.assetNetwork(
                placeholder:
                    AppAssets.logo, // Imagen local de marcador de posición
                image: imgPath,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Error al cargar la imagen'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
