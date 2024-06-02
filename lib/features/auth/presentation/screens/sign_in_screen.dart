import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/app_assets.dart';
import 'package:tour_del_norte_app/utils/app_colors.dart';
import 'package:tour_del_norte_app/utils/app_size.dart';
import 'package:tour_del_norte_app/utils/app_styles.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SignInView(),
    );
  }
}

class _SignInView extends StatelessWidget {
  const _SignInView();

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
            Text('Iniciar sesión',
                style: AppStyles.h1(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w900,
                ).copyWith(letterSpacing: -1.5)),
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
              icon: Icon(Icons.email_outlined),
              hintText: 'Enter email',
              obscureText: false,
            ),
            const CustomTextField(
              icon: Icon(Icons.lock_person_outlined),
              hintText: 'Password',
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal * 1.5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: AppStyles.h4(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.defaultPadding,
            ),
            const CustomCTAButton(
              text: 'Iniciar sesión',
            ),
            const OrAccess(),
            const SocialMediaButton(
              imgPath: AppAssets.googleIcon,
              text: ' Iniciar sesión con Google',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes una cuenta?',
                    style: AppStyles.h4(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Regístrate',
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
