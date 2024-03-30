import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_card.dart';
import 'package:careio_doctor_version/Pages/Home/custom/my_health_center_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MyHealthCentersWidget extends StatelessWidget {
  final RxList<HealthCenter> myHealthCenters;
  final bool isLoading;
  final bool isRequests;
  final Function onRefresh;

  const MyHealthCentersWidget({
    super.key,
    required this.myHealthCenters,
    required this.onRefresh,
    required this.isLoading,
    this.isRequests = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: myHealthCenters.isEmpty ? 1 : myHealthCenters.length,
          padding: EdgeInsets.only(bottom: 9.h),
          itemBuilder: (_, index) {
            if (myHealthCenters.isEmpty) {
              return NoDataWidget(message: "No Health Center Yet!", top: 35.h,);
            } else {
              return MyHealthCenterCard(
                myHealthCenter: myHealthCenters[index],
                index: index,
                isRequest: isRequests,
              );
            }
          }),
    );
  }
}
