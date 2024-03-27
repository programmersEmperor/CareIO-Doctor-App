import 'package:careio_doctor_version/Models/Advertisment.dart';
import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:flutter/material.dart';

class HomeInfo {
  List<Doctor> doctors = [];
  List<HealthCenter> healthCenters = [];
  List<Advertisement> ads = [];

  HomeInfo.fromJson(dynamic json) {
    if (json['doctors'] != null) {
      for (var doctor in json['doctors']) {
        doctors.add(Doctor.fromJson(doctor));
      }
      debugPrint("Doctors ${doctors.length}");
    } else {
      doctors = [];
    }

    if (json['healthCenters'] != null) {
      for (var healthCenter in json['healthCenters']) {
        healthCenters.add(HealthCenter.fromJson(healthCenter));
      }
      debugPrint("healthCenters ${healthCenters.length}");
    } else {
      healthCenters = [];
    }
    if (json['advertisments'] != null) {
      for (var ad in json['advertisments']) {
        ads.add(Advertisement.fromJson(ad));
      }
      debugPrint("ads ${ads.length}");
    } else {
      ads = [];
    }
  }
}
