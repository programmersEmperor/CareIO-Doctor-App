import 'package:careio_doctor_version/Constants/HealthCenterTypes.dart';
import 'package:careio_doctor_version/Models/ActiveTime.dart';
import 'package:careio_doctor_version/Models/Clinic.dart';
import 'package:careio_doctor_version/Models/Doctor.dart';

class HealthCenter {
  HealthCenter.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'] ?? "";
    _avatar = json['avatar'];
    _rating = json['rating'];
    _completedAppointment = json['completedAppointments'] ?? 0;
    _type = json['type'] is int? HealthCenterTypes.values[json['type'] as int] : null;
    if (json['clinics'] != null) {
      _clinics = [];
      json['clinics'].forEach((v) {
        _clinics.add(Clinic.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      _doctor = [];
      json['doctors'].forEach((v) {
        _doctor.add(Doctor.fromJson(v));
      });
    }
    if (json['activeTimes'] != null) {
      _activeTimes = [];
      json['activeTimes'].forEach((v) {
        _activeTimes?.add(ActiveTimes.fromJson(v));
      });
    }
    print("health center name: ${_name}");
  }
  late int _id;
  late String _name;
  late String _address;
  late int _completedAppointment;
  late HealthCenterTypes? _type;
  String? _avatar;
  num? _rating;
  late List<Clinic> _clinics;
  late List<Doctor> _doctor;


  List<ActiveTimes>? _activeTimes;

  int? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get avatar => _avatar;
  int get completedAppointment => _completedAppointment;
  HealthCenterTypes? get type => _type;
  num? get rating => _rating;


  List<ActiveTimes>? get activeTimes => _activeTimes;
  List<Clinic> get clinics => _clinics;
  List<Doctor> get doctor => _doctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['avatar'] = _avatar;
    map['rating'] = _rating;
    map['completedAppointments'] = _completedAppointment;
    map['type'] = _type;

    if (_activeTimes != null) {
      map['activeTimes'] = _activeTimes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
