import 'dart:async';
import 'dart:developer';

import 'package:careio_doctor_version/Components/SharedWidgets/timeslot_item.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/ActiveTime.dart';
import 'package:careio_doctor_version/Models/Clinic.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/WidgetModels/day_time_slot.dart';
import 'package:careio_doctor_version/Pages/Booking/book_appointment.dart';
import 'package:careio_doctor_version/Services/Api/doctors.dart';
import 'package:careio_doctor_version/Utils/bottom_sheet_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileUiController extends GetxController {
  late ScrollController scrollController;
  RxDouble height = 63.h.obs;
  RxBool enableAnimation = false.obs;
  late DoctorDetails doctor;
  final apiService = Get.find<DoctorsApiService>();
  RxInt currentSelectedIndex = 0.obs;
  RxBool isLoading = false.obs;

  void showBookingModal() {
    Get.put(BottomSheetController()).showBottomSheet(
        BookAppointment(
          doctor: doctor,
        ),
        100.h);
  }

  final List<DayTimeSlot> dayTimeSlotList = [
    DayTimeSlot('Sun', true.obs),
    DayTimeSlot('Mon', false.obs),
    DayTimeSlot('Tue', false.obs),
    DayTimeSlot('Wed', false.obs),
    DayTimeSlot('Thu', false.obs),
    DayTimeSlot('Fri', false.obs),
    DayTimeSlot('Sat', false.obs),
  ];

  int calculateDoctorExperience(DoctorDetails doctor){
    int experienceTotal = 0;
    for(Experience experience in doctor.experience){
      DateTime from = DateTime.parse(experience.from);
      DateTime to = DateTime.parse(experience.to);
      experienceTotal += (to.difference(from).inDays/365).round();
    }
    return experienceTotal;
  }

  void onTapDayTimeSlot(int index) {
    if (currentSelectedIndex.value == index) return;
    dayTimeSlotList[index].setIsSelected = true;
    dayTimeSlotList[currentSelectedIndex.value].setIsSelected = false;
    currentSelectedIndex(index);
  }

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();
  }

  Future<void> callDoctor() async {
    if (!await launchUrl(Uri.parse('tel:${doctor.phone}'))) {
      throw Exception('Could not launch ');
    }
  }

  List<HealthCenter> filterHealthCentersByDay({required List<HealthCenter> healthCenters, required int day, int? clinicId}){
    final List<HealthCenter> filteredHealthCenters = [];
    for(HealthCenter healthCenter in healthCenters){
      final bool succeeded = healthCenter.clinics.any((clinic) {
        if(clinicId == null) return clinic.activeTimes.any((activeTime) => activeTime.day == day);
        else return clinic.id! == clinicId && clinic.activeTimes.any((activeTime) => activeTime.day == day || (activeTime.day == 0 && day == 7)) ;
      });
      if(succeeded){
        filteredHealthCenters.add(healthCenter);
      }
    }
    return filteredHealthCenters;
  }

  void getData() async {
    await showDoctor();
    onTapDayTimeSlot(0);
  }

  Future<void> showDoctor() async {
    isLoading(true);
    var response = await apiService.showDoctor(id: Get.arguments[0]['index']);
    log(response.data['result'].toString());
    if (response == null) return;
    doctor = DoctorDetails.fromJson(response.data['result']);
    isLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
