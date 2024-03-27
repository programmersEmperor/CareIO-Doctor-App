import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RatingChip extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  RxBool isSelected = false.obs;
  RatingChip({
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
            : EdgeInsets.symmetric(horizontal: 3.sp),
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
                Icons.star_border_rounded,
                color:
                    isSelected.isTrue ? Colors.white : AppColors.primaryColor,
                size: 15.sp,
              ),
              SizedBox(
                width: 3.sp,
              ),
              Text(
                title,
              ),
              SizedBox(
                width: 8.sp,
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.sp)),
          labelStyle: TextStyle(
              fontSize: 9.sp,
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
