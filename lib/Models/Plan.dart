import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Plan planFromJson(String str) => Plan.fromJson(json.decode(str));
String planToJson(Plan data) => json.encode(data.toJson());

class Plan {
  Plan({
    int? id,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    double? price,
  }) {
    _id = id;
    _titleAr = titleAr;
    _titleEn = titleEn;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
    _price = price;
  }

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _titleAr = json['titleAr'];
    _titleEn = json['titleEn'];
    _descriptionAr = json['descriptionAr'];
    _descriptionEn = json['descriptionEn'];
    _price = json['price'];
  }
  int? _id;
  String? _titleAr;
  String? _titleEn;
  String? _descriptionAr;
  String? _descriptionEn;
  double? _price;

  int get id => _id ?? 0;
  String get titleAr => _titleAr ?? "";
  String get titleEn => _titleEn ?? "";
  String get descriptionAr => _descriptionAr ?? "";
  String get descriptionEn => _descriptionEn ?? "";
  double get price => _price ?? 0.0;
  String get title => Get.locale == const Locale('en', 'US') ? _titleEn ?? "" : _titleAr ?? "";
  String get description => Get.locale == const Locale('en', 'US') ? _descriptionEn ?? "" : _descriptionAr ?? "";


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['titleAr'] = _titleAr;
    map['titleEn'] = _titleEn;
    map['descriptionAr'] = _descriptionAr;
    map['descriptionEn'] = _descriptionEn;
    map['price'] = _price;
    return map;
  }
}
