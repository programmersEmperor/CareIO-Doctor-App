import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/WidgetModels/day_time_slot.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/day_timeslot_item.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/doctor_healthCenter_active_times_widget.dart';
import 'package:careio_doctor_version/Pages/Home/controller/appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Home/controller/my_health_centers_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_state_title_widget.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospital_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../Components/SharedWidgets/cancel_button.dart';

class MyHealthCenterCard extends StatefulWidget {
  final int index;
  final HealthCenter myHealthCenter;
  final Function(HealthCenter)? onAccept;
  final Function(HealthCenter)? onCancel;
  final bool isRequest;

  MyHealthCenterCard({
    super.key,
    required this.index,
    required this.myHealthCenter,
    this.isRequest = false,
    this.onAccept,
    this.onCancel,
  });

  @override
  State<MyHealthCenterCard> createState() => _MyHealthCenterCardState();
}

class _MyHealthCenterCardState extends State<MyHealthCenterCard> {
  final showDetails = false.obs;
  final RxBool isLoading = false.obs;

  RxInt currentDayTimeSlotSelectedIndex = 0.obs;

  final List<DayTimeSlot> dayTimeSlotList = [
    DayTimeSlot('Sun', true.obs),
    DayTimeSlot('Mon', false.obs),
    DayTimeSlot('Tue', false.obs),
    DayTimeSlot('Wed', false.obs),
    DayTimeSlot('Thu', false.obs),
    DayTimeSlot('Fri', false.obs),
    DayTimeSlot('Sat', false.obs),
  ];

  void onTapDayTimeSlot(int index) {
    if (currentDayTimeSlotSelectedIndex.value == index) return;
    dayTimeSlotList[index].setIsSelected = true;
    dayTimeSlotList[currentDayTimeSlotSelectedIndex.value].setIsSelected = false;
    currentDayTimeSlotSelectedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.sp, left: 10.sp, right: 10.sp),
      child: Obx(()=> Opacity(opacity: isLoading.isTrue? 0.7 : 1, child: Card(

        elevation: 15,
        shadowColor: Colors.grey.shade100,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: 15.sp, left: 10.sp, right: 10.sp, bottom: 2.sp),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.sp
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "${widget.myHealthCenter.name}",
                          style: TextStyle(
                              fontSize: 11.sp, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.sp),
                          child: Text(
                            widget.myHealthCenter.clinics.first.name!,
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
                        image: widget.myHealthCenter.avatar == null? null : DecorationImage(
                          image: CachedNetworkImageProvider(widget.myHealthCenter.avatar!),
                          fit: BoxFit.cover,
                        ),
                        color: AppColors.secondaryColor,
                      ),
                      child: widget.myHealthCenter.avatar == null ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.all(3.sp),
                          child: SvgPicture.asset(
                            'assets/svgs/hospital_icon.svg',
                            height: 15.sp,
                            width: 15.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 5.sp, right: 5.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.local_hospital,
                            color: AppColors.primaryColor,
                            size: 12.sp,
                          ),
                          SizedBox(
                            width: 2.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.sp, left: 2.sp, right: 2.sp),
                            child: Text(
                              widget.myHealthCenter.type!.value.tr,
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
                            Boxicons.bxs_calendar,
                            color: AppColors.primaryColor,
                            size: 12.sp,
                          ),
                          SizedBox(
                            width: 2.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.sp, left: 2.sp, right: 2.sp),
                            child: Text(
                              widget.myHealthCenter.completedAppointment.toString(),
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
                            Icons.star,
                            color: Colors.orange,
                            size: 12.sp,
                          ),
                          SizedBox(
                            width: 2.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.sp, left: 2.sp, right: 2.sp),
                            child: Text(
                              widget.myHealthCenter.rating!.toStringAsFixed(1),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 8.5.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // AppointmentStateTitle(appointment: appointment),
                  ],
                ),
              ),
              Obx(
                    () => AnimatedSize(
                  duration: 600.milliseconds,
                  curve: Curves.linearToEaseOut,
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.only(top: 5.sp),
                    child: showDetails.isFalse
                        ? null
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.sp),
                          child: SizedBox(
                            height: 5.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dayTimeSlotList.length,
                              itemBuilder: (_, index) =>
                                  DayTimeSLotItem(
                                    dayTimeSlot: dayTimeSlotList[index],
                                    onTap: () => onTapDayTimeSlot(index),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.sp),
                          child: Obx(
                                  (){
                                // final List<HealthCenter> healthCenters = controller.filterHealthCentersByDay(healthCenters: controller.doctor.healthCenters, day: controller.currentSelectedIndex.value);
                                return AnimatedSwitcher(
                                  duration: 300.milliseconds,
                                  child: Column(
                                    children: [
                                      DoctorHealthCenterActiveTimeWidget(
                                          healthCenter: widget.myHealthCenter,
                                          day: currentDayTimeSlotSelectedIndex.value,
                                          showHealthCenterCard: false,
                                          fallback: Center(
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 15),
                                                child: Text(AppStrings.notActiveOnThisDay.tr, style: TextStyle(fontSize: 8.sp),)
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showDetails(!showDetails.value),
                      style: ButtonStyle(
                          elevation: const MaterialStatePropertyAll(0),
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).scaffoldBackgroundColor),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp)))),
                      child: Obx(()=>Text(
                        showDetails.isTrue ? AppStrings.showLess.tr : AppStrings.showMore.tr,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                  if(widget.isRequest)...[
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try{
                            if(widget.onAccept != null && isLoading.isFalse) {
                              isLoading(true);
                              await widget.onAccept!(widget.myHealthCenter);
                              isLoading(false);
                            }
                          }
                          catch(e){
                            isLoading(false);
                            showSnack(title: AppStrings.cannotCompleteOperation, description: "${e}");
                          }
                        },
                        style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(
                                AppColors.primaryColor),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.sp)))),
                        child: Text(
                          AppStrings.accept.tr,
                          style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CancelButton(
                        onTap: () async {
                          try{
                            if(widget.onAccept != null && isLoading.isFalse) {
                              isLoading(true);
                              await widget.onAccept!(widget.myHealthCenter);
                              isLoading(false);
                            }
                          }
                          catch(e){
                            isLoading(false);
                            showSnack(title: AppStrings.cannotCompleteOperation, description: "${e}");
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
            ],
          ),
        ),
      ),)),
    );
  }
}
