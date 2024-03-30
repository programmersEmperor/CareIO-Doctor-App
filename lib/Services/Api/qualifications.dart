import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:get/get.dart';

class QualificationsApiService {
  final BaseApi _apiService = BaseApi();
  final isLoading = false.obs;

  Future<dynamic> fetchQualifications({required Map<String, dynamic> params}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/qualifications',
        params: params,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> createQualifications({required Map<String, dynamic> body}) async {
    try {
      isLoading(true);
      var response = await _apiService.postRequest(
        url: '/qualifications',
        body: body,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> editQualifications({required int id, required Map<String, dynamic> body}) async {
    try {
      isLoading(true);
      var response = await _apiService.postRequest(
        url: '/qualifications/update/${id}',
        body: body,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> removeQualifications({required int id}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/qualifications/remove/${id}',
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }
}
