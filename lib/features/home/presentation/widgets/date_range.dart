import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';
import 'package:tour_del_norte_app/features/home/presentation/widgets/widgets.dart';

class DateRange extends StatefulWidget {
  final DateTime initialStartDate;
  final List<DateTime> disabledDates;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onDateTimeRangeSelected;

  const DateRange({
    super.key,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onDateTimeRangeSelected,
    required this.disabledDates,
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
    DateTime initialDate = isStart ? startDateTime : endDateTime;

    // Encuentra la próxima fecha disponible si la inicial está inhabilitada
    while (widget.disabledDates.any((disabledDate) =>
        initialDate.year == disabledDate.year &&
        initialDate.month == disabledDate.month &&
        initialDate.day == disabledDate.day)) {
      initialDate = initialDate.add(const Duration(days: 1));
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      selectableDayPredicate: (DateTime date) {
        return !widget.disabledDates.any((disabledDate) =>
            date.year == disabledDate.year &&
            date.month == disabledDate.month &&
            date.day == disabledDate.day);
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime;
      if (isStart) {
        pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(startDateTime),
        );
      }

      setState(() {
        if (isStart) {
          startDateTime = pickedTime != null
              ? DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                )
              : DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
          // Set end date to the next day at the same time
          endDateTime = startDateTime.add(const Duration(days: 1));
        } else {
          // For end date, only allow changing the date, not the time
          endDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            startDateTime.hour,
            startDateTime.minute,
          );
        }
      });
      widget.onDateTimeRangeSelected(startDateTime, endDateTime);
    }
  }
}
