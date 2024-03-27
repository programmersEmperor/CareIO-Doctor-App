import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Pages/Doctors/doctor_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TopRequestedDoctorsCard extends StatelessWidget {
  final Doctor doctor;
  const TopRequestedDoctorsCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Hero(
                    tag: "doc${doctor.id}",
                    child: doctor.avatar == null?
                    SizedBox(
                      height: 50.sp,
                      width: 50.sp,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SvgPicture.asset(
                            'assets/svgs/doctor_icon.svg',
                            color: AppColors.primaryColor,
                          )
                        ),
                      ),
                    )
                        : Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(
                            color: AppColors.scaffoldColor, width: 3.sp),
                        image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  '${doctor.avatar}',
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.0.sp, right: 5.0.sp, top: 0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${doctor.name}",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3.5.sp),
                            child: Row(
                              children: [
                                Text(
                                  doctor.specialism!.name,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 8.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  doctor.degree!.name!,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3.5.sp),
                            child: Row(
                              children: [
                                if(doctor.rating != null)...[
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 10.sp,
                                  ),
                                  SizedBox(
                                    width: 2.sp,
                                  ),
                                  Text(
                                    doctor.rating!.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ],
                                SizedBox(
                                  width: 10.sp,
                                ),
                                if(doctor.completedAppointments != null)...[
                                  Icon(
                                    Icons.timer,
                                    color: AppColors.primaryColor,
                                    size: 10.sp,
                                  ),
                                  SizedBox(
                                    width: 2.sp,
                                  ),
                                  Text(
                                    doctor.completedAppointments!.toString(),
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              MainColoredButton(
                text: AppStrings.bookNow.tr,
                elevation: 0,
                onPress: ()=> Get.toNamed(DoctorProfile.id, arguments: [
                  {'index': doctor.id.toString()}
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
