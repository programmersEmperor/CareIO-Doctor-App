import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/timeslot_item.dart';
import 'package:careio_doctor_version/Models/ActiveTime.dart';
import 'package:careio_doctor_version/Models/Clinic.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospital_profile.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DoctorHealthCenterActiveTimeWidget extends StatelessWidget{
  final HealthCenter healthCenter;
  final int day;
  final bool showHealthCenterCard;
  final Widget fallback;
  final List<ActiveTimes> activeTimes = [];
  DoctorHealthCenterActiveTimeWidget({super.key, required this.healthCenter, required this.day, this.showHealthCenterCard = true, this.fallback = const SizedBox.shrink()});


  @override
  Widget build(BuildContext context){
    for (Clinic clinic in healthCenter.clinics){
      activeTimes.addAll(clinic.activeTimes.where((activeTime) => activeTime.day == day));
    }

    if(activeTimes.isEmpty){
      return fallback;
    }

    return Column(
          children: [
            if(showHealthCenterCard)...[
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0.sp,
                  bottom: 10.0.sp,
                ),
                child: SizedBox(
                  child: InkWell(
                    onTap: () => Get.toNamed(
                        HospitalProfile.id,
                        arguments: [
                          {'index': '1'}
                        ]),
                    child: HospitalCard(
                      healthCenter: healthCenter,
                    ),
                  ),
                ),
              )
            ],
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Wrap(
                children: activeTimes.map((time) =>
                    TimeSlotItem(
                      time: "${time.time12(time.from)} - ${time.time12(time.to)}",
                      backgroundColor: AppColors.primaryColor,
                      fontColor: Colors.white,
                      iconColor: Colors.white,
                    )).toList(),
              ),
            )
          ],
        );
  }
}