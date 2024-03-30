import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookAppointmentApiService {
  final BaseApi _apiService = BaseApi();
  final isLoading = false.obs;

  Future<dynamic> fetchTimes({required Map<String, dynamic> params}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/available-doctor-times',
        params: params,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> bookAppointment({required Map<String, dynamic> body}) async {
    try {
      var response = await _apiService.postRequest(
        url: '/appointments',
        body: body,
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
