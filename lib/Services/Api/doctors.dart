import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DoctorsApiService {
  final BaseApi _apiService = BaseApi();

  final isLoading = false.obs;

  Future<dynamic> fetchDoctors(
      {Map<String, dynamic>? params, required int pageSize}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(true);
      });
      var response = await _apiService.getRequest(
        url: '/doctors?page=$pageSize',
        params: params,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
      return response;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading(false);
      });
      debugPrint(e.toString());
    }
  }

  Future<dynamic> showDoctor({required String id}) async {
    try {
      var response = await _apiService.getRequest(url: '/doctors/$id');

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
