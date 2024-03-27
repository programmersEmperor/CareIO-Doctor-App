import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospital_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';

class HospitalGridWidget extends StatelessWidget {
  final HealthCenter healthCenter;
  const HospitalGridWidget({
    super.key,
    required this.healthCenter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(HospitalProfile.id, arguments: [
        {'index': healthCenter.id.toString()}
      ]),
      child: SizedBox(
        height: 35.h,
        width: 39.w,
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.sp),
                  child: Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: "hospital${healthCenter.id}",
                        child: Image.asset(
                          'assets/images/hosptial.jpg',
                          fit: BoxFit.cover,
                          width: 35.w,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5.sp, right: 5.sp, top: 8.sp),
                    child: AutoSizeText(
                      "Saudi German hospitals",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflowReplacement: Marquee(
                        text: "Saudi German hospitals",
                        blankSpace: 20.0,
                        accelerationCurve: Curves.easeOut,
                        velocity: 50.0,
                        startPadding: 2.0,
                        showFadingOnlyWhenScrolling: true,
                        startAfter: 5.seconds,
                        fadingEdgeEndFraction: 0.5.sp,
                        fadingEdgeStartFraction: 0.5.sp,
                        pauseAfterRound: 5.seconds,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 3.5.sp, left: 5.sp, right: 5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 10.sp,
                      ),
                      Text(
                        "3.4 (134 Review)",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 5.sp, right: 5.sp, top: 2.sp, bottom: 2.sp),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 9.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 2.sp,
                        ),
                        Text(
                          "location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 8.sp,
                              color: Colors.black45),
                        ),
                      ],
                    ),
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
