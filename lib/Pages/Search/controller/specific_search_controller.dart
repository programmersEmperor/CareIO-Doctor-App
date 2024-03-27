import 'package:careio_doctor_version/Pages/Doctors/controller/doctors_page_controller.dart';
import 'package:careio_doctor_version/Pages/Hospitals/hospitals_ui_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SpecificSearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Lemon',
    'Orange',
    'Peach',
    'Strawberry',
    'Watermelon',
  ];
  bool isDoctor = false;

  RxList<String> filteredData = <String>[].obs;

  late HospitalsUiController hospitalsUiController;
  late DoctorsPageController doctorsPageController;

  @override
  void onInit() {
    filteredData.value = data;
    isDoctor = Get.arguments;
    if (isDoctor) {
      doctorsPageController = Get.find<DoctorsPageController>();
    } else {
      hospitalsUiController = Get.find<HospitalsUiController>();
    }
    super.onInit();
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) return;
    if (isDoctor) {
      doctorsPageController.searchDoctors(query: query);
    } else {
      hospitalsUiController.searchHospital(query: query);
    }
  }
}
