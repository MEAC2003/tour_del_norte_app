import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class BookingExpansionTile extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onCancel;
  final String bookingStatus; // Nuevo parámetro

  const BookingExpansionTile({
    super.key,
    required this.title,
    required this.body,
    required this.onCancel,
    required this.bookingStatus, // Añade esto
  });

  @override
  Widget build(BuildContext context) {
    // Determina si el botón debe estar habilitado
    bool isButtonEnabled =
        bookingStatus != 'cancelado' && bookingStatus != 'pagado';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPaddingHorizontal * 1.5,
        vertical: AppSize.defaultPadding,
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkColor,
              width: 0.5,
            ),
          ),
        ),
        child: ExpansionTile(
          title: Text(title),
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    body,
                    style: AppStyles.h4(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: AppSize.defaultPadding),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? onCancel
                          : null, // Deshabilita el botón si no está habilitado
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isButtonEnabled ? Colors.red : Colors.grey,
                      ),
                      child: Text(
                        'Cancelar Reserva',
                        style: AppStyles.h4(
                          color: isButtonEnabled
                              ? AppColors.primaryGrey
                              : AppColors.darkColor50,
                          fontWeight: FontWeight.w500,
                        ),
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
