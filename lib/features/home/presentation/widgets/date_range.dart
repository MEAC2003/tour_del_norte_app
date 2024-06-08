import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';

class DateRange extends StatefulWidget {
  const DateRange({super.key});

  @override
  State<DateRange> createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPaddingHorizontal * 1.5,
        vertical: AppSize.defaultPadding * 0.75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rango de fechas:',
            style: AppStyles.h3(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: pickDataRange,
                  text: '${start.year}/${start.month}/${start.day}',
                ),
              ),
              SizedBox(width: AppSize.defaultPadding),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: pickDataRange,
                  text: '${end.year}/${end.month}/${end.day}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> pickDataRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }
}
