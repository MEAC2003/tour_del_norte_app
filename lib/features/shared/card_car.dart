import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class CardCar extends StatelessWidget {
  final String carModel;
  final String carDescription;
  final String carImage;
  final String carPrice;
  final String carYear;
  final String carPassengers;
  final bool isAvailable;

  const CardCar({
    super.key,
    required this.carModel,
    required this.carDescription,
    required this.carImage,
    required this.carPrice,
    required this.carYear,
    required this.carPassengers,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPadding * 1.1,
        vertical: AppSize.defaultPadding,
      ),
      child: Container(
        width: double.infinity,
        height: 0.22.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.defaultRadius,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryGrey,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _AvailableCar(isAvailable),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.defaultPaddingHorizontal * 0.7,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.4.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            carModel,
                            style: AppStyles.h4(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            carDescription,
                            style: AppStyles.h5(
                              color: AppColors.darkColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: AppSize.defaultPadding * 0.2,
                                ),
                                child: Chip(
                                  avatar: Icon(
                                    Icons.person,
                                    color: AppColors.darkColor,
                                    size: AppSize.defaultIconSize * 0.25,
                                  ),
                                  label: Text(
                                    carPassengers,
                                    style: AppStyles.h5(
                                      color: AppColors.darkColor,
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSize.defaultRadius,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: AppSize.defaultPadding * 0.2,
                                ),
                                child: Chip(
                                  avatar: Icon(
                                    Icons.calendar_today_rounded,
                                    color: AppColors.darkColor,
                                    size: AppSize.defaultIconSize * 0.25,
                                  ),
                                  label: Text(
                                    carYear,
                                    style: AppStyles.h5(
                                      color: AppColors.darkColor,
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSize.defaultRadius,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text(
                              'S./$carPrice - dia',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: isAvailable
                                ? AppColors.primaryColor
                                : AppColors.darkColor50,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: isAvailable
                                    ? AppColors.primaryColor
                                    : AppColors.darkColor50,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSize.defaultRadius,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: AppAssets.googleIcon,
                          image: carImage,
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.contain,
                          placeholderScale: 0.5,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text('Error al cargar la imagen'),
                            );
                          },
                          width: 0.43.sw,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvailableCar extends StatelessWidget {
  final bool isAvailable;
  const _AvailableCar(this.isAvailable);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.27.sw,
      height: 18.h,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: AppSize.defaultPadding * 0.1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.defaultRadius),
          bottomLeft: Radius.circular(AppSize.defaultRadius),
        ),
        color: isAvailable ? AppColors.primaryColor : AppColors.darkColor50,
      ),
      child: Text(isAvailable ? 'Disponible' : 'No disponible',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
          )),
    );
  }
}
