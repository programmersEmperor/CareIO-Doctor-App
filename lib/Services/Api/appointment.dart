import 'package:careio_doctor_version/Services/Api/base/base.dart';

class AppointmentApiService {
  final BaseApi _apiService = BaseApi();

  Future<dynamic> fetchAppointments({required Map<String, dynamic> params}) async {
    return await _apiService.getRequest(url: '/appointments', params: params);
  }

  Future<dynamic> cancelAppointment({required int id}) async {
    return await _apiService.getRequest(
        url: '/appointments/cancel/$id');
  }

  Future<dynamic> rescheduleAppointment(
      {required int id, required String date, required String time}) async {
    return await _apiService.postRequest(
        url: '/appointments/reschedule/$id',
        body: {'date': date, 'time': time});
  }

  Future<dynamic> rateAppointment(
      {required int id, required int rating}) async {
    return await _apiService.postRequest(
        url: '/appointments/rate/$id', body: {'rating': rating});
  }
}
