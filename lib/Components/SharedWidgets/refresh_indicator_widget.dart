import 'package:careio_doctor_version/Components/SharedWidgets/connectivity_widget.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RefreshWidget extends StatelessWidget {
  final Widget child;
  final Function onRefresh;
  final RxBool isLoading;
  const RefreshWidget(
      {super.key,
      required this.child,
      required this.onRefresh,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
        onRefresh: () async {
          await onRefresh();
        },
        indicatorBuilder: (_, __) {
          return SpinKitFadingCircle(
            color: AppColors.primaryColor,
            size: 20.0,
          );
        },
        child: Obx(() => isLoading.isTrue
            ? Center(
                child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 40.0,
              ))
            : ConnectivityWidget(child: child)));
  }
}
