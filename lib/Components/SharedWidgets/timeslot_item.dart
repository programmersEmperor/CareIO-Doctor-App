import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TimeSlotItem extends StatelessWidget {
  final bool isDisabled;
  final String time;
  final Color backgroundColor;
  final Color fontColor;
  final Color? iconColor;
  const TimeSlotItem({
    super.key,
    this.isDisabled = false,
    required this.time,
    this.backgroundColor = Colors.white,
    this.fontColor = Colors.black54,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      child: ActionChip(
        label: Text(
          time,
        ),
        labelStyle: TextStyle(fontSize: 7.5.sp, color: fontColor),
        avatar: Icon(
          Icons.watch_later_outlined,
          color: iconColor ?? AppColors.primaryColor,
          size: 15.sp,
        ),
        onPressed: isDisabled ? null : () {},
        backgroundColor: backgroundColor,
        disabledColor: Colors.grey.shade200,
      ),
    );
  }
}
