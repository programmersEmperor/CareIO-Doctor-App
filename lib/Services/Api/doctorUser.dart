import 'dart:io';

import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';

class DoctorUserApiService {
  final BaseApi _apiService = BaseApi();

  Future<dynamic> update(
      {required String name,
      required File avatar,
        String? phone,
        required String description,
        required int specialismId,
        required int degreeId,
        bool removeAvatar = false,
      }) async {
    try {
      var response = await _apiService.postRequest(
          url: '/update',
          body: dio.FormData.fromMap({
            'name': name,
            'avatar': avatar.path.isNotEmpty
                ? await dio.MultipartFile.fromFile(avatar.path)
                : null,
            'phone': phone,
            'specialismId': specialismId,
            'degreeId': degreeId,
            'description': description,
          }),
          params: removeAvatar ? {"removeAvatar": 1} : null,
      );

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> getDoctorUserData() async {
    try {
      var response = await _apiService.getRequest(
        url: '/auther-data',
      );
      debugPrint('Status Code : ${response.statusCode}');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPlans() async {
    try {
      var response =
          await _apiService.getRequest(url: '/subscription-plans');

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> resetPassword(
      {required String password, required String oldPassword}) async {
    var response = await _apiService.putRequest(
        url: '/resetPassword',
        body: {"oldPassword": oldPassword, "newPassword": password});
    return response;
  }
}
