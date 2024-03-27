import 'package:careio_doctor_version/Models/ActiveTime.dart';
import 'package:get/get.dart';

class Clinic {
  Clinic({
    int? id,
    String? name,
    String? description,
  }) {
    _id = id;
    _name = name;
    _description = description;
  }

  Clinic.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    if (json['activeTimes'] != null) {
      _activeTimes = [];
      for (var time in json['activeTimes']) {
        _activeTimes!.add(ActiveTimes.fromJson(time));
      }
    } else {
      _activeTimes = [];
    }
  }
  int? _id;
  String? _name;
  num? _price;
  String? _description;
  List<ActiveTimes>? _activeTimes;
  RxBool selected  = false.obs;

  int? get id => _id;
  String? get name => _name;
  num? get price => _price;
  String? get description => _description;
  List<ActiveTimes> get activeTimes => _activeTimes ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }
}
