import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BackCircleButton extends StatelessWidget {
  const BackCircleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.only(
            left: Get.locale == const Locale('ar', 'AR') ? 2.sp : 10.sp,
            top: 5.sp,
            bottom: 5.sp,
            right: 5.sp),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.primaryColor,
          size: 12.sp,
        ),
      ),
    );
  }
}
