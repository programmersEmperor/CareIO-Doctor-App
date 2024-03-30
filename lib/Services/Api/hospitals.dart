import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HospitalApiService {
  final BaseApi _apiService = BaseApi();

  final isLoading = false.obs;

  Future<dynamic> fetchHospitals(
      {Map<String, dynamic>? params, required int pageSize}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/health-centers?page=$pageSize',
        params: params,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }

  Future<dynamic> showHospital({required String id}) async {
    try {
      var response =
          await _apiService.getRequest(url: '/health-centers/$id');
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
