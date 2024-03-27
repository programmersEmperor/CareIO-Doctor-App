import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppColors {
  static Color get primaryColor => Theme.of(Get.context!).primaryColor;
  static Color get secondaryColor => Theme.of(Get.context!).cardColor;
  static Color get scaffoldColor =>
      Theme.of(Get.context!).scaffoldBackgroundColor;
}
