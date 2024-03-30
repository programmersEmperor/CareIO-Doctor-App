import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:get/get.dart';

class ExperiencesApiService {
  final BaseApi _apiService = BaseApi();
  final isLoading = false.obs;

  Future<dynamic> fetchExperiences({required Map<String, dynamic> params}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/experiences',
        params: params,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> createExperience({required Map<String, dynamic> body}) async {
    try {
      isLoading(true);
      var response = await _apiService.postRequest(
        url: '/experiences',
        body: body,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> editExperience({required int id, required Map<String, dynamic> body}) async {
    try {
      isLoading(true);
      var response = await _apiService.postRequest(
        url: '/experiences/update/${id}',
        body: body,
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<dynamic> removeExperience({required int id}) async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/experiences/remove/${id}',
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }
}
