import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Pages/Pharmacies/pharmacy_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TopRatedPharmacyCard extends StatelessWidget {
  final int index;
  const TopRatedPharmacyCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.sp,
      shadowColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 7.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.sp),
                  child: Image.asset(
                    "assets/images/hosptial.jpg",
                    height: 15.h,
                    fit: BoxFit.cover,
                    width: 33.w,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                SizedBox(
                  width: 33.w,
                  child: AutoSizeText(
                    "صيدليات اليمن السعيد",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primaryColor,
                      size: 10,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Sana'a Yemen",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 7.sp,
                          color: Colors.black45),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.sp,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                SizedBox(
                  width: 33.w,
                  height: 20.sp,
                  child: MainColoredButton(
                    text: "view details",
                    onPress: () => Get.toNamed(PharmacyProfile.id, arguments: [
                      {'index': index}
                    ]),
                    elevation: 0.0,
                  ),
                ),
              ],
            ),
          ),
          Positioned.directional(
            top: 4,
            end: 4,
            textDirection: TextDirection.ltr,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "4.8",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
