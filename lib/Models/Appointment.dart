import 'package:careio_doctor_version/Localization/app_strings.dart';
import 'package:careio_doctor_version/Models/Doctor.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Utils/appointment_enum.dart';
import 'package:intl/intl.dart';

/// id : 10
/// status : 10
/// bookedAt : ""
/// patientName : "string"
/// healthCenter : "string"
/// section : "string"
/// clinic : "string"
/// wallet : "string"
/// price : 10.5

class Appointment {
  Appointment({
    required int id,
    required int status,
    required String bookedAt,
    required String patientName,
    required HealthCenter healthCenter,
    required String section,
    required String clinic,
    required String wallet,
    required num price,
  }) {
    _id = id;
    _status = status;
    _bookedAt = bookedAt;
    _patientName = patientName;
    _healthCenter = healthCenter;
    _section = section;
    _clinic = clinic;
    _wallet = wallet;
    _price = price;
  }

  Appointment.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _bookedAt = json['bookedAt'];
    _patientName = json['patientName'];
    _healthCenter = HealthCenter.fromJson(json['healthCenter']);
    _section = json['section'];
    _clinic = json['clinic'] ?? "";
    _wallet = json['wallet'];
    _date = json['date'];
    _rating = json['rating'];
    _time = json['time'];
    _price = json['price'];
    _doctor = Doctor.fromJson(json['doctor']);
    _rejectionMessage = json['rejectionMessage'];
  }
  late int _id;
  late int _status;
  late String _bookedAt;
  late String _patientName;
  late HealthCenter _healthCenter;
  late String _section;
  late String _clinic;
  late String? _wallet;
  late num _price;
  late Doctor _doctor;
  late String _date;
  late String _time;
  late num? _rating;
  late String? _rejectionMessage;

  int get id => _id;
  int get status => _status;
  set status(value) => _status = value;
  String get bookedAt => _bookedAt;
  String get patientName => _patientName;
  HealthCenter get healthCenter => _healthCenter;
  String get section => _section;
  String get clinic => _clinic;
  String get wallet => _wallet ?? "";
  String get date => _date;
  num? get rating => _rating;
  String get time => _time;
  String get time12 {
    DateTime dateTime = DateFormat("HH:mm:ss").parse(_time);
    return DateFormat("h:mm:ss a").format(dateTime);
  }
  num get price => _price;
  Doctor get doctor => _doctor;
  String? get rejectionMessage => _rejectionMessage;

  String get appointmentStatusTitle => AppointmentStatus.values[status].value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['bookedAt'] = _bookedAt;
    map['patientName'] = _patientName;
    map['healthCenter'] = _healthCenter;
    map['section'] = _section;
    map['clinic'] = _clinic;
    map['wallet'] = _wallet;
    map['price'] = _price;
    return map;
  }
}
