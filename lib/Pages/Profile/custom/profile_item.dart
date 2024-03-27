import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(7.sp),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.sp),
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8.sp)),
                child: Icon(
                  icon,
                  size: 17.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                width: 15.sp,
              ),
              Expanded(
                  child: Text(
                title,
                style: TextStyle(fontSize: 11.sp),
              )),
              Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
