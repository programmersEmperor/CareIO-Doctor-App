import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/page_header.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Home/controller/my_health_centers_controller.dart';
import 'package:careio_doctor_version/Pages/Home/custom/my_health_center_card.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
              RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh:  () => Future.sync(
                      () => controller.myConfirmedHealthCentersPagingController.refresh(),
                ),
                child: ConnectivityWidget(
                  child: PagedListView<int, HealthCenter>(
                    builderDelegate: PagedChildBuilderDelegate<HealthCenter>(
                      firstPageProgressIndicatorBuilder: (_) =>
                          SpinKitFadingCircle(
                            color: AppColors.primaryColor,
                          ),
                      itemBuilder: (context, item, index) => MyHealthCenterCard(
                        myHealthCenter: item,
                        index: index,
                      ),
                    ),
                    pagingController: controller.myConfirmedHealthCentersPagingController,
                  ),
                ),
              ),
              RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh:  () => Future.sync(
                      () => controller.healthCentersRequestsPagingController.refresh(),
                ),
                child: ConnectivityWidget(
                  child: PagedListView<int, HealthCenter>(
                    builderDelegate: PagedChildBuilderDelegate<HealthCenter>(
                      firstPageProgressIndicatorBuilder: (_) =>
                          SpinKitFadingCircle(
                            color: AppColors.primaryColor,
                          ),
                      itemBuilder: (context, item, index) => MyHealthCenterCard(
                        myHealthCenter: item,
                        index: index,
                        isRequest: true,
                        onCancel: (HealthCenter healthCenter) async {
                          try{
                            controller.cancelHealthCenterRequests(healthCenter);
                          }
                          catch (e) {
                            throw e;
                          };
                        },
                        onAccept: (HealthCenter healthCenter) async {
                          try{
                            controller.acceptHealthCenterRequests(healthCenter);
                          }
                          catch (e) {
                            throw e;
                          };
                        },
                      ),
                    ),
                    pagingController: controller.healthCentersRequestsPagingController,
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
