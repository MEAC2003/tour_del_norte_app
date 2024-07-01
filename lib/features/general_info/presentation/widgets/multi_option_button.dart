import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/features/general_info/data/models/information.dart';
import 'package:tour_del_norte_app/features/general_info/presentation/widgets/widgets.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class MultiOptionButton extends StatefulWidget {
  final Information information;
  const MultiOptionButton({super.key, required this.information});

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
      child: Column(
        children: [
          SegmentedButton(
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
          if (selectedView == ContentView.actualidad)
            SatisfiedCustomers(information: widget.information)
          else if (selectedView == ContentView.nosotros)
            AboutUs(information: widget.information)
          else if (selectedView == ContentView.creditos)
            Credits(information: widget.information),
        ],
      ),
    );
  }
}
