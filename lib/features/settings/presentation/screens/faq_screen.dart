import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Preguntas',
          style: AppStyles.h2(
              color: AppColors.darkColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
              child: Divider(
                color: AppColors.darkColor50,
                thickness: 0.5.h,
              ),
            ),
            SizedBox(
              height: AppSize.defaultPadding / 1.5.h,
            ),
            const FaqExpansion(
              question: '¿Cómo puedo cambiar mi contraseña?',
              answer:
                  'Para cambiar tu contraseña, sigue los siguientes pasos:\n1.ingresar a la aplicación\n2. ir a la sección de ajustes\n3. seleccionar la opción de cambiar contraseña\n4. ingresar la nueva contraseña\n5. guardar los cambios',
            ),
            const FaqExpansion(
              question: '¿Cómo puedo cambiar mi contraseña?',
              answer:
                  'Para cambiar tu contraseña, sigue los siguientes pasos:\n1.ingresar a la aplicación\n2. ir a la sección de ajustes\n3. seleccionar la opción de cambiar contraseña\n4. ingresar la nueva contraseña\n5. guardar los cambios',
            ),
          ],
        ),
      ),
    );
  }
}
