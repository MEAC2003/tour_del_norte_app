import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.pop();
            },
          ),
          centerTitle: true,
          title: Text(
            'Editar Perfil',
            style: AppStyles.h2(
              color: AppColors.darkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const _EditProfileView());
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const CustomTextField(
          hintText: 'Manuel Enrique Anton Cisneros',
          obscureText: false,
          icon: Icon(Icons.person),
        ),
        const CustomTextField(
          hintText: 'antonc@gmail.com',
          obscureText: false,
          icon: Icon(Icons.email_outlined),
        ),
        const CustomTextField(
          hintText: '912345678',
          obscureText: false,
          icon: Icon(Icons.numbers_outlined),
        ),
        const CustomTextField(
          hintText: '12345678',
          obscureText: false,
          icon: Icon(Icons.badge_outlined),
        ),
        const CustomTextField(
          hintText: 'FOTO DEL BREVETE',
          obscureText: false,
          icon: Icon(Icons.camera_alt_outlined),
        ),
        CustomUserActionButton(
          text: 'Guardar',
          onPressed: () {},
        ),
      ],
    );
  }
}
