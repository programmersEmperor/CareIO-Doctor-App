import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Services/connectivityService/connectivity_service.dart';

class ConnectivityWidget extends StatelessWidget {
  const ConnectivityWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Get.find<ConnectivityHandler>().isOnline.isTrue
          ? child
          : ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 70.h,
                  child: Padding(
                    padding: EdgeInsets.all(40.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Boxicons.bx_wifi_off,
                          color: AppColors.primaryColor,
                          size: 100.sp,
                        ),
                        Text(
                          AppStrings.connectionErrorDesc.tr,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
