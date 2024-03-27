import 'package:careio_doctor_version/Components/SharedWidgets/page_header.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/refresh_indicator_widget.dart';
import 'package:careio_doctor_version/Constants/MyHealthCenterTypes.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Home/controller/appointment_controller.dart';
import 'package:careio_doctor_version/Pages/Home/controller/my_health_centers_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/AppointmentsWidget.dart';
import 'package:careio_doctor_version/Pages/Home/custom/MyHealthCentersWidget.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MyHealthCentersPage extends StatelessWidget {
  const MyHealthCentersPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyHealthCentersController controller = Get.put(MyHealthCentersController());
    return Column(
      children: [
        PageHeader(heading: AppStrings.myHealthCenters.tr),
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
                    tabs: [
                      Tab(text: AppStrings.myHealthCenters.tr),
                      Tab(text: AppStrings.newRequests.tr)
                    ],
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
            children: [
              Obx(
                    () => RefreshWidget(
                      onRefresh: () => controller.initializeMyHealthCenters(type: MyHealthCenterTypes.confirmed),
                      isLoading: controller.isLoading[MyHealthCenterTypes.confirmed.index],
                      child: MyHealthCentersWidget(
                          myHealthCenters: controller.myConfirmedHealthCenters,
                          onRefresh: () => controller.initializeMyHealthCenters(type: MyHealthCenterTypes.confirmed),
                          isLoading: controller.isLoading[MyHealthCenterTypes.confirmed.index].value,
                  ),
                ),
              ),
              Obx(
                    () => RefreshWidget(
                      onRefresh: () => controller.initializeMyHealthCenters(type: MyHealthCenterTypes.request),
                      isLoading: controller.isLoading[MyHealthCenterTypes.request.index],
                      child: MyHealthCentersWidget(
                        myHealthCenters: controller.healthCentersRequests,
                        onRefresh: () => controller.initializeMyHealthCenters(type: MyHealthCenterTypes.request),
                        isLoading: controller.isLoading[MyHealthCenterTypes.request.index].value,
                        isRequests: true,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
