import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/page_header.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/refresh_indicator_widget.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Pages/Home/controller/appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/AppointmentsWidget.dart';
import 'package:careio_doctor_version/Pages/Home/custom/appointment_card.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppointmentController controller = Get.put(AppointmentController());
    return Column(
      children: [
        PageHeader(heading: AppStrings.myAppointments.tr),
        Padding(
          padding: EdgeInsets.only(
            top: 15.sp,
            left: 10.sp,
            right: 10.sp,
          ),
          child: Container(
            height: 35.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: EdgeInsets.all(2.sp),
              child: Material(
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Theme(
                  data: ThemeData().copyWith(
                    splashColor: Colors.transparent,
                    useMaterial3: false,
                    highlightColor: Colors.transparent,
                  ),
                  child: TabBar(
                    tabs: AppointmentTypes.values.map((type) => Tab(
                      text: type.label.tr,
                    )).toList(),
                    controller: controller.tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    padding: EdgeInsets.zero,
                    labelStyle: TextStyle(fontSize: 10.sp, fontFamily: GoogleFonts.rubik().fontFamily),
                    enableFeedback: false,
                    indicatorPadding: EdgeInsets.all(4.sp),
                    unselectedLabelColor: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: AppointmentTypes.values.map((type) => RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh:  () => Future.sync(
                    () => controller.appointmentsPagingControllers[type.index].refresh(),
              ),
              child: ConnectivityWidget(
                child: PagedListView<int, Appointment>(
                  builderDelegate: PagedChildBuilderDelegate<Appointment>(
                    newPageProgressIndicatorBuilder: (_)=> Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SpinKitFadingCircle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    animateTransitions: true,
                    noItemsFoundIndicatorBuilder: (_)=> Center(
                      child: NoDataWidget(message: "No Appointments Yet!", top: 0),
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                        ),
                    itemBuilder: (context, item, index) => AppointmentCard(
                      appointment: item,
                      index: index,
                    ),
                  ),
                  pagingController: controller.appointmentsPagingControllers[type.index],
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
