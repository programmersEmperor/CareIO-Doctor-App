import 'dart:io';

import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';

class PatientApiService {
  final BaseApi _apiService = BaseApi();

  Future<dynamic> update(
      {required String name,
      required File avatar,
        String? phone,
        required String description,
        required int specialismId,
        required int degreeId,
      }) async {
    try {
      var response = await _apiService.postRequest(
          url: '/update',
          body: dio.FormData.fromMap({
            'name': name,
            'avatar': avatar.path.isNotEmpty
                ? await dio.MultipartFile.fromFile(avatar.path)
                : null,
            'specialismId': specialismId,
            'degreeId': degreeId,
            'description': description,
          }));

      return response;
    } catch (e) {
      debugPrint(e.toString());
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
        url: 'patients/resetPassword',
        body: {"oldPassword": oldPassword, "newPassword": password});
    return response;
  }
}
