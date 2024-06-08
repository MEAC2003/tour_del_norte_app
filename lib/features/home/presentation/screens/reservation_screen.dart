import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //poner un alto de 56
          toolbarHeight: 56.h,
          leading: IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5),
            icon:
                const Icon(Icons.arrow_back_ios, color: AppColors.primaryGrey),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            'Información',
            style: AppStyles.h3(
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: AppSize.defaultPadding,
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
              const DateRange(),
              const CustomCTAButton(text: 'Consultar Reserva')
            ],
          ),
        ));
  }
}
