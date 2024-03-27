import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppointmentsWidget extends StatelessWidget {
  final RxList<Appointment> appointments;
  final RxBool isLoading;
  final Function onRefresh;

  const AppointmentsWidget({
    super.key,
    required this.appointments,
    required this.onRefresh,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: appointments.isEmpty ? 1 : appointments.length,
          padding: EdgeInsets.only(bottom: 9.h),
          itemBuilder: (_, index) {
            if (appointments.isEmpty) {
              return const NoDataWidget(message: "No appointment! , Book now");
            } else {
              return AppointmentCard(
                appointment: appointments[index],
                index: index,
              );
            }
          }),
    );
  }
}
