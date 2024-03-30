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
    _name = name;
    _avatar = avatar;
    _rating = rating;
    _phone = phone;
    _isRecommended = isRecommended;
    _description = description;
    _completedAppointments = completedAppointments;
    _degree = degree;
    _specialism = specialism;
    _experience = experience;
    _qualifications = qualifications;
  }

  DoctorDetails.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _avatar = json['avatar'];
    _rating = json['rating'];
    _phone = json['phone'];
    _isRecommended = json['isRecommended'] == 1;
    _description = json['description'];
    _completedAppointments = json['completedAppointments'];
    _degree = json['degree'] != null ? Degree.fromJson(json['degree']) : null;
    _specialism = json['specialism'] != null
        ? Specialism.fromJson(json['specialism'])
        : null;
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
  String? _name;
  String? _avatar;
  num? _rating;
  String? _phone;
  late bool _isRecommended;
  String? _description;
  int? _completedAppointments;
  Degree? _degree;
  Specialism? _specialism;
  List<Experience>? _experience;
  List<Qualification>? _qualifications;
  List<HealthCenter>? _healthCenters;

  int? get id => _id;
  String? get name => _name;
  String? get avatar => _avatar;
  num? get rating => _rating;
  String? get phone => _phone;
  bool get isRecommended => _isRecommended;
  String? get description => _description;
  int? get completedAppointments => _completedAppointments;
  Degree? get degree => _degree;
  Specialism? get specialism => _specialism;
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
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['rating'] = _rating;
    map['phone'] = _phone;
    map['isRecommended'] = _isRecommended;
    map['description'] = _description;
    map['completedAppointments'] = _completedAppointments;

    return map;
  }
}
