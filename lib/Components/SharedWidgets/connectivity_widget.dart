import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:flutter/material.dart';
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        AppStrings.connectionErrorDesc.tr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
