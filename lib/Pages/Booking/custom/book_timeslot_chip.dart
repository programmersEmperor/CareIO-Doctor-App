import 'package:careio_doctor_version/Models/BookAvailableTime.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BookTimeSlot extends StatelessWidget {
  final BookAvailableTime time;
  final Function onTapTime;
  RxBool isSelected = false.obs;
  BookTimeSlot({
    super.key,
    required this.time,
    required this.onTapTime,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPadding(
        padding: isSelected.isTrue
            ? EdgeInsets.symmetric(horizontal: 5.sp)
            : EdgeInsets.zero,
        duration: 500.milliseconds,
        curve: Curves.fastLinearToSlowEaseIn,
        child: ActionChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 5.sp,
              ),
              Icon(
                Icons.timer_sharp,
                color:
                    isSelected.isTrue ? Colors.white : AppColors.primaryColor,
                size: 15.sp,
              ),
              SizedBox(
                width: 3.sp,
              ),
              Text(
                time.time12,
              ),
              SizedBox(
                width: 8.sp,
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.sp)),
          labelStyle: TextStyle(
              fontSize: 7.5.sp,
              color: isSelected.isTrue ? Colors.white : Colors.black54),
          visualDensity: VisualDensity.comfortable,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          onPressed: time.isAvailable
              ? () {
                  // isSelected(!isSelected.value);
                  onTapTime(time);
                }
              : null,
          backgroundColor:
              isSelected.isTrue ? AppColors.primaryColor : Colors.white,
          disabledColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
