import 'dart:developer';

import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/WidgetModels/day_time_slot.dart';
import 'package:careio_doctor_version/Pages/Search/filter_bottom_sheet.dart';
import 'package:careio_doctor_version/Services/Api/hospitals.dart';
import 'package:careio_doctor_version/Utils/bottom_sheet_handle.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class HospitalsUiController extends GetxController {
  RxBool isList = true.obs;
  late ScrollController scrollController;
  RxDouble height = 63.h.obs;
  RxBool enableAnimation = false.obs;
  final _pageSize = 10;

  int preSelectedIndex = 0;
  Position? _position;

  final apiService = Get.find<HospitalApiService>();
  List<HealthCenter> healthCenters = [];
  Map<String, dynamic> data = {};

  late HealthCenter healthCenter;
  final PagingController<int, HealthCenter> pagingController =
      PagingController(firstPageKey: 0);
  RxBool get isLoading => apiService.isLoading;
  RxBool profileLoading = true.obs;

  var activeTimeSlotWidget = const Wrap().obs;

  void showFilter() {
    Get.put(BottomSheetController()).showBottomSheet(
        FilterBottomSheet(
          isDoctor: false,
          onTapClearFilter: () {
            clearFilter();
          },
          onTapFilter: (rating, clinic, nearby) => filterHospitals(
              rating: rating, clinicId: clinic, isNearby: nearby),
        ),
        100.h);
  }

  void clearFilter() {
    Get.close(0);
    pagingController.refresh();
  }

  Future<Position> _determinePosition() async {
    debugPrint("mutasim");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!serviceEnabled) {
    //
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void searchHospital({required String query}) async {
    data.addIf(query.isNotEmpty, "name", query);
    pagingController.refresh();
    debugPrint("search");
  }

  void filterHospitals({int? rating, int? clinicId, bool? isNearby}) async {
    debugPrint("Hello $rating $clinicId $isNearby");
    if (isNearby != null) {
      if (isNearby) {
        _position = await _determinePosition();
        data.addIf(_position != null, "longitude", _position?.longitude);
        data.addIf(_position != null, "latitude", _position?.latitude);
      } else {
        _position = null;
        debugPrint("Location ${_position?.latitude} ${_position?.longitude}");
      }
    } else {
      _position = null;
      debugPrint("Location ${_position?.latitude} ${_position?.longitude}");
    }

    data.addIf(clinicId != null, "specilism", clinicId);
    data.addIf(rating != null, "order-by-rating", rating);
    Get.close(0);
    pagingController.refresh();
  }

  List<Wrap> timeslotsWidgets = [];

  final List<DayTimeSlot> dayTimeSlotList = [
    DayTimeSlot('Sat', true.obs),
    DayTimeSlot('Sun', false.obs),
    DayTimeSlot('Mon', false.obs),
    DayTimeSlot('Tue', false.obs),
    DayTimeSlot('Wed', false.obs),
    DayTimeSlot('Thu', false.obs),
    DayTimeSlot('Fri', false.obs),
  ];

  void onTapDayTimeSlot(int index) {
    if (preSelectedIndex == index) return;
    dayTimeSlotList[index].setIsSelected = true;
    dayTimeSlotList[preSelectedIndex].setIsSelected = false;
    activeTimeSlotWidget(timeslotsWidgets[index]);
    preSelectedIndex = index;
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    debugPrint("hospitals_ui_controller");
    pagingController.addPageRequestListener((pageKey) {
      debugPrint("addPageRequestListener");
      fetchHealthCenters(pageKey: pageKey, params: data);
    });

    //activeTimeSlotWidget.value = timeslotsWidgets[0];
    // fetchHealthCenters(isPagination: false);
  }

  void fetchHealthCenters(
      {required int pageKey, Map<String, dynamic>? params}) async {
    try {
      final healthCenters = <HealthCenter>[];

      final pageSize = pageKey ~/ 10;
      debugPrint("Fetch healthCenters and the page is $pageSize and pageKey is $pageKey");
      var response = await apiService.fetchHospitals(params: params, pageSize: pageSize);
      if (response == null) return;

      data = {};

      for (var healthCenter in response.data['result']['data']) {
        if(pagingController.itemList == null || pagingController.itemList!.any((element) => element.id == healthCenter.id)){
          healthCenters.add(HealthCenter.fromJson(healthCenter));
        }
      }
      final isLastPage = healthCenters.length < _pageSize;

      debugPrint("isLastPage: $isLastPage}");
      debugPrint("nextPageKey: ${pagingController.nextPageKey}");
      debugPrint('item lists: ${pagingController.itemList}');

      if (isLastPage) {

        pagingController.appendLastPage(healthCenters);
        // pagingController.appendLastPage(healthCenters);
      }
      else {
        final nextPageKey = pageKey + healthCenters.length;
        debugPrint("The last page is $isLastPage and next page is $nextPageKey");
        pagingController.appendPage(healthCenters, nextPageKey);
      }
    } catch (error) {
      debugPrint("Error in healthCenter is $error");
      pagingController.error = error;
    }
  }

  Future<void> showHealthCenter(String id) async {
    profileLoading(true);
    var response = await apiService.showHospital(id: id);
    profileLoading(false);
    if (response == null) return;

    log(response.toString());
    healthCenter = HealthCenter.fromJson(response.data['result']);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
