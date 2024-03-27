import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/timeslot_item.dart';
import 'package:careio_doctor_version/Models/ActiveTime.dart';
import 'package:careio_doctor_version/Models/Clinic.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospital_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DoctorHealthCenterActiveTimeWidget extends StatelessWidget{
  final HealthCenter healthCenter;
  final int day;
  final List<ActiveTimes> activeTimes = [];
  DoctorHealthCenterActiveTimeWidget({super.key, required this.healthCenter, required this.day});


  @override
  Widget build(BuildContext context){
    for (Clinic clinic in healthCenter.clinics){
      activeTimes.addAll(clinic.activeTimes.where((activeTime) => activeTime.day == day));
    }

    if(activeTimes.isEmpty){
      return const SizedBox.shrink();
    }

    return Column(
          children: [
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
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Wrap(
                children: activeTimes.map((time) => TimeSlotItem(time: "${time.from} - ${time.to}")).toList(),
              ),
            )
          ],
        );
  }
}