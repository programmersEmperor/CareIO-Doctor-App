import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/hospital_card.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/main_category_appbar.dart';
import 'package:careio_doctor_version/Constants/custom_search_bar.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospitals_ui_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class HospitalsPage extends StatelessWidget {
  static const id = "/hospitals";
  const HospitalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    HospitalsUiController controller = Get.put(HospitalsUiController());
    return Scaffold(
      appBar: mainCategoryAppBar(controller, AppStrings.hospitals.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          children: [
            CustomSearchBar(
              title: AppStrings.findYourHospital.tr,
              controller: controller,
              isDoctor: false,
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () =>
                    Future.sync(() => controller.pagingController.refresh()),
                child: ConnectivityWidget(
                  child: PagedListView<int, HealthCenter>(
                    builderDelegate: PagedChildBuilderDelegate<HealthCenter>(
                      firstPageProgressIndicatorBuilder: (_) =>
                          SpinKitFadingCircle(
                        color: AppColors.primaryColor,
                      ),
                      itemBuilder: (context, item, index) => HospitalCard(
                        healthCenter: item,
                      ),
                    ),
                    pagingController: controller.pagingController,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
