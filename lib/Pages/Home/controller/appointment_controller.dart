import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Pages/Home/custom/cancel_appointment_confirm_sheet.dart';
import 'package:careio_doctor_version/Pages/Home/custom/rating_bottom_sheet_widget.dart';
import 'package:careio_doctor_version/Pages/Home/custom/reschedule_appointment_sheet.dart';
import 'package:careio_doctor_version/Services/Api/appointment.dart';
import 'package:careio_doctor_version/Services/NotificationService/notification_service_handler.dart';
import 'package:careio_doctor_version/Utils/appointment_enum.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController
    with GetTickerProviderStateMixin {
  late List<Widget> tabs;
  late TabController tabController;
  RxList<Appointment> appointments = <Appointment>[].obs;

  final AppointmentApiService _apiService = Get.find<AppointmentApiService>();

  RxBool cancelLoading = false.obs;
  RxBool ratingLoading = false.obs;

  RxList<Appointment> get upcomingAppointments => appointments
      .where((element) =>
          element.status == 0 || element.status == 2 || element.status == 1)
      .toList()
      .obs;

  RxList<Appointment> get completedAppointments => appointments
      .where((element) => element.status == 5 || element.status == 6)
      .toList()
      .obs;

  RxList<Appointment> get canceledAppointments => appointments
      .where((element) => element.status == 4 || element.status == 3)
      .toList()
      .obs;

  List<int> pages = [1, 1, 1];
  List<RxBool> isLoading = [false.obs, false.obs, false.obs];

  @override
  void onInit() async {
    tabs = [
      Tab(
        text: AppStrings.upcoming.tr,
        //  height: 30.sp,
      ),
      Tab(
        text: AppStrings.completed.tr,
        //    height: 30.sp,
      ),
      Tab(
        text: AppStrings.canceled.tr,
        //    height: 30.sp,
      ),
    ];

    tabController = TabController(length: tabs.length, vsync: this);

    initializeAppointments();

    super.onInit();
  }

  void showRatingBottomSheet({required int appointmentId}) {
    Get.bottomSheet(RatingWidget(
      appointmentId: appointmentId,
    ));
  }

  void rateAppointment(
      {required int appointmentId, required int rating}) async {
    try {
      ratingLoading(true);
      var response =
          await _apiService.rateAppointment(id: appointmentId, rating: rating);
      ratingLoading(false);
      if (response == null) return;

      if (response.data['result'].isEmpty) {
        initializeAppointments(status: AppointmentTypes.completed);

        Get.close(0);
        showSnack(
            title: "Rating posted",
            description: "We appreciate your feedback thank you :)");
      }
    } catch (e) {
      ratingLoading(false);
    }
  }

  Future<void> initializeAppointments({AppointmentTypes? status}) async {
    if (status != null) {
      appointments.removeWhere((element) => status.value.contains(AppointmentStatus.values[element.status]));
      await fetchAppointments(
          loading: isLoading[status.index],
          params: {'page': 1, 'type': status.index + 1});
      return;
    }
    appointments.clear();
    await fetchAppointments(
        loading: isLoading[AppointmentTypes.upcoming.index],
        params: {'page': 1, 'type': 1})
        .whenComplete(() => fetchAppointments(
            loading: isLoading[AppointmentTypes.completed.index],
            params: {'page': 1, 'type': 2})
        .whenComplete(() => fetchAppointments(
            loading: isLoading[AppointmentTypes.canceled.index],
            params: {'page': 1, 'type': 3})));
  }

  Future<List<dynamic>> fetchAppointments(
      {required Map<String, dynamic> params, required RxBool loading}) async {
    loading(true);
    var response = await _apiService.fetchAppointments(params: params);
    loading(false);

    debugPrint("Appointments response $response");
    if (response == null) return [];

    for (var appointment in response.data['result']['data']) {
      appointments.add(Appointment.fromJson(appointment));
    }

    debugPrint(appointments.length.toString());


    return [];
  }

  void confirmCancelAppointment({required int id}) {
    Get.bottomSheet(CancelAppointmentConfirmSheet(
        loading: cancelLoading,
        onTap: () => cancelAppointment(id: id),
        appointment: appointments.where((p0) => id == p0.id).first));
  }

  void confirmRescheduleAppointment({required int id}) {
    Get.bottomSheet(
      RescheduleAppointmentConfirmSheet(
          loading: cancelLoading,
          onTap: (date, time) => rescheduleAppointment(id: id, date: date, time: time),
          appointment: appointments.where((p0) => id == p0.id).first),
      isScrollControlled: true,
    );
  }

  void cancelAppointment({required int id}) async {
    try{
      if (cancelLoading.isTrue) return;

      cancelLoading(true);
      var response = await _apiService.cancelAppointment(id: id);
      cancelLoading(false);
      if (response == null) return;

      if (response.data['result'].isEmpty) {

        appointments.removeWhere((element) => element.id == id);
        initializeAppointments(status: AppointmentTypes.canceled);

        Get.close(0);
        showSnack(title: "Appointment canceled", description: "Your appointment has been canceled");
        NotificationServiceHandler.unscheduleLocalNotification(id);
      }
    }
    catch(e){
      cancelLoading(false);
    }
  }

  void rescheduleAppointment(
      {required int id, required String date, required String time}) async {
    try {
      if (cancelLoading.isTrue) return;

      if (time.isEmpty) {
        showSnack(
            title: "Time not selected",
            description: "Please select a time slot to reschedule");
        return;
      }

      cancelLoading(true);

      var response = await _apiService.rescheduleAppointment(
          id: id, date: date, time: time);
      cancelLoading(false);
      if (response == null) return;

      if (response.data['result'].isEmpty) {
        final AppointmentStatus appointmentStatus = AppointmentStatus.values[appointments.firstWhere((element) => element.id == id).status];
        initializeAppointments(status: AppointmentTypes.upcoming).whenComplete(() {
          if(AppointmentTypes.canceled.value.contains(appointmentStatus)){
            initializeAppointments(status: AppointmentTypes.canceled);
          }
          else if(AppointmentTypes.completed.value.contains(appointmentStatus)){
          initializeAppointments(status: AppointmentTypes.completed);
          }
        });

        Get.close(0);
        showSnack(title: "Appointment Rescheduled", description: "Your appointment has been rescheduled to $date at $time");
        NotificationServiceHandler.unscheduleLocalNotification(id);
      }
    } catch (e) {
      cancelLoading(false);
    }
  }
}
