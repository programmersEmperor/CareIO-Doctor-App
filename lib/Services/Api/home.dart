import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeApiService {
  final BaseApi _apiService = BaseApi();
  final isLoading = false.obs;

  Future<dynamic> fetchHomeInfo({required Map<String, dynamic> body}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/patients/home',
        params: body,
      );
      isLoading(false);
      debugPrint('Status Code : ${response.statusCode}');
      return response;
    } catch (e) {
      isLoading(false);
    }
  }
}
