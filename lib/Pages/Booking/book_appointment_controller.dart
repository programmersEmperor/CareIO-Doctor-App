import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/BookAvailableTime.dart';
import 'package:careio_doctor_version/Models/Clinic.dart';
import 'package:careio_doctor_version/Models/DoctorDetails.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/Wallet.dart';
import 'package:careio_doctor_version/Services/Api/book_appintment.dart';
import 'package:careio_doctor_version/Services/Api/doctors.dart';
import 'package:careio_doctor_version/Services/CachingService/user_session.dart';
import 'package:careio_doctor_version/Utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookAppointmentController extends GetxController {
  List<Wallet> wallets = [Wallet(id: -1, nameAr: 'نقدي', nameEn: 'Cash'), ...Get.find<UserSession>().wallets];
  List<BookAvailableTime> times = [];
  List<String> selectedTimes = [];
  Rx<BookAvailableTime> selectedTime = BookAvailableTime().obs;
  GlobalKey<FormBuilderState> key = GlobalKey<FormBuilderState>();
  TextEditingController nameController = TextEditingController();
  DoctorDetails? doctorDetails;

  final BookAppointmentApiService _apiService =
      Get.find<BookAppointmentApiService>();

  RxBool get isLoading => _apiService.isLoading;
  RxBool bookLoading = false.obs;
  RxInt selectedClinicId = (-1).obs;
  RxnDouble selectedClinicPrice = new RxnDouble(null);

  var selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  var day = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString().obs;
  bool nearestAvailableDateSelected = false;


  void handleDayTitle({required DateTime date}) {
    selectDate = DateFormat('yyyy-MM-dd').format(date).toString();
    var _isToday = DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(date);
    debugPrint("is Today $_isToday");
    day(_isToday ? "Today" : DateFormat('yyyy-MM-dd').format(date).toString());
  }

  Future<void> getDoctorDetails({required int id}) async{
    try{
      isLoading(true);
      var response = await Get.find<DoctorsApiService>().showDoctor(id: id.toString());
      if (response == null) return null;
      doctorDetails = DoctorDetails.fromJson(response.data['result']);
      isLoading(false);
    }
    catch(e){
      isLoading(false);
    }
  }

  List<HealthCenter> filterHealthCentersByDay({required List<HealthCenter> healthCenters, required int day, int? clinicId}){
    final List<HealthCenter> filteredHealthCenters = [];
    for(HealthCenter healthCenter in healthCenters){
      final bool succeeded = healthCenter.clinics.any((clinic) {
        if(clinicId == null) return clinic.activeTimes.any((activeTime) => activeTime.day == day);
        else return clinic.id! == clinicId! && clinic.activeTimes.any((activeTime) => activeTime.day == day) ;
      });
      if(succeeded){
        filteredHealthCenters.add(healthCenter);
      }
    }
    return filteredHealthCenters;
  }


  void onTapTime(BookAvailableTime time) {
    selectedTime(time);
    debugPrint(selectedTime.value.time);
    // if (selectedTimes.contains(time.time)) {
    //   selectedTimes.remove(time.time);
    // } else {
    //   selectedTimes.add(time.time);
    // }

    // debugPrint(selectedTimes.length.toString());
  }

  void selectWallet(int index) {
    for (Wallet e in wallets) {
      if (e.id == wallets[index].id) {
        e.selected.value = true;
      } else {
        e.selected.value = false;
      }
    }
  }

  void selectClinic(Clinic clinic, DoctorDetails doctor) {
    selectedClinicId.value = clinic.id!;
    selectedClinicPrice.value = clinic.price == null ? null : clinic.price!.toDouble();
    var date = DateFormat('yyyy-MM-dd').parse(selectDate);
    getTimes(day: date, id: doctor.id!, clinicId: clinic.id!);
  }

  void getTimes({DateTime? day, required int id, required int clinicId}) async {
    times.clear();
    selectedTimes.clear();
    var data = {
      'date': DateFormat('yyyy-MM-dd').format(day ?? DateTime.now()),
      'doctor': id,
      'clinic': clinicId,
    };
    var response = await _apiService.fetchTimes(params: data);
    if (response == null) return;

    for (var time in response.data['result']) {
      times.add(BookAvailableTime.fromJson(time));
    }
  }

  void bookAppointment({
    required int doctorId,
    required int clinicId,
  }) async {
    try {

      final Wallet? wallet = wallets.firstWhereOrNull((wallet) => wallet.selected.isTrue);

      if(selectedTime.value.time == ""){
        showSnack(title: AppStrings.cannotCompleteOperation.tr, description: AppStrings.selectTime.tr);
        return;
      }

      if(wallet == null) {
        showSnack(title: AppStrings.cannotCompleteOperation.tr, description: AppStrings.selectPaymentMethod.tr);
        return;
      };

      if (wallet.id != -1 && !key.currentState!.saveAndValidate()) return;

      var body = {
        "name": nameController.text.isEmpty? Get.find<UserSession>().doctorUser.name : nameController.text,
        "doctorId": doctorId,
        "clinicId": clinicId,
        "time": selectedTime.value.time,
        "date": selectDate,
        if(wallet.id != -1)...{
          "walletId": wallet.id,
          "walletNumber": key.currentState!.value['phone'],
          "paymentCode": key.currentState!.value['code']
        },
      };
      debugPrint(body.toString());

      bookLoading(true);
      var response = await _apiService.bookAppointment(body: body);
      bookLoading(false);
      if (response == null) return;

      debugPrint(response.data['result'].toString());

      if (response.data['result'] is List) {
        selectedClinicId.value = -1;
        selectedClinicPrice.value = null;
        selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

        Get.close(0);
        showSnack(
            title: "Payment completed",
            description:
                "You have booked new appointment in $selectDate at ${selectedTime.value.time}  ");
      }
    } catch (e) {
      bookLoading(false);
      if (selectedTime.value.time.isEmpty) {
        showSnack(
            title: "No time selected",
            description: "you have to pick at least one time ");
        return;
      }

      showSnack(title: "Payment method", description: "Select payment method");

      debugPrint(e.toString());
    }
  }
}
