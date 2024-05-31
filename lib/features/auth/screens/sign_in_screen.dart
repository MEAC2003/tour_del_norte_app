import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              height: AppSize.defaultPadding * 3,
            ),
            Icon(
              Icons.person,
              size: AppSize.defaultIconSize,
            ),
            SizedBox(
              height: AppSize.defaultPadding,
            ),
            Text(
              'Iniciar sesión',
              style: AppStyles.h1(
                color: AppColors.darkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: AppSize.defaultPadding,
            ),
            Text(
              'Ingresa tus datos para continuar',
              style: AppStyles.h3(
                color: AppColors.darkColor50,
              ),
            ),
            SizedBox(
              height: AppSize.defaultPadding * 2,
            ),
            const CustomTextField(
              icon: Icon(Icons.email),
              hintText: 'Enter email',
              obscureText: false,
            ),
            SizedBox(
              height: AppSize.defaultPadding * 1.5,
            ),
            const CustomTextField(
              icon: Icon(Icons.lock),
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const CustomCTAButton(
              text: 'Iniciar sesión',
            ),
            const SizedBox(
              height: 24,
            ),
            const OrAccess(),
            const SizedBox(
              height: 24,
            ),
            const SocialMediaButton(
              imgPath: AppAssets.googleIcon,
              text: ' Iniciar sesión con Google',
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿No tienes una cuenta?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Regístrate',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String text, imgPath;
  const SocialMediaButton({
    super.key,
    required this.text,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: 380,
        height: 60,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          icon: Image.asset(imgPath),
          label: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class OrAccess extends StatelessWidget {
  const OrAccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 54),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'O',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCTAButton extends StatelessWidget {
  final String text;
  const CustomCTAButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.defaultPadding, vertical: AppSize.defaultPadding),
      child: SizedBox(
        width: double.infinity,
        height: 60.h,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.defaultRadius),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: AppStyles.h3(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
