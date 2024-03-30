import 'dart:async';

import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Pages/Authentication/introduction.dart';
import 'package:careio_doctor_version/Pages/Home/home_page.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:get/get.dart';

class SplashUiPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(3.seconds, () async {
      Get.find<LocalizationHelper>().appliedLocale(await Get.find<UserSession>().getLocale());
      Get.updateLocale(Get.find<LocalizationHelper>().appliedLocale.value);
      if (await Get.find<UserSession>().getDoctorUser()) {
        Get.offAllNamed(HomePage.id);
      }
      else {
        Get.offAll(() => const IntroductionPage());
      }
    });
  }
}
