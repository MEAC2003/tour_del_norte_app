import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SignUpView(),
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.defaultPadding * 2,
            ),
            //colocar un imagen de 64x64
            Image.asset(
              AppAssets.logo,
              width: 64.w,
              height: 64.h,
            ),
            SizedBox(
              height: AppSize.defaultPadding,
            ),
            Text('Registrarse',
                style: AppStyles.h1(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w900,
                )),
            Text(
              'Ingresa tus datos para continuar',
              style: AppStyles.h4(
                color: AppColors.darkColor50,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: AppSize.defaultPadding,
            ),
            const CustomTextField(
              icon: Icon(Icons.person_2_outlined),
              hintText: 'Nombres',
              obscureText: false,
            ),
            const CustomTextField(
              icon: Icon(Icons.email_outlined),
              hintText: 'Correo electrónico',
              obscureText: false,
            ),
            const CustomTextField(
              icon: Icon(Icons.lock_person_outlined),
              hintText: 'Password',
              obscureText: true,
            ),
            const CustomCTAButton(
              text: 'Registrarse',
            ),
            const OrAccess(),
            SocialMediaButton(
              imgPath: AppAssets.googleIcon,
              text: ' Registrarse con Google',
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Ya tienes una cuenta?',
                    style: AppStyles.h4(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Iniciar sesión',
                      style: AppStyles.h4(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
