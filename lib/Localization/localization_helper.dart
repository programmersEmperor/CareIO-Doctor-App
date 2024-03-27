import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'languages/ar.dart';
import 'languages/en.dart';

class LocalizationHelper extends Translations {
  Rx<Locale> appliedLocale = Get.deviceLocale!.obs;

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en_Us": en,
        "ar_AR": ar,
      };

  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'AR'),
  ];

  void changeLocale(Locale locale) {
    try {
      appliedLocale(locale);
      Get.find<UserSession>().saveLocale(locale);
      Get.updateLocale(locale);
    } catch (e) {
      debugPrint("Change locale error $e");
    }
  }
}
