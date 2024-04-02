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

  RxBool get myConfirmedHealthCentersIsLoading => _apiService.myHealthCenterIsLoading;
  RxBool get healthCentersRequestsIsLoading => _apiService.healthCentersRequestsIsLoading;

  final PagingController<int, HealthCenter> myConfirmedHealthCentersPagingController = PagingController(firstPageKey: 1);
  final PagingController<int, HealthCenter> healthCentersRequestsPagingController = PagingController(firstPageKey: 1);


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
  }

  Future<void> fetchHealthCentersRequests({required int pageKey}) async {
    try{
      final List<HealthCenter> healthCentersRequests =[];
      healthCentersRequestsIsLoading(true);
      var response = await _apiService.fetchHealthCentersRequests(params: {'page': pageKey });
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
      await _apiService.acceptHealthCenterRequest(id: healthCenter.clinics.first.id!);
      healthCentersRequestsPagingController.refresh();
    }
    catch (e){
      throw e;
    }
  }

  Future<void> cancelHealthCenterRequests(HealthCenter healthCenter) async {
    try{
      await _apiService.cancelHealthCenterRequest(id: healthCenter.clinics.first.id!);
      healthCentersRequestsPagingController.refresh();

    }
    catch (e){
      throw e;
    }
  }
}