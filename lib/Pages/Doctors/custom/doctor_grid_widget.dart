import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Pages/Doctors/doctor_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';

class DoctorGridWidget extends StatelessWidget {
  final Doctor doctor;
  const DoctorGridWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(DoctorProfile.id, arguments: [
        {'index': doctor.id.toString()}
      ]),
      child: SizedBox(
        width: 39.w,
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.sp, right: 10.sp, left: 10.sp, bottom: 5.sp),
                  child: Container(
                    height: 15.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.secondaryColor,
                    ),
                    child: Padding(
                      padding: doctor.avatar == null? const EdgeInsets.all(20) : const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: doctor.avatar == null
                            ? SvgPicture.asset(
                          'assets/svgs/doctor_icon.svg',
                          color: AppColors.primaryColor,
                        )
                            : CachedNetworkImage(
                          fadeInCurve: Curves.linear,
                          placeholder: (context, string) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: SvgPicture.asset(
                              'assets/svgs/doctor_icon.svg',
                              color: AppColors.primaryColor,

                            ),
                          ),
                          fit: BoxFit.cover,
                          width: 31.w,
                          imageUrl: doctor.avatar!,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 2.sp),
                  child: Column(
                    children: [
                      AutoSizeText(
                        doctor.name!,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        overflowReplacement: Marquee(
                          text: doctor.name!,
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
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        (doctor.degree?.name ?? "") + " " + (doctor.specialism?.name ?? ""),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 7.sp,
                            color: Colors.black45),
                      ),
                    ],
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
