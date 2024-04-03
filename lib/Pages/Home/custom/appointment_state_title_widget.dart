import 'dart:ffi';

import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppointmentStateTitle extends StatelessWidget {
  const AppointmentStateTitle({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {

    var backgroundColor = Colors.grey.withOpacity(0.4);
    var textColor = Colors.black54;

    switch(AppointmentStatus.values[appointment.status]){
      case AppointmentStatus.pending: {

      } break;
      case AppointmentStatus.confirmed: {

      } break;
      case AppointmentStatus.accepted: {
          backgroundColor = Colors.green.withOpacity(0.2);
          textColor = Colors.amber;
      } break;
      case AppointmentStatus.rejected: {
        backgroundColor = Colors.red.withOpacity(0.2);
        textColor = Colors.redAccent;
      } break;
      case AppointmentStatus.canceled: {

      } break;
      case AppointmentStatus.completed: {
        backgroundColor = Colors.blue.withOpacity(0.2);
        textColor = Colors.teal;
      } break;
      case AppointmentStatus.unattended: {

      } break;
    }

    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.sp),
            color: textColor,
          ),
          height: 10.sp,
          width: 10.sp,
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 2.sp, left: 2.sp, right: 2.sp),
          child: Text(
              appointment.appointmentStatusTitle.tr,
              style: TextStyle(
                  color: textColor,
                  fontSize: 8.5.sp,
              )
          ),
        ),
      ],
    );
    return const SizedBox();
  }
}
