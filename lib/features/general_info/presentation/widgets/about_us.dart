import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
                'Manejando nuestros vehículos híbridos descubrirás el verdadero significado de la nueva tecnología híbrida eléctrica auto-recargable, un máximo rendimiento y menor consumo, gracias a la óptima combinación de su motor eléctrico y a combustión.',
                style: AppStyles.h5(
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
                'Manejando nuestros vehículos híbridos descubrirás el verdadero significado de la nueva tecnología híbrida eléctrica auto-recargable, un máximo rendimiento y menor consumo, gracias a la óptima combinación de su motor eléctrico y a combustión..',
                style: AppStyles.h5(
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
                'Manejando nuestros vehículos híbridos descubrirás el verdadero significado de la nueva tecnología híbrida eléctrica auto-recargable, un máximo rendimiento y menor consumo, gracias a la óptima combinación de su motor eléctrico y a combustión..',
                style: AppStyles.h5(
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
