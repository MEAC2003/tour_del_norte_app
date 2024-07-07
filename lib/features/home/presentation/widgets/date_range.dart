import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';

class DateRange extends StatefulWidget {
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onDateTimeRangeSelected;

  const DateRange({
    super.key,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onDateTimeRangeSelected,
  });

  @override
  State<DateRange> createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  late DateTime startDateTime;
  late DateTime endDateTime;

  @override
  void initState() {
    super.initState();
    startDateTime = widget.initialStartDate;
    endDateTime = widget.initialEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPaddingHorizontal * 1.5,
        vertical: AppSize.defaultPadding * 0.75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rango de fechas y horas:',
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
                  onPressed: () => pickDateTime(isStart: true),
                  text: _formatDateTime(startDateTime),
                ),
              ),
              SizedBox(width: AppSize.defaultPadding),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () => pickDateTime(isStart: false),
                  text: _formatDateTime(endDateTime),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> pickDateTime({required bool isStart}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? startDateTime : endDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(isStart ? startDateTime : endDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          if (isStart) {
            startDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            // Set end time to the same as start time
            endDateTime = startDateTime;
          } else {
            endDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
        });
        widget.onDateTimeRangeSelected(startDateTime, endDateTime);
      }
    }
  }
}
