import 'package:careio_doctor_version/Constants/MyHealthCenterTypes.dart';
import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/WidgetModels/day_time_slot.dart';
import 'package:careio_doctor_version/Services/Api/my_health_centers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyHealthCentersController extends GetxController with GetTickerProviderStateMixin {

  late TabController tabController;
  final MyHealthCenters _apiService = Get.find<MyHealthCenters>();
  RxList<HealthCenter> myConfirmedHealthCenters = <HealthCenter>[].obs;
  RxList<HealthCenter> healthCentersRequests = <HealthCenter>[].obs;
  // List<RxBool> isLoading = [false.obs, false.obs];


  RxBool get myConfirmedHealthCentersIsLoading => _apiService.myHealthCenterIsLoading;
  RxBool get healthCentersRequestsIsLoading => _apiService.healthCentersRequestsIsLoading;



  final PagingController<int, HealthCenter> myConfirmedHealthCentersPagingController = PagingController(firstPageKey: 1);
  final PagingController<int, HealthCenter> healthCentersRequestsPagingController = PagingController(firstPageKey: 1);


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
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    myConfirmedHealthCentersPagingController.addPageRequestListener((pageKey) {
      fetchMyConfirmedHealthCenters(pageKey: pageKey);
    });
    myConfirmedHealthCentersPagingController.refresh();

    healthCentersRequestsPagingController.addPageRequestListener((pageKey) {
      fetchHealthCentersRequests(pageKey: pageKey);
    });
    healthCentersRequestsPagingController.refresh();


    super.onInit();
  }

  Future<void> fetchMyConfirmedHealthCenters({required int pageKey}) async {
    try{
      final List<HealthCenter> myHealthCenters =[];
      myConfirmedHealthCentersIsLoading(true);
      var response = await _apiService.fetchMyHealthCenters(params: {'page': pageKey });
      myConfirmedHealthCentersIsLoading(false);
      if (response == null) return;
      debugPrint("my healthCenters: ${response.data['result']['data']}");
      for (var healthCenter in response.data['result']['data']) {
        myHealthCenters.add(HealthCenter.fromJson(healthCenter));
      }

      if(response.data['result']['meta']['last_page'] <= pageKey){
        myConfirmedHealthCentersPagingController.appendLastPage(myHealthCenters);
      }
      else{
        myConfirmedHealthCentersPagingController.appendPage(myHealthCenters, pageKey+1);
      }
    }catch(e){
      myConfirmedHealthCentersIsLoading(false);
      debugPrint("Error in healthCenter is $e");
      myConfirmedHealthCentersPagingController.error = e;
    }

    // myConfirmedHealthCentersIsLoading(true);
    // myConfirmedHealthCenters.value = myHealthCentersFakeData.map((e) => HealthCenter.fromJson(e)).toList();
    // myConfirmedHealthCentersIsLoading(false);
  }

  Future<void> fetchHealthCentersRequests({required int pageKey}) async {
    try{
      final List<HealthCenter> healthCentersRequests =[];
      healthCentersRequestsIsLoading(true);
      var response = await _apiService.fetchMyHealthCenters(params: {'page': pageKey });
      healthCentersRequestsIsLoading(false);
      if (response == null) return;
      debugPrint("my health center request: ${response.data['result']['data']}");
      for (var healthCenter in response.data['result']['data']) {
        healthCentersRequests.add(HealthCenter.fromJson(healthCenter));
      }

      if(response.data['result']['meta']['last_page'] <= pageKey){
        healthCentersRequestsPagingController.appendLastPage(healthCentersRequests);
      }
      else{
        healthCentersRequestsPagingController.appendPage(healthCentersRequests, pageKey+1);
      }
    }catch(e){
      healthCentersRequestsIsLoading(false);
      debugPrint("Error in healthCenter is $e");
      healthCentersRequestsPagingController.error = e;
    }
  }

  Future<void> acceptHealthCenterRequests(HealthCenter healthCenter) async {
    try{
      await _apiService.acceptHealthCenterRequest(id: healthCenter.id!);
    }
    catch (e){
      throw e;
    }
  }

  Future<void> cancelHealthCenterRequests(HealthCenter healthCenter) async {
    try{
      await _apiService.cancelHealthCenterRequest(id: healthCenter.id!);
    }
    catch (e){
      throw e;
    }
  }
}