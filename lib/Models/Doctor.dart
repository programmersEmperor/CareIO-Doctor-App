import 'package:careio_doctor_version/Models/Degree.dart';
import 'package:careio_doctor_version/Models/Specialism.dart';

class Doctor {
  Doctor({
    int? id,
    String? name,
    String? avatar,
    num? rating,
    int? completedAppointments,
  }) {
    _id = id;
    _name = name;
    _avatar = avatar;
    _rating = rating;
    _completedAppointments = completedAppointments;
  }

  Doctor.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _avatar = json['avatar'];
    _rating = json['rating'];
    _completedAppointments = json['completedAppointments'];
    if (json['specialism'] != null) {
      _specialism = Specialism.fromJson(json['specialism']);
    }
    if (json['degree'] != null) {
      _degree = Degree.fromJson(json['degree']);
    }
  }
  int? _id;
  String? _name;
  String? _avatar;
  num? _rating;
  int? _completedAppointments;
  Specialism? _specialism;
  Degree? _degree;

  int? get id => _id;
  String? get name => _name;
  String? get avatar => _avatar;
  num? get rating => _rating;
  int? get completedAppointments => _completedAppointments;
  Specialism? get specialism => _specialism;
  Degree? get degree => _degree;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['rating'] = _rating;
    map['completedAppointments'] = _completedAppointments;
    return map;
  }
}
