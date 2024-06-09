import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/shared/shared.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class BusinessInformationScreen extends StatelessWidget {
  const BusinessInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryGrey),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Tour del Norte',
          style: AppStyles.h3(
            color: AppColors.primaryGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding * 2),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                AppAssets.logo,
                width: 234,
                height: 234,
              ),
            ),
            const MultiOptionButton(),
            const CustomCTAButton(text: 'Facebook'),
          ],
        ),
      ),
    );
  }
}

class MultiOptionButton extends StatefulWidget {
  const MultiOptionButton({
    super.key,
  });

  @override
  State<MultiOptionButton> createState() => _MultiOptionButtonState();
}

enum ContentView { actualidad, nosotros, creditos }

class _MultiOptionButtonState extends State<MultiOptionButton> {
  ContentView selectedView = ContentView.actualidad;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPaddingHorizontal,
        vertical: AppSize.defaultPadding,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        child: SegmentedButton(
          style: SegmentedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.primaryGrey,
            selectedBackgroundColor: AppColors.primaryGrey,
            selectedForegroundColor: AppColors.primaryColor,
          ),
          segments: [
            ButtonSegment(
              value: ContentView.actualidad,
              label: Text(
                'Actualidad',
                style: AppStyles.h5(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              icon: const Icon(Icons.article_outlined),
            ),
            ButtonSegment(
              value: ContentView.nosotros,
              label: Text(
                'Nosotros',
                style: AppStyles.h5(
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(Icons.people_outline),
            ),
            ButtonSegment(
              value: ContentView.creditos,
              label: Text(
                'Créditos',
                style: AppStyles.h5(
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(Icons.credit_card_outlined),
            ),
          ],
          selected: {
            selectedView,
          },
          onSelectionChanged: (newSelection) {
            setState(() {
              selectedView = newSelection.first;
            });
          },
        ),
      ),
    );
  }
}
