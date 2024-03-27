import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CategoryGridElement extends StatelessWidget {
  final String title, desc, iconPath;
  final VoidCallback onTap;
  const CategoryGridElement({
    super.key,
    required this.title,
    required this.desc,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: AppColors.secondaryColor,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: MediaQuery.of(context).size.height  * 0.050,
                  width: MediaQuery.of(context).size.width * 0.03,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  title.capitalize!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 8.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
