import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/core/config/app_router.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Detalles del Vehículo',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const _CarDetailsView(),
    );
  }
}

class CarFeature {
  final IconData icon;
  final String label;

  CarFeature({required this.icon, required this.label});
}

class _CarDetailsView extends StatelessWidget {
  const _CarDetailsView();

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
      'https://res.cloudinary.com/dpngif7y4/image/upload/v1719551581/public/dkb7qiflt2qhcf5ccizd.png',
    ];

    final List<CarFeature> features = [
      CarFeature(icon: Icons.calendar_today, label: '2024'),
      CarFeature(icon: Icons.speed, label: '30,000 km'),
      CarFeature(icon: Icons.speed, label: 'Automático'),
      CarFeature(icon: Icons.person, label: '5'),
      CarFeature(icon: Icons.door_back_door, label: '4'),
      CarFeature(icon: Icons.local_gas_station, label: 'Gasolina'),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomCarouselSlider(imgList: imgList),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5,
                vertical: AppSize.defaultPadding * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SUV Toyota RAV4',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding * 0.5),
                Text(
                  'Self-Rechargeable Electric Hybrid',
                  style: AppStyles.h4(
                    color: AppColors.darkColor50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                Text(
                  'Descripción',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding * 0.5),
                Text(
                  'Manejando nuestros vehículos híbridos descubrirás el verdadero significado de la nueva tecnología híbrida eléctrica auto-recargable, un máximo rendimiento y menor consumo, gracias a la óptima combinación de su motor eléctrico y a combustión.',
                  style: AppStyles.h4(
                    color: AppColors.darkColor50,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: AppSize.defaultPadding),
                Text(
                  'Características',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding * 0.5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: features
                        .map(
                          (feature) => Container(
                            margin: EdgeInsets.only(
                              right: AppSize.defaultPaddingHorizontal,
                            ),
                            padding: EdgeInsets.all(
                              AppSize.defaultPaddingHorizontal,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGrey,
                              borderRadius:
                                  BorderRadius.circular(AppSize.defaultRadius),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  feature.icon,
                                ),
                                SizedBox(height: AppSize.defaultPadding * 0.1),
                                Text(
                                  feature.label,
                                  style:
                                      TextStyle(color: AppColors.darkColor50),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          CustomCTAButton(
              text: 'Reservar',
              onPressed: () {
                context.push(AppRouter.reservation);
              }),
          Text(
            'Se debe pagar una garantía de S/ 1400 *',
            style: AppStyles.h4(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCarouselSlider extends StatelessWidget {
  final List<String> imgList;
  const CustomCarouselSlider({
    required this.imgList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 0.25.sh,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.65,
      ),
      items: imgList
          .map((item) => Container(
                child: Center(
                  child: Image.network(item,
                      fit: BoxFit.cover, width: double.infinity),
                ),
              ))
          .toList(),
    );
  }
}
