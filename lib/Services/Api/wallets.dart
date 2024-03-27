import 'package:careio_doctor_version/Services/Api/base/base.dart';
import 'package:get/get.dart';

class WalletsApiService {
  final BaseApi _apiService = BaseApi();
  final isLoading = false.obs;

  Future<dynamic> fetchWallets() async {
    try {
      isLoading(true);
      var response = await _apiService.getRequest(
        url: '/patients/wallets',
      );
      isLoading(false);
      return response;
    } catch (e) {
      isLoading(false);
    }
  }
}
