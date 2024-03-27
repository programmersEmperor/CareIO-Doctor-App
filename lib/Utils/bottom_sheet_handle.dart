import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomSheetController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController controller;
  void showBottomSheet(Widget child, double maxHeight) {
    controller = BottomSheet.createAnimationController(this);

    controller.duration = 700.milliseconds;

    controller.reverseDuration = 500.milliseconds;

    controller.drive(CurveTween(curve: Curves.ease));
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp))),
      isDismissible: true,
      useSafeArea: true,
      transitionAnimationController: controller,
      constraints: BoxConstraints(maxHeight: maxHeight),
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
