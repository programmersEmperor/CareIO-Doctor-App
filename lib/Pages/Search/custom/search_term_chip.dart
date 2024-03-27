import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LatestSearchTermsChip extends StatelessWidget {
  const LatestSearchTermsChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(10),
      child: Text(
        "Search term one",
        style: TextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
