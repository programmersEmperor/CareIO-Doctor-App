import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Hospitals/custom/hospital_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HospitalGridView extends StatelessWidget {
  final List<HealthCenter> healthCenters;
  const HospitalGridView({super.key, required this.healthCenters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.sp),
      child: GridView.builder(
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.sp,
              crossAxisSpacing: 10.sp,
              mainAxisExtent: 35.h),
          itemBuilder: (_, index) {
            if (healthCenters.isEmpty) {
              return const NoDataWidget(
                  message: "No health centers found, Please try again latter ");
            } else {
              return HospitalGridWidget(
                healthCenter: healthCenters[index],
              );
            }
          }),
    );
  }
}
