import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.experience,
  });

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                experience.position ?? "",
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.primaryColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                experience.place ?? "",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 9.sp,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      experience.from.split(' ').first.trim(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                          fontSize: 8.sp),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  Text('-'),
                  Chip(
                    label: Text(
                      experience.to.split(' ').first.trim(),
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 8.sp),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
