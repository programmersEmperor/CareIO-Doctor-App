import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/doctor_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorGridView extends StatelessWidget {
  final List<Doctor> doctors;
  const DoctorGridView({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: doctors.isEmpty ? 0.sp : 15.sp),
      child: GridView.builder(
          itemCount: doctors.isEmpty ? 1 : doctors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: doctors.isEmpty ? 1 : 2,
              mainAxisSpacing: 8.sp,
              crossAxisSpacing: 10.sp,
              mainAxisExtent: doctors.isEmpty ? 100.h : 35.h),
          itemBuilder: (_, index) {
            if (doctors.isEmpty) {
              return NoDataWidget(
                  message: "No doctors found, Please try again latter ",
                top: 35.h,
              );
            } else {
              return DoctorGridWidget(
                doctor: doctors[index],
              );
            }
          }),
    );
  }
}
