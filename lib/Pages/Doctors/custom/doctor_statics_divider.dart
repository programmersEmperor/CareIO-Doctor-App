import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorStaticsDivider extends StatelessWidget {
  const DoctorStaticsDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sp,
      height: 40.sp,
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.sp)),
    );
  }
}
