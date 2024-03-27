import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityHandler extends GetxController {
  Connectivity connectivity = Connectivity();
  Rx<bool> isOnline = true.obs;
  Function(bool isOnline) connectionChange = (isOnline) {
    // debugPrint('screen event in onInit');
  };
  Future<void> refreshOnline() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    debugPrint('network refreshOnline is called');
    isOnline.value = await _checkConnection(result);
    debugPrint('network refreshOnline : ${isOnline.value}');
  }

  @override
  Future<void> onInit() async {
    refreshOnline();
    debugPrint('network onInit : ${isOnline.value}');
    connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isOnline.value = await _checkConnection(result);
      connectionChange(isOnline.value);
      debugPrint('internet connection is : ${isOnline.value}');

      if (isOnline.isFalse) {
        // Flushbar(
        //   message: 'noInternetConnection'.tr,
        //   icon: const Icon(CupertinoIcons.info_circle,
        //       color: AppColors.primaryColor),
        //   duration: const Duration(seconds: 6),
        // ).show(Get.context!);
      }

      debugPrint('current route: ${Get.currentRoute}');
      if (isOnline.isTrue && Get.currentRoute.isNotEmpty) {
        // Flushbar(
        //   message: 'nowOnline'.tr,
        //   icon: const Icon(CupertinoIcons.checkmark_circle,
        //       color: AppColors.greenColor),
        //   duration: const Duration(seconds: 6),
        // ).show(Get.context!);
      }

      // if (isOnline.isTrue && Get.find<UserSession>().user != null) {
      //   debugPrint('network listen');
      //   initApp();
      //   Get.find<ProfileController>().updateUserBalance();
      // }
    });

    super.onInit();
  }

  Future<bool> _checkConnection(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return await (_updateConnectivityStatus());
    }
  }

  static Future<bool> _updateConnectivityStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {
      isConnected = false;
    }
    return isConnected;
  }
}
