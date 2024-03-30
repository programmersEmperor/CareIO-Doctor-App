import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Components/SharedWidgets/no_data_widget.dart';
import 'package:careio_doctor_version/Models/Notification.dart' as model;
import 'package:careio_doctor_version/Components/SharedWidgets/page_header.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Pages/Notifications/custom/notification_card.dart';
import 'package:careio_doctor_version/Pages/Notifications/notification_controller.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class NotificationsPage extends StatelessWidget {
  static const id = "/notificationPage";
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController controller = Get.find<NotificationController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        children: [
          PageHeader(heading: AppStrings.notification.tr),
          Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh:  () => Future.sync(
                      () => controller.pagingController.refresh(),
                ),
                child: ConnectivityWidget(
                  child: PagedListView<int, model.Notification>(
                    builderDelegate: PagedChildBuilderDelegate<model.Notification>(
                      firstPageProgressIndicatorBuilder: (_) =>
                          SpinKitFadingCircle(
                            color: AppColors.primaryColor,
                          ),
                      itemBuilder: (context, item, index) => NotificationCard(notification: item),
                    ),
                    pagingController: controller.pagingController,
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
