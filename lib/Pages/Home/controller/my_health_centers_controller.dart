import 'package:careio_doctor_version/Constants/MyHealthCenterTypes.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/WidgetModels/day_time_slot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHealthCentersController extends GetxController with GetTickerProviderStateMixin {

  late TabController tabController;
  RxList<HealthCenter> myConfirmedHealthCenters = <HealthCenter>[].obs;
  RxList<HealthCenter> healthCentersRequests = <HealthCenter>[].obs;
  List<RxBool> isLoading = [false.obs, false.obs];
  RxBool acceptLoading = false.obs;
  RxBool rejectLoading = false.obs;

  final List<Map<String, dynamic>> myHealthCentersFakeData = [
    {
      "id": 1,
      "name": "المستشفى الاوروبي الحديث",
      "address": "الجمهورية اليمنية - صنعاء - شــــــــــارع الستين الغربي",
      "avatar": "https://api.careio.app/storage/HealthCenters/1/47b7KTzXgCKKsOkueUh4mNCuM74vofTiDMl4l9mr.jpg",
      "rating": 4.7658536585366,
      "type": 0,
      "clinics": [
        {
          "id": 14,
          "name": "عيادة العظام",
          "price": 156543,
          "activeTimes": [
            {
              "id": 34,
              "day": 0,
              "from": "06:48:04",
              "to": "07:54:57"
            },
            {
              "id": 37,
              "day": 4,
              "from": "20:00:00",
              "to": "22:00:00"
            },
            {
              "id": 38,
              "day": 4,
              "from": "08:00:00",
              "to": "12:00:00"
            }
          ]
        }
      ]
    },
    {
      "id": 2,
      "name": "مستشفى ازال",
      "address": "الستين الشمالي - نهاية جسر مذبح صنعاء",
      "avatar": "https://api.careio.app/storage/HealthCenters/2/8QYR01LR8WaEr9bN6xfmKz8Nh7vdEbNTYZOkrKMq.jpg",
      "rating": 4.5,
      "type": 0,
      "clinics": [
        {
          "id": 23,
          "name": "عيادة الباطنية",
          "price": 5463,
          "activeTimes": [
            {
              "id": 35,
              "day": 0,
              "from": "08:00:00",
              "to": "11:00:00"
            }
          ]
        }
      ]
    }
  ];

  final List<Map<String, dynamic>> healthCenterRequestsFakeData = [
    {
      "id": 1,
      "name": "المستشفى الاوروبي الحديث",
      "address": "الجمهورية اليمنية - صنعاء - شــــــــــارع الستين الغربي",
      "avatar": "https://api.careio.app/storage/HealthCenters/1/47b7KTzXgCKKsOkueUh4mNCuM74vofTiDMl4l9mr.jpg",
      "rating": 4.7658536585366,
      "type": 0,
      "clinics": [
        {
          "id": 14,
          "name": "عيادة العظام",
          "price": 156543,
          "activeTimes": [
            {
              "id": 34,
              "day": 0,
              "from": "06:48:04",
              "to": "07:54:57"
            },
            {
              "id": 37,
              "day": 4,
              "from": "20:00:00",
              "to": "22:00:00"
            },
            {
              "id": 38,
              "day": 4,
              "from": "08:00:00",
              "to": "12:00:00"
            }
          ]
        }
      ]
    },
    {
      "id": 2,
      "name": "مستشفى ازال",
      "address": "الستين الشمالي - نهاية جسر مذبح صنعاء",
      "avatar": "https://api.careio.app/storage/HealthCenters/2/8QYR01LR8WaEr9bN6xfmKz8Nh7vdEbNTYZOkrKMq.jpg",
      "rating": 4.5,
      "type": 0,
      "clinics": [
        {
          "id": 23,
          "name": "عيادة الباطنية",
          "price": 5463,
          "activeTimes": [
            {
              "id": 35,
              "day": 0,
              "from": "08:00:00",
              "to": "11:00:00"
            }
          ]
        }
      ]
    }
  ];

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    initializeMyHealthCenters();
    super.onInit();
  }

  Future<void> fetchMyConfirmedHealthCenters() async {
    isLoading[MyHealthCenterTypes.confirmed.index](true);
    myConfirmedHealthCenters.value = myHealthCentersFakeData.map((e) => HealthCenter.fromJson(e)).toList();
    isLoading[MyHealthCenterTypes.confirmed.index](false);
  }

  Future<void> fetchHealthCentersRequests() async {
    isLoading[MyHealthCenterTypes.request.index](true);
    healthCentersRequests.value = healthCenterRequestsFakeData.map((e) => HealthCenter.fromJson(e)).toList();
    isLoading[MyHealthCenterTypes.request.index](false);
  }

  Future<void> initializeMyHealthCenters({MyHealthCenterTypes? type}) async {
    if(type == null){
      await fetchMyConfirmedHealthCenters();
      await fetchHealthCentersRequests();
      return;
    }

    if (type == MyHealthCenterTypes.confirmed){
      await fetchMyConfirmedHealthCenters();
      return;
    }

    await fetchHealthCentersRequests();
  }


}