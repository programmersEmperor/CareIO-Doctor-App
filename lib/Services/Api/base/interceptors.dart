import 'package:careio_doctor_version/Localization/localization_helper.dart';
import 'package:careio_doctor_version/Pages/Authentication/introduction.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';

class ApiInterceptors extends Interceptor {
  Future<String> get getFingerprint async => await getFingerPrint();
  late DeviceInfoPlugin deviceInfoPlugin;

  Future<String> getFingerPrint() async {
    deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await deviceInfoPlugin.androidInfo;
    debugPrint("FingerPrint: ${android.fingerprint}${await UniqueIdentifier.serial}");
    return "${android.fingerprint}${await UniqueIdentifier.serial}";
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST [${options.method}] => PATH: ${options.path}');

    options.headers.putIfAbsent('Authorization', () => 'Bearer ${Get.find<UserSession>().token}');
    options.headers['Accept-Language'] = Get.find<LocalizationHelper>().appliedLocale.value!.languageCode;
    options.headers['fingerprint'] = await getFingerprint;
    options.headers['deviceToken'] = Get.find<UserSession>().firebaseDeviceToken;
    options.headers['Content-Type'] = "application/json";
    handler.next(options);

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      debugPrint(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      // Get.snackbar(
      //     'Error ${err.response?.statusCode}',
      //     duration: 5.seconds,
      //     "In Path ${err.requestOptions.path} \n Message : ${err.message}");

      var response;
      if (err.message != null) {
        response = err.message;
      }
      if (err.response != null) {
        response = err.response!.data['message'].toString();
      }

      if (err.response != null && err.response?.statusCode == 401) {
        if (await Get.find<UserSession>().logoutPatient()) {
          Get.offAll(() => const IntroductionPage());
        }
      }

      showSnack(
          title: "Oops ${err.response?.statusCode}",
          description: response.toString());

      super.onError(err, handler);
    } catch (e) {
      showSnack(
          title: "Oops ${err.response?.statusCode}", description: e.toString());
    }
  }
}
