import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class SatisfiedCustomers extends StatelessWidget {
  const SatisfiedCustomers({super.key});

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
            'Clientes satisfechos',
            style: AppStyles.h2(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 0.28.sh,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.defaultPadding,
                  ),
                  const Row(
                    children: [
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                      SatisfiedCustomerCard(
                        image: 'https://www.w3schools.com/w3images/avatar2.png',
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

class SatisfiedCustomerCard extends StatelessWidget {
  const SatisfiedCustomerCard({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppSize.defaultPaddingHorizontal),
      child: SizedBox(
        width: 0.6.sw,
        height: 0.25.sh,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.defaultRadius),
          child: FadeInImage.assetNetwork(
            placeholder: AppAssets.logo, // Imagen local de marcador de posición
            image: image,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Error al cargar la imagen'));
            },
          ),
        ),
      ),
    );
  }
}
