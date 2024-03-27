import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// id : 10
/// nameAr : "string"
/// nameEn : "string"

class Specialism {
  Specialism({
    required int id,
    required String nameAr,
    required String nameEn,
  }) {
    _id = id;
    _nameAr = nameAr;
    _nameEn = nameEn;
  }

  Specialism.fromJson(dynamic json) {
    _id = json['id'];
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
  }
  late int _id;
  late String _nameAr;
  late String _nameEn;
  Specialism copyWith({
    required int id,
    required String nameAr,
    required String nameEn,
  }) =>
      Specialism(
        id: id ?? _id,
        nameAr: nameAr ?? _nameAr,
        nameEn: nameEn ?? _nameEn,
      );
  int get id => _id;
  String get nameAr => _nameAr;
  String get nameEn => _nameEn;
  String get name => Get.locale == const Locale('en', 'US') ? _nameEn : _nameAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    return map;
  }
}
