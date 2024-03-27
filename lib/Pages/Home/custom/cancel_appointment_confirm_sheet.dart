import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_state_title_widget.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CancelAppointmentConfirmSheet extends StatelessWidget {
  const CancelAppointmentConfirmSheet({
    super.key,
    required this.appointment,
    required this.loading,
    required this.onTap,
  });

  final Appointment appointment;
  final RxBool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 25.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Cancel appointment for",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    appointment.doctor.name!,
                    style:
                        TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.sp),
                    child: Text(
                      appointment.healthCenter.name!,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 32.sp,
                width: 32.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: appointment.doctor.avatar == null? null : DecorationImage(
                    image: CachedNetworkImageProvider(appointment.doctor.avatar!),
                    fit: BoxFit.cover,
                  ),
                  color: AppColors.secondaryColor,
                ),
                child: appointment.doctor.avatar == null ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: SvgPicture.asset(
                      'assets/svgs/doctor_icon.svg',
                      height: 15.sp,
                      width: 15.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ) : const SizedBox.shrink(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Boxicons.bxs_calendar,
                        color: AppColors.primaryColor,
                        size: 12.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 2.sp, left: 2.sp, right: 2.sp),
                        child: Text(
                          appointment.date,
                          style: TextStyle(
                              color: Colors.black54, fontSize: 8.5.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Boxicons.bxs_time,
                        color: AppColors.primaryColor,
                        size: 12.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 2.sp, left: 2.sp, right: 2.sp),
                        child: Text(
                          appointment.time12,
                          style: TextStyle(
                              color: Colors.black54, fontSize: 8.5.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                AppointmentStateTitle(appointment: appointment),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          MainColoredButton(
            isLoading: loading,
            text: "Confirm cancellation",
            onPress: onTap,
          ),
        ],
      ),
    );
  }
}
