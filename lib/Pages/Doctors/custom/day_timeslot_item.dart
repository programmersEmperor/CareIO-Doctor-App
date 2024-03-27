import 'package:careio_doctor_version/Models/WidgetModels/day_time_slot.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DayTimeSLotItem extends StatelessWidget {
  final DayTimeSlot dayTimeSlot;
  final VoidCallback onTap;
  const DayTimeSLotItem({
    super.key,
    required this.dayTimeSlot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Obx(
        () => AnimatedOpacity(
          opacity: dayTimeSlot.isSelected ? 1.0 : 0.5,
          duration: 300.milliseconds,
          curve: Curves.fastEaseInToSlowEaseOut,
          child: AnimatedPadding(
            padding: dayTimeSlot.isSelected
                ? EdgeInsets.symmetric(horizontal: 4.sp)
                : EdgeInsets.symmetric(horizontal: 3.sp),
            duration: 300.milliseconds,
            child: Container(
              width: 10.w,
              decoration: BoxDecoration(
                  color: dayTimeSlot.isSelected
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor,
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Center(
                child: Text(
                  dayTimeSlot.day,
                  style: TextStyle(
                      color: dayTimeSlot.isSelected
                          ? Colors.white
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
