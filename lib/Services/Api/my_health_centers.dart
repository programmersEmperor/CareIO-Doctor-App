import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyHealthCenters {
  final BaseApi _apiService = BaseApi();

  final myHealthCenterIsLoading = false.obs;
  final healthCentersRequestsIsLoading = false.obs;

  Future<dynamic> fetchMyHealthCenters({Map<String, dynamic>? params}) async {
    try {
      myHealthCenterIsLoading(true);
      var response = await _apiService.getRequest(
        url: '/my-health-centers',
        params: params,
      );
      myHealthCenterIsLoading(false);
      return response;
    } catch (e) {
      myHealthCenterIsLoading(false);
      debugPrint(e.toString());
    }
  }

  Future<dynamic> fetchHealthCentersRequests({Map<String, dynamic>? params}) async {
    try {
      healthCentersRequestsIsLoading(true);
      var response = await _apiService.getRequest(
        url: '/health-center-requests',
        params: params,
      );
      healthCentersRequestsIsLoading(false);
      return response;
    } catch (e) {
      healthCentersRequestsIsLoading(false);
      debugPrint(e.toString());
    }
  }

  Future<dynamic> acceptHealthCenterRequest({required int id}) async {
    try {
      myHealthCenterIsLoading(true);
      var response = await _apiService.getRequest(
        url: '/health-centers-requests/accept/${id}',
      );
      myHealthCenterIsLoading(false);
      return response;
    } catch (e) {
      myHealthCenterIsLoading(false);
      debugPrint(e.toString());
    }
  }

  Future<dynamic> cancelHealthCenterRequest({required int id}) async {
    try {
      myHealthCenterIsLoading(true);
      var response = await _apiService.getRequest(
        url: '/health-centers-requests/cancel/${id}',
      );
      myHealthCenterIsLoading(false);
      return response;
    } catch (e) {
      myHealthCenterIsLoading(false);
      debugPrint(e.toString());
    }
  }

}
