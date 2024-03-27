import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ClinicChip extends StatelessWidget {
  final String title;
  RxBool isSelected = false.obs;
  final VoidCallback onTap;
  ClinicChip({
    super.key,
    required this.title,
    required this.onTap,
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
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 9.sp),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.sp)),
          labelStyle: TextStyle(
              fontSize: 7.5.sp,
              color: isSelected.isTrue ? Colors.white : Colors.black54),
          visualDensity: VisualDensity.comfortable,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          onPressed: () {
            onTap();
          },
          backgroundColor:
              isSelected.isTrue ? AppColors.primaryColor : Colors.white,
          disabledColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
