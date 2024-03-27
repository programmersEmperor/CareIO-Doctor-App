import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationApiService {
  final BaseApi _apiService = BaseApi();
  final isLoading = false.obs;

  Future<dynamic> fetchNotifications(
      {required Map<String, dynamic> params}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/patients/notifications',
        params: params,
      );
      isLoading(false);
      debugPrint('Status Code : ${response.statusCode}');
      return response;
    } catch (e) {
      isLoading(false);
    }
  }
}
