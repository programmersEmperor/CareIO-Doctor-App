import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Services/connectivityService/connectivity_service.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void showSnack({required String title, required String description}) {
  if (Get.find<ConnectivityHandler>().isOnline.isFalse) {
    title = AppStrings.connectionError.tr;
    description = AppStrings.connectionErrorDesc.tr;
  }
  Get.snackbar("", "",
      padding: EdgeInsets.all(10.sp),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: 4.seconds,
      margin: EdgeInsets.zero,
      titleText: Text(
        title,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor),
      ),
      messageText: Text(
        description,
        style: TextStyle(
          fontSize: 10.sp,
        ),
      ));
}
