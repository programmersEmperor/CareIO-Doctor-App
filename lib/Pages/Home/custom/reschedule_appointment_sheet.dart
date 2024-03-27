import 'package:careio_doctor_version/Components/SharedWidgets/custom_datepicker.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_colored_button.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Booking/book_appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Booking/custom/book_timeslot_chip.dart';
import 'package:careio_doctor_version/Pages/Doctors/controller/doctor_profile_ui_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_state_title_widget.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RescheduleAppointmentConfirmSheet extends StatelessWidget {
  const RescheduleAppointmentConfirmSheet({
    super.key,
    required this.appointment,
    required this.loading,
    required this.onTap,
  });

  final Appointment appointment;
  final RxBool loading;
  final Function(String, String) onTap;

  @override
  Widget build(BuildContext context) {
    BookAppointmentController controller = Get.put(BookAppointmentController(), tag: "reschedule");
    controller.getTimes(id: appointment.doctor.id!, clinicId: appointment.healthCenter.clinics.first.id!);
    controller.getDoctorDetails(id: appointment.doctor.id!);

    return AnimatedSize(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.ease,
      clipBehavior: Clip.none,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 25.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                topRight: Radius.circular(15.sp))),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            AutoSizeText(
              "Reschedule appointment",
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
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.sp),
                      child: Text(
                        appointment.doctor.specialism!.name,
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 160.sp,
                      color: AppColors.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(17.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          "Available timeslots",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => AutoSizeText(
                                  controller.day.value,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1.sp),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                  ),
                                  maximumSize:
                                      MaterialStatePropertyAll(Size(25.w, 4.h)),
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(25.w, 4.h)),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.zero)),
                              onPressed: () {
                                Get.dialog(
                                  Obx(() => controller.isLoading.isTrue
                                      ? Center(
                                        child: SpinKitFadingCircle(
                                          color: AppColors.primaryColor,
                                        ),
                                  )   : CustomDatePicker(
                                    selectableDayPredicate: (date){
                                      if(date.isBefore(DateTime.now().toLocal())){
                                        return false;
                                      }
                                      final List<HealthCenter> healthCenters = controller.filterHealthCentersByDay(healthCenters: controller.doctorDetails!.healthCenters, day: date.weekday, clinicId: appointment.healthCenter.clinics.first.id!);
                                      return healthCenters.isNotEmpty;
                                    },
                                    onDateChange: (date) {
                                      controller.handleDayTitle(date: date);
                                      controller.getTimes(
                                          day: date,
                                          id: appointment.doctor.id!,
                                          clinicId: appointment.healthCenter.clinics.first.id!);
                                      Get.close(0);
                                    },
                                  )),
                                  useSafeArea: false,
                                );
                              },
                              child: Text(
                                "Another date",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Obx(
                          () => controller.isLoading.isTrue
                              ? Center(
                                  child: SpinKitFadingCircle(
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : controller.times.isEmpty
                              ? Center(
                                child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Text(AppStrings.notAvailableOnThisDay.tr, style: TextStyle(fontSize: 8.sp),)
                              ),
                            ) : Wrap(
                                  key: const ValueKey<int>(5),
                                  spacing: 7.sp,
                                  children: [
                                    for (var i = 0;
                                        i < controller.times.length;
                                        i++) ...[
                                      Obx(
                                        () => BookTimeSlot(
                                          time: controller.times[i],
                                          onTapTime: (time) =>
                                              controller.onTapTime(time),
                                          isSelected:
                                              controller.selectedTime == null
                                                  ? false.obs
                                                  : (controller.selectedTime!
                                                              .value ==
                                                          controller.times[i])
                                                      .obs,
                                        ),
                                      ),
                                    ]
                                  ],
                                ).animate().fade(
                                  duration: const Duration(milliseconds: 500)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            MainColoredButton(
              isLoading: loading,
              text: "Confirm reschedule",
              onPress: () {
                onTap(controller.selectDate, controller.selectedTime.value.time);
              },
            ),
          ],
        ),
      ),
    );
  }
}
