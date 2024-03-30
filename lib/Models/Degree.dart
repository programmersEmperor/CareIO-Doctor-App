import 'dart:ui';

import 'package:get/get.dart';

class Degree {
  Degree({
    required int id,
    required String nameAr,
    required String nameEn,
  }) {
    _id = id;
    _nameAr = nameAr;
    _nameEn = nameEn;
  }

  Degree.fromJson(dynamic json) {
    _id = json['id'];
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
  }
  late int _id;
  late String _nameAr;
  late String _nameEn;

  int get id => _id;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get name => Get.locale == const Locale('en', 'US') ? nameEn : nameAr;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    return map;
  }
}
