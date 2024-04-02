import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Appointment.dart';
import 'package:careio_doctor_version/Pages/Home/custom/cancel_appointment_confirm_sheet.dart';
import 'package:careio_doctor_version/Pages/Home/custom/rating_bottom_sheet_widget.dart';
import 'package:careio_doctor_version/Pages/Home/custom/reschedule_appointment_sheet.dart';
import 'package:careio_doctor_version/Services/Api/appointment.dart';
import 'package:careio_doctor_version/Services/NotificationService/notification_service_handler.dart';
import 'package:careio_doctor_version/Constants/appointment_enum.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AppointmentController extends GetxController with GetTickerProviderStateMixin {

  late TabController tabController;
  final AppointmentApiService _apiService = Get.find<AppointmentApiService>();

  final List<PagingController<int, Appointment>> appointmentsPagingControllers = [];
  final List<RxBool> appointmentsPageLoadings = [];


  RxBool cancelLoading = false.obs;
  RxBool ratingLoading = false.obs;


  @override
  void onInit() async {
    tabController = TabController(length: 3, vsync: this);
    initializeControllerPagesAndLoadings();
    super.onInit();
  }

  void initializeControllerPagesAndLoadings(){
    for(AppointmentTypes type in AppointmentTypes.values){

      appointmentsPageLoadings.add(false.obs);

      final PagingController<int, Appointment> pagingController = PagingController(firstPageKey: 1);
      pagingController.addPageRequestListener((pageKey) {
        fetchAppointments(pageKey: pageKey,type: type);
      });
      pagingController.refresh();
      appointmentsPagingControllers.add(pagingController);

    }
  }

  Future<void> fetchAppointments({required int pageKey, required AppointmentTypes type}) async {
    try{
      final List<Appointment> appointments =[];
      appointmentsPageLoadings[type.index](true);
      var response = await _apiService.fetchAppointments(params: {'type': type.index + 1, 'page': pageKey});
      appointmentsPageLoadings[type.index](false);
      if (response == null) return;
      for (var appointment in response.data['result']['data']) {
        appointments.add(Appointment.fromJson(appointment));
      }

      if(response.data['result']['meta']['last_page'] <= pageKey){
        appointmentsPagingControllers[type.index].appendLastPage(appointments);
      }
      else{
        appointmentsPagingControllers[type.index].appendPage(appointments, pageKey+1);
      }
    } catch(e){
      appointmentsPageLoadings[type.index](false);
      debugPrint("Error in healthCenter is $e");
      appointmentsPagingControllers[type.index].error = e;
    }
  }

  void showRatingBottomSheet({required int appointmentId}) {
    Get.bottomSheet(RatingWidget(
      appointmentId: appointmentId,
    ));
  }

  // actions
  void rateAppointment({required int appointmentId, required int rating}) async {
    try {
      ratingLoading(true);
      var response = await _apiService.rateAppointment(id: appointmentId, rating: rating);
      ratingLoading(false);
      if (response == null) return;

      if (response.data['result'].isEmpty) {
        appointmentsPagingControllers[AppointmentTypes.completed.index].refresh();

        Get.close(0);
        showSnack(
            title: "Rating posted",
            description: "We appreciate your feedback thank you :)");
      }
    } catch (e) {
      ratingLoading(false);
    }
  }

  void cancelAppointment({required int id}) async {
    try{
      if (cancelLoading.isTrue) return;

      cancelLoading(true);
      var response = await _apiService.cancelAppointment(id: id);
      cancelLoading(false);
      if (response == null) return;

      if (response.data['result'].isEmpty) {
        appointmentsPagingControllers[AppointmentTypes.canceled.index].refresh();
        appointmentsPagingControllers[AppointmentTypes.upcoming.index].refresh();

        Get.close(0);
        showSnack(title: "Appointment canceled", description: "Your appointment has been canceled");
        // NotificationServiceHandler.unscheduleLocalNotification(id);
      }
    }
    catch(e){
      cancelLoading(false);
    }
  }

  void rescheduleAppointment({required Appointment appointment, required String date, required String time}) async {
    try {
      if (cancelLoading.isTrue) return;

      if (time.isEmpty) {
        showSnack(
            title: "Time not selected",
            description: "Please select a time slot to reschedule");
        return;
      }
      cancelLoading(true);
      var response = await _apiService.rescheduleAppointment(id: appointment.id, date: date, time: time);
      cancelLoading(false);
      if (response == null) return;

      if (response.data['result'].isEmpty) {
        appointmentsPagingControllers[AppointmentTypes.upcoming.index].refresh();
        if(AppointmentTypes.canceled.value.contains(appointment.status)){
          appointmentsPagingControllers[AppointmentTypes.canceled.index].refresh();
        }
        else if (AppointmentTypes.completed.value.contains(appointment.status)){
          appointmentsPagingControllers[AppointmentTypes.completed.index].refresh();
        }

        Get.close(0);
        showSnack(title: "Appointment Rescheduled", description: "Your appointment has been rescheduled to $date at $time");
        // NotificationServiceHandler.unscheduleLocalNotification(appointment.id);
      }
    } catch (e) {
      cancelLoading(false);
    }
  }

  // confirm bottom sheets
  void confirmCancelAppointment({required Appointment appointment}) {
    Get.bottomSheet(CancelAppointmentConfirmSheet(
        loading: cancelLoading,
        onTap: () => cancelAppointment(id: appointment.id),
        appointment: appointment));
  }

  void confirmRescheduleAppointment({required Appointment appointment}) {
    Get.bottomSheet(
      RescheduleAppointmentConfirmSheet(
          loading: cancelLoading,
          onTap: (date, time) => rescheduleAppointment(appointment: appointment, date: date, time: time),
          appointment: appointment),
      isScrollControlled: true,
    );
  }
}
