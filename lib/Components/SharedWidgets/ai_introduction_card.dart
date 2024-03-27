import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AiIntroductionCard extends StatelessWidget {
  final String header, subtitle;
  final IconData icon;
  const AiIntroductionCard({
    super.key,
    required this.header,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.sp),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: 10.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style:
                        TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 8.5.sp, color: Colors.black38),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
