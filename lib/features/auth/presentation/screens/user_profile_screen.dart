import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _UserProfileView();
  }
}

class _UserProfileView extends StatelessWidget {
  const _UserProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
          style: AppStyles.h1(
              color: AppColors.darkColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
        child: Column(
          children: [
            Divider(
              color: AppColors.darkColor50,
              thickness: 0.5.h,
            ),
            const UserInfoRow(
              title: 'Nombre',
              text: 'Manuel Enrique Anton Cisneros',
            ),
            const UserInfoRow(
              title: 'Correo electrónico',
              text: 'antonc@gmail.com',
            ),
            const UserInfoRow(
              title: 'Numero de teléfono',
              text: '912345678',
            ),
            const UserInfoRow(
              title: 'DNI',
              text: '12345678',
            ),
            const ImageCard(
              imgPath: 'https://www.w3schools.com/w3images/avatar2.png',
            ),
            const CustomUserActionButton(
              text: 'Editar datos',
            ),
          ],
        ),
      ),
    );
  }
}
