import 'dart:developer';

import 'package:careio_doctor_version/Services/BindingService/bindings.dart';
import 'package:careio_doctor_version/Services/connectivityService/connectivity_service.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {

  @override
  void onDetached() {
    log("LifeCycleController onDetached ");
  }

  @override
  void onInactive() {
    log("LifeCycleController onInactive ");
  }

  @override
  void onPaused() {
    log("LifeCycleController OnPaused ");
  }

  @override
  void onResumed() {
    log("LifeCycleController onResumed ");
    Get.find<ConnectivityHandler>().refreshOnline();

    // final bool isConnectivityDeleted = Get.isRegistered<ConnectivityHandler>();
    // if(isConnectivityDeleted){
      // BindingService().dependencies();
    // }
  }
}