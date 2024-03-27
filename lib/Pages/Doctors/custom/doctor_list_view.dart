import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Pages/Doctors/controller/doctors_page_controller.dart';
import 'package:careio_doctor_version/Pages/Doctors/custom/doctor_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class DoctorsListView extends StatelessWidget {
  final List<Doctor> doctors;
  const DoctorsListView({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    DoctorsPageController controller = Get.find<DoctorsPageController>();
    return Padding(
      padding: EdgeInsets.only(bottom: 0.sp),
      child: RefreshIndicator(
        onRefresh: () =>
            Future.sync(() => controller.pagingController.refresh()),
        child: PagedListView<int, Doctor>(
          // itemCount: doctors.isEmpty ? 1 : doctors.length,
          // itemBuilder: (_, index) {
          //   if (doctors.isEmpty) {
          //     return NoDataWidget(
          //         message: "No doctors found, Please try again latter ");
          //   } else {
          //     return DoctorListWidget(
          //       doctor: doctors[index],
          //     );
          //   }
          // },
          builderDelegate: PagedChildBuilderDelegate<Doctor>(
            itemBuilder: (context, item, index) => DoctorListWidget(
              doctor: item,
            ),
          ),
          pagingController: controller.pagingController,
        ),
      ),
    );
  }
}
