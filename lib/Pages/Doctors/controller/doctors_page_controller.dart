import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Pages/Search/filter_bottom_sheet.dart';
import 'package:careio_doctor_version/Services/Api/doctors.dart';
import 'package:careio_doctor_version/Utils/bottom_sheet_handle.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class DoctorsPageController extends GetxController {
  RxBool isList = true.obs;
  final apiService = Get.find<DoctorsApiService>();
  List<Doctor> doctors = [];
  Position? _position;
  final _pageSize = 10;
  Map<String, dynamic> data = {};
  final PagingController<int, Doctor> pagingController = PagingController(firstPageKey: 0);
  RxBool get isLoading => apiService.isLoading;
  void showFilter() {
    Get.put(BottomSheetController()).showBottomSheet(
        FilterBottomSheet(
            isDoctor: true,
            onTapClearFilter: () {
              clearFilter();
            },
            onTapFilter: (rating, clinic, nearby) {
              filterDoctors(rating: rating, clinicId: clinic, isNearby: nearby);
            }),
        100.h);
  }

  void clearFilter() {
    Get.close(0);
    pagingController.refresh();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void searchDoctors({required String query}) async {
    data.addIf(query.isNotEmpty, "name", query);
    pagingController.refresh();
  }

  void filterDoctors({int? rating, int? clinicId, bool? isNearby}) async {
    debugPrint("Hello $rating $clinicId $isNearby");

    if (isNearby != null) {
      if (isNearby) {
        _position = await _determinePosition();
        debugPrint("Location ${_position?.latitude} ${_position?.longitude}");
      } else {
        _position = null;
        debugPrint("Location ${_position?.latitude} ${_position?.longitude}");
      }
    } else {
      _position = null;
      debugPrint("Location ${_position?.latitude} ${_position?.longitude}");
    }

    data.addIf(clinicId != null, "specialism", clinicId);
    data.addIf(rating != null, "order-by-rating", rating);
    Get.close(0);
    pagingController.refresh();
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchDoctors(pageKey: pageKey, params: data);
    });
    pagingController.refresh();
    super.onInit();
  }

  void refreshDoctors() {}

  void fetchDoctors({required int pageKey, Map<String, dynamic>? params}) async {
    try {
      final doctors = <Doctor>[];
      debugPrint("Fetch doctors");
      final pageSize = pageKey ~/ 10;
      var response = await apiService.fetchDoctors(params: params, pageSize: pageSize == 0 ? 1 : pageSize);
      if (response == null) return;
      data = {};

      for (var doctor in response.data['result']['data']) {
        if(pagingController.itemList == null || pagingController.itemList!.any((element) => element.id == doctor.id)){
        doctors.add(Doctor.fromJson(doctor));
        }
      }
      final isLastPage = doctors.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(doctors);
      } else {
        final nextPageKey = pageKey + doctors.length;
        pagingController.appendPage(doctors, nextPageKey);
      }
    } catch (error) {
        debugPrint("Error in doctors is $error");
      pagingController.error = error;
    }
  }
}
