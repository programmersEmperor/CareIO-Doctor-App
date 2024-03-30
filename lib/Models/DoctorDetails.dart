import 'package:careio_doctor_version/Models/Degree.dart';
import 'package:careio_doctor_version/Models/Experience.dart';
import 'package:careio_doctor_version/Models/HealthCenter.dart';
import 'package:careio_doctor_version/Models/Qualification.dart';
import 'package:careio_doctor_version/Models/Specialism.dart';

class DoctorDetails {
  DoctorDetails({
    required int id,
    required String name,
    required String avatar,
    required dynamic rating,
    required String phone,
    required bool isRecommended,
    required String description,
    required int completedAppointments,
    required Degree degree,
    required Specialism specialism,
    required List<Experience> experience,
    required List<Qualification> qualifications,
  }) {
    _id = id;
    name = name;
    avatar = avatar;
    _rating = rating;
    phone = phone;
    _isRecommended = isRecommended;
    description = description;
    _completedAppointments = completedAppointments;
    degree = degree;
    specialism = specialism;
    _experience = experience;
    _qualifications = qualifications;
  }

  DoctorDetails.fromJson(dynamic json) {
    _id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    _rating = json['rating'];
    phone = json['phone'];
    _isRecommended = json['isRecommended'] == 1;
    description = json['description'];
    _completedAppointments = json['completedAppointments'];
    degree = Degree.fromJson(json['degree']);
    specialism = Specialism.fromJson(json['specialism']);
    if (json['experiences'] != null) {
      _experience = [];
      json['experiences'].forEach((v) {
        _experience?.add(Experience.fromJson(v));
      });
    }
    if (json['qualifications'] != null) {
      _qualifications = [];
      json['qualifications'].forEach((v) {
        _qualifications?.add(Qualification.fromJson(v));
      });
    }
    if (json['healthCenters'] != null) {
      _healthCenters = [];

      json['healthCenters'].forEach((v) {
        _healthCenters?.add(HealthCenter.fromJson(v));
      });
    }
  }
  int? _id;
  late String name;
  String? avatar;
  num? _rating;
  late String phone;
  late bool _isRecommended;
  String? description;
  int? _completedAppointments;
  late Degree degree;
  late Specialism specialism;
  List<Experience>? _experience;
  List<Qualification>? _qualifications;
  List<HealthCenter>? _healthCenters;

  int? get id => _id;
  num? get rating => _rating;
  bool get isRecommended => _isRecommended;
  int? get completedAppointments => _completedAppointments;
  List<Experience> get experience => _experience ?? [];
  List<Qualification>? get qualifications => _qualifications;
  List<HealthCenter> get healthCenters => _healthCenters ?? [];
  int get clinicsTotal  {
    int total = 0;
    for(HealthCenter healthCenter in healthCenters){
      total += healthCenter.clinics.length;
    }
    return total;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = name;
    map['avatar'] = avatar;
    map['rating'] = _rating;
    map['phone'] = phone;
    map['isRecommended'] = isRecommended;
    map['description'] = description;
    map['completedAppointments'] = _completedAppointments;
    map['degree'] = degree.toJson();
    map['specialism'] = specialism.toJson();

    return map;
  }
}
