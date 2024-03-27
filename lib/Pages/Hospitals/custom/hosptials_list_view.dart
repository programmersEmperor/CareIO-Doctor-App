import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HospitalListVIew extends StatelessWidget {
  final List<HealthCenter> healthCenters;
  const HospitalListVIew({super.key, required this.healthCenters});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        itemCount: healthCenters.isEmpty ? 1 : healthCenters.length,
        itemBuilder: (_, index) {
          if (healthCenters.isEmpty) {
            return const NoDataWidget(
                message: "No health centers found, Please try again latter ");
          } else {
            return HospitalCard(
              healthCenter: healthCenters[index],
            );
          }
        });
  }
}
